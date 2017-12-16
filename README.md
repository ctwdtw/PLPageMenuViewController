# PLPageMenuViewController

<!---[![CI Status](http://img.shields.io/travis/ctwdtw/PLPageMenuViewController.svg?style=flat)](https://travis-ci.org/ctwdtw/PLPageMenuViewController)-->
[![Version](https://img.shields.io/cocoapods/v/PLPageMenuViewController.svg?style=flat)](http://cocoapods.org/pods/PLPageMenuViewController)
[![License](https://img.shields.io/cocoapods/l/PLPageMenuViewController.svg?style=flat)](http://cocoapods.org/pods/PLPageMenuViewController)
[![Platform](https://img.shields.io/cocoapods/p/PLPageMenuViewController.svg?style=flat)](http://cocoapods.org/pods/PLPageMenuViewController)

## Description

PLPageMenuViewController is simple UI component enable primary paging effect between view controllers. 
The paging effect is resort to UICollectionView's animation effect.

## Demo
![Alt text](https://github.com/ctwdtw/PLPageMenuViewController/blob/master/Example/PLPageMenuVC%20.gif?raw=true)

## Usage

First, subclass the widget and assign the necessary parameters such as child view controllers, color and item names in the `viewDidLoad` method:

```Swift
class MYViewController: PLPageMenuViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //prepare child view controllers:
    let redVC = UIViewController()
    redVC.view.backgroundColor = .red
    let greenVC = UIViewController()
    greenVC.view.backgroundColor = .green
    let blueVC = UIViewController()
    blueVC.view.backgroundColor = .blue
    let vcs = [redVC, greenVC, blueVC]
    
    //item names shown on widges
    let itemNames = ["RedVC", "GreenVC", "BlueVC"]
    
    //if you use your view controller inside a navigation controller, 
    //you may want to assign the title of navigation item also
    let navigationItemTitle = "I have a Navigation Item"
    
    //set necessary parameters
    let menuViewSetting = PLPageMenuViewParameter(itemNames: itemNames,
                                                  itemColor: .green,
                                                  backgroundColor: .gray,
                                                  indicatorColor: .yellow)
    
    let parameter = PLPageParameters(navigationItemTitle: navigationItemTitle,
                                     menuViewParameter: menuViewSetting,
                                     viewControllers: vcs)
    setPageParameters(parameter)

  }
```
then assign your ViewController's `Class` field in Storyboard as `MYViewController`, that's it.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Swift 4.0 +
* iOS 9.0 +

## Installation

PLPageMenuViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PLPageMenuViewController'
```

## Author

ctwdtw, ctwdtw@gmail.com

## License

PLPageMenuViewController is available under the MIT license. See the LICENSE file for more info.
