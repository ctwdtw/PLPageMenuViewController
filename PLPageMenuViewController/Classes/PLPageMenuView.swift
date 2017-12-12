//
//  PLPageMenuView.swift
//  HealthToAllFlesh
//
//  Created by Paul Lee on 17/03/2017.
//  Copyright © 2017 Paul Lee. All rights reserved.
//

import UIKit
import Reusable

extension PLPageMenuView: NibOwnerLoadable {}

public struct PLPageMenuViewParameter {
  var itemNames: [String] = []
  var backgroundColor = UIColor.red
  var itemColor = UIColor.white
  var indicatorColor = UIColor.gray
  
  public init(itemNames: [String],
              itemColor: UIColor,
              backgroundColor: UIColor,
              indicatorColor: UIColor) {
    self.itemNames = itemNames
    self.itemColor = itemColor
    self.backgroundColor = backgroundColor
    self.indicatorColor = indicatorColor
  }
  
  public init() {}
}

class PLPageMenuView: UIView {
  @IBOutlet weak var pageIndicatorLeading: NSLayoutConstraint!
  @IBOutlet weak var pageIndicatorWidth: NSLayoutConstraint!
  @IBOutlet weak var ItemViewContainer: UIStackView!
  var delegateVC: PLMenuViewDelegate?

  private(set) var numberOfSlice: Int = 0 {
    didSet {
      layoutSubviews()
    }
  }

  var itemNames: [String] = [] {
    willSet {
      numberOfSlice = newValue.count
    }
  }
  
  var itemColor = UIColor.white

  override func layoutSubviews() {
    super.layoutSubviews()
    layoutPageIndicator()
    layoutMenuItems()
  }

  private func layoutPageIndicator() {
    pageIndicatorWidth.constant = frame.size.width / CGFloat(numberOfSlice)
    layoutIfNeeded()
  }

  private func layoutMenuItems() {
    guard ItemViewContainer.arrangedSubviews.count == 0 else {
      return
    }

    for (idx, itemName) in itemNames.enumerated() {
      let button = UIButton()
      button.setTitle(itemName, for: .normal)
      button.titleLabel?.textAlignment = .center
      button.setTitleColor(itemColor, for: .normal)
      button.tag = idx
      button.addTarget(self, action: #selector(self.itemBtnDidPressed(_:)), for: .touchUpInside)
      ItemViewContainer.addArrangedSubview(button)
    }
  }

  @objc private func itemBtnDidPressed(_ sender: UIButton) {
    delegateVC?.scrollToPage(page: sender.tag, animated: true)
  }

  func scrollPageIndicator( for offset: CGFloat) {
    pageIndicatorLeading.constant = offset
    layoutIfNeeded()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.loadNibContent()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.loadNibContent()
  }
}
