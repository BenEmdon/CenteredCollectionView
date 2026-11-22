import UIKit
import XCTest
@testable import CenteredCollectionView

class Tests: XCTestCase {

	let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()
	var collectionView: UICollectionView!
	let expectedItemDimension: CGFloat = 80
	let expectedLineSpacing: CGFloat = 20
	let expectedFrameDimension: CGFloat = 300

	override func setUp() {
		super.setUp()
		// This method is called before the invocation of each test method in the class.
		collectionView = UICollectionView(
			frame: CGRect(
				x: 0,
				y: 0,
				width: expectedFrameDimension,
				height: expectedFrameDimension
			),
			centeredCollectionViewFlowLayout: centeredCollectionViewFlowLayout
		)

		centeredCollectionViewFlowLayout.itemSize = CGSize(width: expectedItemDimension, height: expectedItemDimension)
		centeredCollectionViewFlowLayout.minimumLineSpacing = expectedLineSpacing
	}

	func testDefaultValuesNoFrame() {
		let expectedItemDimension: CGFloat = 50
		let expectedLineSpacing: CGFloat = 10
		let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()
		let collectionView = UICollectionView(centeredCollectionViewFlowLayout: centeredCollectionViewFlowLayout)
		centeredCollectionViewFlowLayout.invalidateLayout()
		// public
		XCTAssertEqual(centeredCollectionViewFlowLayout.scrollDirection, .horizontal)
		XCTAssertEqual(
			centeredCollectionViewFlowLayout.itemSize, CGSize(width: expectedItemDimension, height: expectedItemDimension)
		)
		XCTAssertEqual(centeredCollectionViewFlowLayout.minimumLineSpacing, expectedLineSpacing)
		XCTAssertEqual(collectionView.contentOffset.y, 0)
		XCTAssertEqual(collectionView.contentOffset.x, 0)
		// internal
		XCTAssertEqual(centeredCollectionViewFlowLayout.pageWidth, expectedItemDimension + expectedLineSpacing)
	}

	func testDefaultValuesWithFrameHorizontal() {
		// public
		centeredCollectionViewFlowLayout.invalidateLayout()
		XCTAssertEqual(centeredCollectionViewFlowLayout.scrollDirection, .horizontal)
		XCTAssertEqual(
			centeredCollectionViewFlowLayout.itemSize, CGSize(width: expectedItemDimension, height: expectedItemDimension)
		)
		XCTAssertEqual(centeredCollectionViewFlowLayout.minimumLineSpacing, expectedLineSpacing)
		XCTAssertEqual(collectionView.contentOffset.y, 0)
		XCTAssertEqual(collectionView.contentOffset.x, -(expectedFrameDimension - expectedItemDimension) / 2)
		// internal
		XCTAssertEqual(centeredCollectionViewFlowLayout.pageWidth, expectedItemDimension + expectedLineSpacing)
	}

	func testCenteringInsetHorizontal() {
		centeredCollectionViewFlowLayout.invalidateLayout()
		let expectedInset = (expectedFrameDimension - expectedItemDimension) / 2
		XCTAssertEqual(collectionView.contentInset.left, expectedInset)
		XCTAssertEqual(collectionView.contentInset.right, expectedInset)
		XCTAssertEqual(collectionView.contentInset.top, 0)
		XCTAssertEqual(collectionView.contentInset.bottom, 0)
	}

	func testCenteringInsetVertical() {
		centeredCollectionViewFlowLayout.scrollDirection = .vertical
		centeredCollectionViewFlowLayout.invalidateLayout()
		let expectedInset = (expectedFrameDimension - expectedItemDimension) / 2
		XCTAssertEqual(collectionView.contentInset.top, expectedInset)
		XCTAssertEqual(collectionView.contentInset.bottom, expectedInset)
		XCTAssertEqual(collectionView.contentInset.left, 0)
		XCTAssertEqual(collectionView.contentInset.right, 0)
	}

	// Regression test for the 2.3.0 clamp: an item larger than the frame would
	// otherwise produce a negative inset and a shifted content offset.
	func testOversizedItemHorizontalKeepsZeroInset() {
		centeredCollectionViewFlowLayout.itemSize = CGSize(width: 400, height: 400)
		centeredCollectionViewFlowLayout.invalidateLayout()
		XCTAssertEqual(collectionView.contentInset.left, 0)
		XCTAssertEqual(collectionView.contentInset.right, 0)
		XCTAssertEqual(collectionView.contentOffset.x, 0)
		XCTAssertEqual(collectionView.contentOffset.y, 0)
	}

	func testOversizedItemVerticalKeepsZeroInset() {
		centeredCollectionViewFlowLayout.scrollDirection = .vertical
		centeredCollectionViewFlowLayout.itemSize = CGSize(width: 400, height: 400)
		centeredCollectionViewFlowLayout.invalidateLayout()
		XCTAssertEqual(collectionView.contentInset.top, 0)
		XCTAssertEqual(collectionView.contentInset.bottom, 0)
		XCTAssertEqual(collectionView.contentOffset.x, 0)
		XCTAssertEqual(collectionView.contentOffset.y, 0)
	}

	func testCurrentCenteredPageIsNilWithoutItems() {
		centeredCollectionViewFlowLayout.invalidateLayout()
		XCTAssertNil(centeredCollectionViewFlowLayout.currentCenteredPage)
	}

	func testDefaultValuesWithFrameVertical() {
		// public
		centeredCollectionViewFlowLayout.scrollDirection = .vertical
		centeredCollectionViewFlowLayout.invalidateLayout()
		XCTAssertEqual(centeredCollectionViewFlowLayout.scrollDirection, .vertical)
		XCTAssertEqual(
			centeredCollectionViewFlowLayout.itemSize, CGSize(width: expectedItemDimension, height: expectedItemDimension)
		)
		XCTAssertEqual(centeredCollectionViewFlowLayout.minimumLineSpacing, expectedLineSpacing)
		XCTAssertEqual(collectionView.contentOffset.y, -(expectedFrameDimension - expectedItemDimension) / 2)
		XCTAssertEqual(collectionView.contentOffset.x, 0)
		// internal
		XCTAssertEqual(centeredCollectionViewFlowLayout.pageWidth, expectedItemDimension + expectedLineSpacing)
	}
}
