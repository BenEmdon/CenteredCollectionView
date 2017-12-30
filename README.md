# CenteredCollectionView
[![CI Status](http://img.shields.io/travis/BenEmdon/CenteredCollectionView.svg?style=flat)](https://travis-ci.org/BenEmdon/CenteredCollectionView.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift 3](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)](https://swift.org)
[![License](https://img.shields.io/cocoapods/l/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)

`CenteredCollectionView` is a lightweight drop in place `UICollectionViewFlowLayout` that _pages_ and keeps its cells centered, resulting in the _"carousel effect"_ 🎡

## Example 📱

![Demo](/GitHub/demo.gif)

To try the example using Cocoapods:
```bash
pod try CenteredCollectionView
```

## Usage 🛠
```Swift
let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()
let collectionView: UICollectionView

override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
  collectionView = UICollectionView(centeredCollectionViewFlowLayout: centeredCollectionViewFlowLayout)
  super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
}

...

override func viewDidLoad() {
  super.viewDidLoad()

  // implement the delegate and dataSource
  collectionView.delegate = self
  collectionView.dataSource = self

  // layout subviews (not shown)
  ...

  // register collection cells
  collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))

  // configure CenteredCollectionViewFlowLayout properties
  centeredCollectionViewFlowLayout.itemSize = CGSize(width: 100, height: 100)
  centeredCollectionViewFlowLayout.minimumLineSpacing = 20

  // get rid of scrolling indicators
  collectionView.showsVerticalScrollIndicator = false
  collectionView.showsHorizontalScrollIndicator = false
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

    // check if the currentCenteredPage is not the page that was touched
    let currentCenteredPage = centeredCollectionViewFlowLayout.currentCenteredPage,
    			currentCenteredPage != indexPath.row {
      // trigger a scrollTo(index: animated:)
      centeredCollectionView.scrollTo(index: indexPath.row, animated: true)
    }
  }
}
```

## Customize 🖌
You can use all properties inherited from `UICollectionView`.

**CenteredCollectionViewFlowLayout specific properties**:

* **`minimumLineSpacing`** amount of space between each cell
  ```Swift
  var minimumLineSpacing: CGFloat { get set }
  // default: 10
  ```

* **`itemSize`** size of each cell. **⚠️ required for use**
  ```Swift
  var itemSize: CGSize { get set }
  ```

* **`currentCenteredPage`** calculates the current centered page
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

[@BenEmdon](https://twitter.com/BenEmdon)

## License 📄

CenteredCollectionView is available under the MIT license. See the LICENSE file for more info.
