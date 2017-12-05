//
//  ViewController.swift
//  PLPageMenuViewController
//
//  Created by ctwdtw on 12/05/2017.
//  Copyright (c) 2017 ctwdtw. All rights reserved.
//

import UIKit
import PLPageMenuViewController

class ViewController: PLPageMenuViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    configurePages()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func configurePages() {
    let navigationItemTitle = "I have a Navigation Item"
    let itemNames = ["RedVC", "GreenVC", "BlueVC"]
    
    let redVC = UIViewController()
    redVC.view.backgroundColor = .red
    let greenVC = UIViewController()
    greenVC.view.backgroundColor = .green
    let blueVC = UIViewController()
    blueVC.view.backgroundColor = .blue
    
    let vcs = [redVC, greenVC, blueVC]
    
    let parameter = PLPageParameters(navigationItemTitle: navigationItemTitle,
                                     pageItemNames: itemNames,
                                     viewControllers: vcs)
    setPageParameters(parameter)
  }
}

