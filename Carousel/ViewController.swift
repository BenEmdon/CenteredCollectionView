//
//  ViewController.swift
//  Carousel
//
//  Created by Benjamin Emdon on 2016-09-01.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

class ViewController: UIViewController {
	
	let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
	var flowLayout: CarouselCollectionViewFlowLayout!
	let cellPercentWidth: CGFloat = 0.7
	var currentCenteredPage = 0
	
	private var pageWidth: CGFloat {
		return flowLayout.itemSize.width + flowLayout.minimumLineSpacing
	}
	
	private var contentOffset: CGFloat {
		return collectionView.contentOffset.x + collectionView.contentInset.left
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.lightGrayColor()
		collectionView.backgroundColor = UIColor.clearColor()
		
		// delegate & data source
		collectionView.delegate = self
		collectionView.dataSource = self
		
		// layout subview
		view.addSubview(collectionView)
		collectionView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 400)
		
		// register collection cells
		collectionView.registerClass(CollectionCell.self, forCellWithReuseIdentifier: String(CollectionCell))
		
		// configure layout
		flowLayout = CarouselCollectionViewFlowLayout.configureLayout(collectionView: collectionView, itemSize: CGSize(width: collectionView.bounds.width * cellPercentWidth, height: collectionView.bounds.height), minimumLineSpacing: 20)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
	}
	
	// MARK: - Helper actions
	
	private func scrollTo(page: Int, animated: Bool) {
		let pageOffset = CGFloat(page) * pageWidth - collectionView.contentInset.left
		collectionView.setContentOffset(CGPoint(x: pageOffset, y: 0), animated: animated)
		currentCenteredPage = page
	}
}

extension ViewController: UICollectionViewDelegate {
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		currentCenteredPage = Int(contentOffset / pageWidth)
		print("Center page index: \(currentCenteredPage)")
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 6
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(CollectionCell), forIndexPath: indexPath) as! CollectionCell
		cell.titleLabel.text = "Cell #\(indexPath.row)"
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		guard !collectionView.dragging && !collectionView.decelerating && !collectionView.tracking else { return }
		if indexPath.row != currentCenteredPage {
			scrollTo(indexPath.row, animated: true)
			print("Center page index: \(currentCenteredPage)")
		}
		print("Selected page index: \(indexPath.row)")
	}
}
