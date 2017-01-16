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
  // implement the delegate and data source as you would a UICollectionView
  centeredCollectionView.delegate = self
  centeredCollectionView.dataSource = self

  // layout subviews (not shown)
  ...

  // register collection cells
  centeredCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))

  // configure centeredCollectionView properties
  centeredCollectionView.itemSize = CGSize(width: 100, height: 100)
  centeredCollectionView.minimumLineSpacing = 20
  centeredCollectionView.scrollToEdgeEnabled = true

  // get rid of scrolling indicators
  centeredCollectionView.showsVerticalScrollIndicator = false
  centeredCollectionView.showsHorizontalScrollIndicator = false
}
```

## Customize 🖌
You can use all properties inherited from `UICollectionView`.

**CenteredCollectionView specific properties**:

* **minimumLineSpacing** amount of space between each cell
  ```Swift
  var minimumLineSpacing: CGFloat { get set }
  // default: 10
  ```

* **itemSize** size of each cell (⚠️ required)
  ```Swift
  var itemSize: CGSize { get set }
  ```

* **scrollDirection** direction of scrolling **(supports vertical)**
  ```Swift
  var scrollDirection: UICollectionViewScrollDirection { get set }
  // default: .horizontal
  ```

* **scrollToEdgeEnabled** if `true` will scroll on touch to the edge of the cell that is peeking out from a side (wont trigger delegate `didSelectItemAt indexPath:` events)
  ```Swift
  var scrollToEdgeEnabled: Bool { get set }
  // default: false
  ```
  ![scrollToEdgeEnabled](/GitHub/ScrollToEdge.gif)

* **scrollTo(index: animated:)** programatically scrolls to a cell at a specified index.
  ```Swift
  func scrollTo(index: Int, animated: Bool)
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
