//
//  ViewController.swift
//  Example
//
//  Created by Benjamin Emdon on 2016-12-28.
//  Copyright © 2016 Benjamin Emdon. All rights reserved.
//

import UIKit
import CenteredCollectionView

class ViewController: UIViewController {

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
		centeredCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))

		// configure layout
		centeredCollectionView.itemSize = CGSize(width: centeredCollectionView.bounds.width * cellPercentWidth, height: centeredCollectionView.bounds.height * cellPercentWidth)
		centeredCollectionView.minimumLineSpacing = 20
		centeredCollectionView.showsVerticalScrollIndicator = false
		centeredCollectionView.showsHorizontalScrollIndicator = false
	}
}

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard !collectionView.isDragging && !collectionView.isDecelerating && !collectionView.isTracking else { return }
		if indexPath.row != centeredCollectionView.currentCenteredPage {
			centeredCollectionView.scrollTo(page: indexPath.row, animated: true)
			print("Center page index: \(centeredCollectionView.currentCenteredPage)")
		}
		print("Selected page index: \(indexPath.row)")
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 6
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as! CollectionViewCell
		cell.titleLabel.text = "Cell #\(indexPath.row)"
		return cell
	}
}

