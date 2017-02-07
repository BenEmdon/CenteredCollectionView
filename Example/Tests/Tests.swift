import UIKit
import XCTest
@testable import CenteredCollectionView

class Tests: XCTestCase {

	var collectionView: CenteredCollectionView!
	let expectedItemDimension: CGFloat = 80
	let expectedLineSpacing: CGFloat = 20
	let expectedFrameDimension: CGFloat = 300

	override func setUp() {
		super.setUp()
		// This method is called before the invocation of each test method in the class.
		collectionView = CenteredCollectionView(frame: CGRect(x: 0, y: 0, width: expectedFrameDimension, height: expectedFrameDimension))
		collectionView.itemSize = CGSize(width: expectedItemDimension, height: expectedItemDimension)
		collectionView.minimumLineSpacing = expectedLineSpacing
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		collectionView = nil
		super.tearDown()
	}

	func testDefaultValuesNoFrame() {
		let expectedItemDimension: CGFloat = 50
		let expectedLineSpacing: CGFloat = 10
		collectionView = CenteredCollectionView()
		collectionView.flowLayout.invalidateLayout()
		// public
		XCTAssertEqual(collectionView.scrollDirection, .horizontal)
		XCTAssertEqual(collectionView.itemSize, CGSize(width: expectedItemDimension, height: expectedItemDimension))
		XCTAssertEqual(collectionView.minimumLineSpacing, expectedLineSpacing)
		XCTAssertEqual(collectionView.currentCenteredPage, 0)
		XCTAssertEqual(collectionView.contentOffset.y, 0)
		XCTAssertEqual(collectionView.contentOffset.x, 25)
		// internal
		XCTAssertEqual(collectionView.pageWidth, expectedItemDimension + expectedLineSpacing)
		XCTAssertEqual(collectionView.currentContentOffset, 0)
	}

	func testDefaultValuesWithFrame() {
		// public
		collectionView.flowLayout.invalidateLayout()
		XCTAssertEqual(collectionView.scrollDirection, .horizontal)
		XCTAssertEqual(collectionView.itemSize, CGSize(width: expectedItemDimension, height: expectedItemDimension))
		XCTAssertEqual(collectionView.minimumLineSpacing, expectedLineSpacing)
		XCTAssertEqual(collectionView.currentCenteredPage, 0)
		XCTAssertEqual(collectionView.contentOffset.y, 0)
		XCTAssertEqual(collectionView.contentOffset.x, -(expectedFrameDimension - expectedItemDimension) / 2)
		// internal
		XCTAssertEqual(collectionView.pageWidth, expectedItemDimension + expectedLineSpacing)
		XCTAssertEqual(collectionView.currentContentOffset, 0)
	}

}
