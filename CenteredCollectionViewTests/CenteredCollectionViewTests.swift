//
//  CenteredCollectionViewTests.swift
//  CenteredCollectionViewTests
//
//  Created by Benjamin Emdon on 2016-12-28.
//  Copyright © 2016 Benjamin Emdon.
//

import XCTest
@testable import CenteredCollectionView

class CenteredCollectionViewTests: XCTestCase {

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
		XCTAssertEqual(collectionView.scrollDirection, .vertical)
		XCTAssertEqual(collectionView.itemSize, CGSize(width: expectedItemDimension, height: expectedItemDimension))
		XCTAssertEqual(collectionView.minimumLineSpacing, expectedLineSpacing)
		XCTAssertEqual(collectionView.currentCenteredPage, 0)
		XCTAssertEqual(collectionView.contentOffset.y, 0)
		XCTAssertEqual(collectionView.contentOffset.x, 0)
		// internal
		XCTAssertEqual(collectionView.pageWidth, expectedItemDimension + expectedLineSpacing)
		XCTAssertEqual(collectionView.currentContentOffset, 0)
		XCTAssertTrue(collectionView.delegateInterceptor == nil)
	}

	func testDefaultValuesWithFrame() {
		// public
		collectionView.flowLayout.invalidateLayout()
		XCTAssertEqual(collectionView.scrollDirection, .vertical)
		XCTAssertEqual(collectionView.itemSize, CGSize(width: expectedItemDimension, height: expectedItemDimension))
		XCTAssertEqual(collectionView.minimumLineSpacing, expectedLineSpacing)
		XCTAssertEqual(collectionView.currentCenteredPage, 0)
		XCTAssertEqual(collectionView.contentOffset.y, -(expectedFrameDimension - expectedItemDimension) / 2)
		XCTAssertEqual(collectionView.contentOffset.x, 0)
		// internal
		XCTAssertEqual(collectionView.pageWidth, expectedItemDimension + expectedLineSpacing)
		XCTAssertEqual(collectionView.currentContentOffset, 0)
		XCTAssertTrue(collectionView.delegateInterceptor == nil)
	}

//	func testPerformanceExample() {
//		// This is an example of a performance test case.
//		self.measure {
//			// Put the code you want to measure the time of here.
//		}
//	}

}
