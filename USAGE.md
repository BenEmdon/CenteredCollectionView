# Usage

How to install and use this module.

1. [Installation](#installation)
1. Usage
    - [Storyboard Usage](#storyboard-usage)
    - [Programmatic Usage](#programmatic-usage)
1. [Scroll to Edge Effect](#scroll-to-edge-effect)


## Installation

CenteredCollectionView is available through [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage).

To install it with **Cocoapods**, add the following line to your `Podfile`:
```ruby
pod "CenteredCollectionView"
```

To install it with **Carthage**, add the following line to your `Cartfile`:
```
github "BenEmdon/CenteredCollectionView"
```

## Storyboard Usage
1. To start off lets add a `UICollectionView` to our controller, and lay it out however you want it.
  ![AddCollectionView](/.github/AddCollectionView.gif)
1. Next lets set the `UICollectionView`'s custom layout to be `CenteredCollectionViewFlowLayout`.
  ![GiveFlowLayout](/.github/GiveFlowLayout.gif)
1. Next we can optionally layout the prototype item. **Note that this doesn't determine the item's size.**
  ![MakeItemBig](/.github/MakeItemBig.gif)

1. Let's create an example cell subclass that contains the views we want to present.
	Create a new file named "UserCollectionViewCell", with the following code:
	```swift
	class FriendCollectionViewCell: UICollectionViewCell {

	}
	```

	Next, set the prototype item in the Storyboard to subclass from here:
	![User Cell Subclass](/.github/usercellsubclass.gif)

	Finally, add a label to the cell and create a corresponding outlet in the FriendCollectionViewCell.
	(no gif for brevity)

  (Additionally, Make sure the collection view cell reuse identifier is set.)
  ![CellIdentifier](/.github/CellIdentifier.png)

1. Create an `IBOutlet` for the collection view.
  ![IBOutlet](/.github/IBOutlet.gif)

1. Next lets dive in to the code use:
  ```swift
  class ViewController: UIViewController {

  	@IBOutlet weak var collectionView: UICollectionView!

  	// The width of each cell with respect to the screen.
  	// Can be a constant or a percentage.
  	let cellPercentWidth: CGFloat = 0.7

  	// A reference to the `CenteredCollectionViewFlowLayout`.
  	// Must be aquired from the IBOutlet collectionView.
  	var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!

  	override func viewDidLoad() {
  		super.viewDidLoad()

  		// Get the reference to the `CenteredCollectionViewFlowLayout` (REQURED STEP)
  		centeredCollectionViewFlowLayout = collectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout

  		// Modify the collectionView's decelerationRate (REQURED STEP)
  		collectionView.decelerationRate = UIScrollViewDecelerationRateFast

  		// Assign delegate and data source
  		collectionView.delegate = self
  		collectionView.dataSource = self

  		// Configure the required item size (REQURED STEP)
  		centeredCollectionViewFlowLayout.itemSize = CGSize(
  			width: view.bounds.width * cellPercentWidth,
  			height: view.bounds.height * cellPercentWidth * cellPercentWidth
  		)

  		// Configure the optional inter item spacing (OPTIONAL STEP)
  		centeredCollectionViewFlowLayout.minimumLineSpacing = 20

  		// Get rid of scrolling indicators
  		collectionView.showsVerticalScrollIndicator = false
  		collectionView.showsHorizontalScrollIndicator = false
  	}
  }
  ```

  As with any `UICollectionView`, you'll also need to conform to the `UICollectionViewDelegate` and `UICollectionViewDataSource` protocols, as follows:

  ```swift

  // Here's an example model we'll use.
  struct User {
  	var name: String
  }

  class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

  	// ... properties as before

  	// Instance of our example data model
  	var users = [User]()


  	override func viewDidLoad() {

  		// ...

  		// Flush the model with some example data
  		users.append(User("User1"))
  		users.append(User("User2"))
  		users.append(User("User3"))
  	}


  	// MARK: UICollectionViewDelegate

  	// Now, we'll conform to the delegates that we promised in the viewDidLoad earlier

  	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  		return users.count
  	}

  	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

  		// Grab our cell from dequeueReusableCell, wtih the same identifier we set in our storyboard.
  		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserCollectionViewCell

  		// Error checking, if our cell is somehow not able to be cast
  		guard let userCell = cell else {
  			print("Unable to instantiate user cell at index \(indexPath.row)")
  			return cell
  		}

  		// Give the current cell the corresponding data it needs from our model
  		userCell.label.text = users[indexPath.row].name
  		return userCell
  	}

  }

  ```

## Programmatic Usage
```Swift
class ViewController: UIViewController {

  let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()
  let collectionView: UICollectionView

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    // Initialize the collectonView with the `CenteredCollectionViewFlowLayout` (REQUIRED STEP)
    collectionView = UICollectionView(centeredCollectionViewFlowLayout: centeredCollectionViewFlowLayout)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Assign delegate and data source
    collectionView.delegate = self
    collectionView.dataSource = self

    // Layout subviews (not shown)
    ...

    // Register collection cells (REQUIRED STEP)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))

    // Configure the required item size (REQURED STEP)
    centeredCollectionViewFlowLayout.itemSize = CGSize(
      width: view.bounds.width * cellPercentWidth,
      height: view.bounds.height * cellPercentWidth * cellPercentWidth
    )

    // Configure the optional inter item spacing (OPTIONAL STEP)
    centeredCollectionViewFlowLayout.minimumLineSpacing = 20

    // Get rid of scrolling indicators
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
  }
}

// Delegate and datasource extensions
...

```

## Scroll to Edge Effect
![scrollToEdgeEnabled](/.github/ScrollToEdge.gif)

_Scrolling to an Edge on Touch 🎡_

Heres how you could trigger a scroll animation when a touch happens on an item that isn't the `currentCenteredPage`:

```swift
extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    // check if the currentCenteredPage is not the page that was touched
    let currentCenteredPage = centeredCollectionViewFlowLayout.currentCenteredPage
    if currentCenteredPage != indexPath.row {
      // trigger a scrollToPage(index: animated:)
      centeredCollectionViewFlowLayout.scrollToPage(index: indexPath.row, animated: true)
    }
  }
}
```
