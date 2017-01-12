# CenteredCollectionView

[![CI Status](http://img.shields.io/travis/BenEmdon/CenteredCollectionView.svg?style=flat)](https://travis-ci.org/BenEmdon/CenteredCollectionView)
[![Version](https://img.shields.io/cocoapods/v/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)
[![License](https://img.shields.io/cocoapods/l/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)
[![Swift 3](https://img.shields.io/badge/Swift-3.0.x-orange.svg?style=flat)](https://swift.org)

`CenteredCollectionView` is a lightweight drop in place `UICollectionView` that _pages_ and keeps its cells centered, resulting in the _"carousel effect"_ 🎡

## Example 📱

![Demo](/GitHub/demo.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage 🛠
Use just as you would use a `UICollectionView`
```Swift
let centeredCollectionView = CenteredCollectionView()

override func viewDidLoad() {
  super.viewDidLoad()

  // delegate & data source
  centeredCollectionView.delegate = self
  centeredCollectionView.dataSource = self

  // layout subviews (not shown)
  ...

  // register collection cells
  centeredCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))

  // configure centeredCollectionView layout
  centeredCollectionView.itemSize = CGSize(width: 100, height: 100)
  centeredCollectionView.minimumLineSpacing = 20
  centeredCollectionView.showsVerticalScrollIndicator = false
  centeredCollectionView.showsHorizontalScrollIndicator = false
  centeredCollectionView.scrollToEdgeEnabled = true
}
```


## Requirements ✅
This pod requires a deployment target of iOS 9.0 or greater

## Installation 📲

CenteredCollectionView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CenteredCollectionView"
```

## Author 👨‍💻

[@BenEmdon](https://twitter.com/BenEmdon), benjaminemdon@gmail.com

## License 📄

CenteredCollectionView is available under the MIT license. See the LICENSE file for more info.
