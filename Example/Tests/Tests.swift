import UIKit
import XCTest
@testable import CenteredCollectionView

class Tests: XCTestCase {

	var collectionView: UICollectionView!
	var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
	let expectedItemDimension: CGFloat = 80
	let expectedLineSpacing: CGFloat = 20
	let expectedFrameDimension: CGFloat = 300

	override func setUp() {
		super.setUp()
		// This method is called before the invocation of each test method in the class.
		let (collectionView, centeredCollectionViewFlowLayout) = UICollectionView.centeredCollectionView(
			frame: CGRect(
				x: 0,
				y: 0,
				width: expectedFrameDimension,
				height: expectedFrameDimension
			)
		)

		centeredCollectionViewFlowLayout.itemSize = CGSize(width: expectedItemDimension, height: expectedItemDimension)
		centeredCollectionViewFlowLayout.minimumLineSpacing = expectedLineSpacing

		self.collectionView = collectionView
		self.centeredCollectionViewFlowLayout = centeredCollectionViewFlowLayout
	}

	func testDefaultValuesNoFrame() {
		let expectedItemDimension: CGFloat = 50
		let expectedLineSpacing: CGFloat = 10
		let (collectionView, centeredCollectionViewFlowLayout) = UICollectionView.centeredCollectionView()
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
