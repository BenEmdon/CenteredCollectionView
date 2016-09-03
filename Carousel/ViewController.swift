//
//  ViewController.swift
//  Carousel
//
//  Created by Benjamin Emdon on 2016-09-01.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

class ViewController: UIViewController {
	
	let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
	let flowLayout = CenterCellCollectionViewFlowLayout()
	let cellPercentWidth: CGFloat = 0.8

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.lightGrayColor()
		collectionView.backgroundColor = UIColor.clearColor()
		
		// delegate & data source
		collectionView.delegate = self
		collectionView.dataSource = self
		
		// layout subview
		view.addSubview(collectionView)
		collectionView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 290 + 140)
		
		// register collection cells
		collectionView.registerClass(CollectionCell.self, forCellWithReuseIdentifier: String(CollectionCell))
		
		// configure layout
		flowLayout.scrollDirection = .Horizontal
		flowLayout.itemSize = CGSize(width: collectionView.bounds.width * cellPercentWidth, height: collectionView.bounds.height)
		flowLayout.minimumInteritemSpacing = 0
		collectionView.setCollectionViewLayout(flowLayout, animated: false)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		// give left and right enough space to scroll
		var insets = collectionView.contentInset
		let value = (view.frame.size.width - (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
		insets.left = value
		insets.right = value
		collectionView.contentInset = insets
		
		// slow scrolling towards the end
		collectionView.decelerationRate = UIScrollViewDecelerationRateFast
	}
}

extension ViewController: UICollectionViewDelegate {
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		// print the index of the centered cell
		print("Index selected: \(Int(scrollView.contentOffset.x + scrollView.contentInset.left) / Int(scrollView.bounds.width * cellPercentWidth + 10))")
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 44
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(CollectionCell), forIndexPath: indexPath) as! CollectionCell
		cell.titleLabel.text = "Cell #\(indexPath.row)"
		return cell
	}
}
