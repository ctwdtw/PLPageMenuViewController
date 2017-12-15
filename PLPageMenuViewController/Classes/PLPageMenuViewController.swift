//
//  PLPageMenuViewController.swift
//  HealthToAllFlesh
//
//  Created by Paul Lee on 15/03/2017.
//  Copyright © 2017 Paul Lee. All rights reserved.
//

import UIKit
import Reusable

extension PLPageMenuViewController: NibOwnerLoadable {}

protocol PLMenuViewDelegate: class {
  func scrollToPage(page: Int, animated: Bool)
}

public struct PLPageParameters {
  var navigationItemTitle = ""
  var menuViewParameter = PLPageMenuViewParameter()
  var viewControllers: [UIViewController] = []
  
  public init(navigationItemTitle: String,
              menuViewParameter: PLPageMenuViewParameter,
              viewControllers: [UIViewController]) {
    self.navigationItemTitle = navigationItemTitle
    self.menuViewParameter = menuViewParameter
    self.viewControllers = viewControllers
  }
}

open class PLPageMenuViewController: UIViewController {
    private var contentCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
      
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
    collectionView.isPagingEnabled = true
    return collectionView
  }()
  
  private var menuView: PLPageMenuView = {
    let menuView = PLPageMenuView()
    return menuView
  }()
  
  private var navigationItemTitle = ""
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder) //add this line to load segue mechanism from storyboard
    //loadRootViewFromNib() //TODO:// add nibBased protocol for UIViewController in `Reuseable` Pod
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    //TODO:// use other method to fix rotation bug
    //edgesForExtendedLayout = [.bottom, .left, .right]
    assemblingSubviews()
    configureSubviews()
  }
  
  open func configurePages() {
    fatalError("Must Override")
  }
  
  public func setPageParameters(_ parameter: PLPageParameters) {
    navigationItemTitle = parameter.navigationItemTitle
    menuView.itemNames = parameter.menuViewParameter.itemNames
    menuView.subviews.first?.backgroundColor = parameter.menuViewParameter.backgroundColor
    menuView.subviews.first?.subviews.first?.backgroundColor = parameter.menuViewParameter.indicatorColor
    menuView.itemColor = parameter.menuViewParameter.itemColor
    setChildViewControllers(parameter.viewControllers)
  }
  
  private func configureSubviews() {
    //menuView
    menuView.delegateVC = self
    
    //contentCollectionView
    contentCollectionView.register(cellType: PLPageMenuContentViewCell.self)
    contentCollectionView.dataSource = self
    contentCollectionView.delegate = self
  }
  
  private func assemblingSubviews() {
    //menuView
    view.addSubview(menuView)
    menuView.translatesAutoresizingMaskIntoConstraints = false
    menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    menuView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    menuView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    //contentCollectionView
    view.addSubview(contentCollectionView)
    contentCollectionView.translatesAutoresizingMaskIntoConstraints = false
    contentCollectionView.topAnchor.constraint(equalTo: menuView.bottomAnchor).isActive = true
    contentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    contentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    contentCollectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
  }
  
  private func showNavigationTitle() {
    navigationItem.title = navigationItemTitle
  }
  
  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    showNavigationTitle()
  }
  
  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    contentCollectionView.collectionViewLayout.invalidateLayout()
  }
  
  open override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let index = childViewControllers.index(of: self.currentViewController)
    self.scrollToPage(page: index!, animated: false)
  }
  
  private var currentViewController: UIViewController! {
    willSet {
      guard let vc = newValue.self else {
        return
      }
      #if DEBUG
      print("currentViewContrller is \(vc) )")
      #endif
    }
    
    didSet {
      guard let vc = oldValue.self else {
        return
      }
      #if DEBUG
      print("previousViewController is \(vc)")
      #endif
    }
  }
  
  private func setChildViewControllers(_ childVCs: [UIViewController]) {
    for (idx, vc) in childVCs.enumerated() {
      addChildViewController(vc)
      vc.didMove(toParentViewController: self)
      vc.navigationItem.title = menuView.itemNames[idx]
    }
    
    currentViewController = childViewControllers.first
  }
  
  private func render(_ viewController: UIViewController, in view: UIView) {
    guard let subView = viewController.view else {
      return
    }
    subView.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
    view.addSubview(subView)
  }
  
  private func updateMenuViewWhenScrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.x / CGFloat(childViewControllers.count)
    menuView.scrollPageIndicator(for: offset)
  }
  
  private var willDispalyIndex: IndexPath?
  private var didEndDispayIndex: IndexPath?
  
  private func checkMoving() {
    guard let nextVCIndex = willDispalyIndex?.item,
      let previousVCIndex = didEndDispayIndex?.item,
      nextVCIndex != previousVCIndex else {
        #if DEBUG
        print("bounceback")
        #endif
        return
    }
    
    let previousVC = childViewControllers[previousVCIndex]
    let nextVC = childViewControllers[nextVCIndex]
    
    didMove(from: previousVC, to: nextVC)
  }
  
  private func didMove(from previousViewController: UIViewController, to nextViewController: UIViewController) {
    currentViewController = nextViewController
  }
}

extension PLPageMenuViewController: PLMenuViewDelegate {
  func scrollToPage(page: Int, animated: Bool = true) {
    let indexPath = IndexPath(item: page, section: 0)
    contentCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
  }
}

extension PLPageMenuViewController: UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateMenuViewWhenScrollViewDidScroll(scrollView)
  }
}

extension PLPageMenuViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    didEndDispayIndex = indexPath
    checkMoving()
  }
  
  public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    willDispalyIndex = indexPath
  }
}

extension PLPageMenuViewController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return childViewControllers.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell: PLPageMenuContentViewCell = collectionView.dequeueReusableCell(for: indexPath)
    configure(cell, for: indexPath)
    
    return cell
  }
  
  private func configure(_ cell: UICollectionViewCell, for indexPath: IndexPath) {
    guard let cell = cell as? PLPageMenuContentViewCell else {
      fatalError("wrong Type Cell")
    }
    
    let childViewController = childViewControllers[indexPath.row]
    render(childViewController, in: cell.contentView)
    
    #if DEBUG
    cell.debuglabel.text = "\(indexPath.item)"
    cell.addDebugLabelToContentView()
    cell.contentView.bringSubview(toFront: cell.debuglabel)
    #endif
  }
}

extension PLPageMenuViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = contentCollectionView.frame.size
    return size
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
