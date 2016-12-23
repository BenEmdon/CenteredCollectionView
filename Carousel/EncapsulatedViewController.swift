//
//  EncapsulatedViewController.swift
//  Carousel
//
//  Created by Benjamin Emdon on 2016-12-23.
//  Copyright © 2016 TravelNPlay. All rights reserved.
//

import UIKit

class EncapsulatedViewController: UIViewController {

	let centeredCollectionView = CenteredCollectionView(frame: CGRect.zero)
	let cellPercentWidth: CGFloat = 0.7

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.lightGray
		centeredCollectionView.backgroundColor = UIColor.clear

		// delegate & data source
		centeredCollectionView.delegate = self
		centeredCollectionView.dataSource = self

		// layout subview
		view.addSubview(centeredCollectionView)
		centeredCollectionView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 400)

		// register collection cells
		centeredCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: String(describing: CollectionCell.self))

		// configure layout
		centeredCollectionView.itemSize = CGSize(width: centeredCollectionView.bounds.width * cellPercentWidth, height: centeredCollectionView.bounds.height)
		centeredCollectionView.minimumLineSpacing = 20
		centeredCollectionView.showsVerticalScrollIndicator = false
		centeredCollectionView.showsHorizontalScrollIndicator = false
	}
}

extension EncapsulatedViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard !collectionView.isDragging && !collectionView.isDecelerating && !collectionView.isTracking else { return }
		if indexPath.row != centeredCollectionView.currentCenteredPage {
			centeredCollectionView.scrollTo(page: indexPath.row, animated: false)
			print("Center page index: \(centeredCollectionView.currentCenteredPage)")
		}
		print("Selected page index: \(indexPath.row)")
	}
}

extension EncapsulatedViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 6
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionCell.self), for: indexPath) as! CollectionCell
		cell.titleLabel.text = "Cell #\(indexPath.row)"
		return cell
	}
}
