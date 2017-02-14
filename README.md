# CenteredCollectionView
[![CI Status](http://img.shields.io/travis/BenEmdon/CenteredCollectionView.svg?style=flat)](https://travis-ci.org/BenEmdon/CenteredCollectionView)
[![Version](https://img.shields.io/cocoapods/v/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)
[![codebeat badge](https://codebeat.co/badges/51a89000-13ac-45d7-a468-6edf741d8ce4)](https://codebeat.co/projects/github-com-benemdon-centeredcollectionview)
[![Platform](https://img.shields.io/cocoapods/p/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift 3](https://img.shields.io/badge/Swift-3.0.x-orange.svg?style=flat)](https://swift.org)
[![License](https://img.shields.io/cocoapods/l/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)

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

  // get rid of scrolling indicators
  centeredCollectionView.showsVerticalScrollIndicator = false
  centeredCollectionView.showsHorizontalScrollIndicator = false
}

// delegate and datasource extensions
...

```

## Scrolling to an Edge on Touch 🎡
![scrollToEdgeEnabled](/GitHub/ScrollToEdge.gif)

Heres how you could trigger a scroll animation when a touch happens on an item that isn't the `currentCenteredPage`:

```swift
extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    // if the currentCenteredPage isn't the one that was touched
    if scrollToEdgeEnabled,
    let currentCenteredPage = centeredCollectionView.currentCenteredPage,
    currentCenteredPage != indexPath.row {

      // trigger a scrollTo(index: animated:)
      centeredCollectionView.scrollTo(index: indexPath.row, animated: true)
    }
  }
}
```

## Customize 🖌
You can use all properties inherited from `UICollectionView`.

**CenteredCollectionView specific properties**:

* **`minimumLineSpacing`** amount of space between each cell
  ```Swift
  var minimumLineSpacing: CGFloat { get set }
  // default: 10
  ```

* **`itemSize`** size of each cell. **⚠️ required for use**
  ```Swift
  var itemSize: CGSize { get set }
  ```

* **`currentCenteredPage`** calculates the current centered page/item
  ```Swift
  var currentCenteredPage: Int? { get }
  ```

* **`scrollDirection`** direction of scrolling **(supports vertical)**
  ```Swift
  var scrollDirection: UICollectionViewScrollDirection { get set }
  // default: .horizontal
  ```

* **`scrollTo(index: animated:)`** programatically scrolls to a cell at a specified index.
  ```Swift
  func scrollTo(index: Int, animated: Bool)
  ```

## Requirements ✅
This pod requires a deployment target of iOS 9.0 or greater

## Installation 📲

CenteredCollectionView is available through [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage).

To install it with **Cocoapods**, add the following line to your `Podfile`:
```ruby
pod "CenteredCollectionView"
```

To install it with **Carthage**, add the following line to your `Cartfile`:
```
github "BenEmdon/CenteredCollectionView"
```

## Contributing 💡

All contributions are welcome! If you make a pull request or an issue, you're likely to get a _swift_ response!

## Author 👨‍💻

[@BenEmdon](https://twitter.com/BenEmdon), benjaminemdon@gmail.com

## License 📄

CenteredCollectionView is available under the MIT license. See the LICENSE file for more info.
