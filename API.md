## CenteredCollectionViewFlowLayout API
You can use all properties inherited from `UICollectionViewFlowLayout`.

**CenteredCollectionViewFlowLayout specific properties**:

* **`currentCenteredPage`** calculates the current centered page
  ```Swift
  var currentCenteredPage: Int? { get }
  ```

* **`scrollDirection`** direction of scrolling **(supports vertical)**
  ```Swift
  var scrollDirection: UICollectionView.ScrollDirection { get set }
  // default: .horizontal
  ```

* **`scrollTo(index: animated:)`** programmatically scrolls to a item at a specified index.
  ```Swift
  func scrollTo(index: Int, animated: Bool)
  ```
