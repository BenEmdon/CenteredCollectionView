//
//  StoryboardViewController.swift
//  CenteredCollectionView_Example
//
//  Created by Benjamin Emdon on 2018-04-10.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import CenteredCollectionView

class StoryboardViewController: UIViewController {

	let cellPercentWidth: CGFloat = 0.7
	var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!

	@IBOutlet weak var collectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "CenteredCollectionView"

		// Get the reference to the CenteredCollectionViewFlowLayout (REQURED)
		centeredCollectionViewFlowLayout = collectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout

		// Modify the collectionView's decelerationRate (REQURED)
		collectionView.decelerationRate = UIScrollViewDecelerationRateFast

		// Make the example pretty ✨
		view.applyGradient()

		// Assign delegate and data source
		collectionView.delegate = self
		collectionView.dataSource = self

		// Configure the required item size (REQURED)
		centeredCollectionViewFlowLayout.itemSize = CGSize(
			width: view.bounds.width * cellPercentWidth,
			height: view.bounds.height * cellPercentWidth * cellPercentWidth
		)

		// Configure the optional inter item spacing (OPTIONAL)
		centeredCollectionViewFlowLayout.minimumLineSpacing = 20
    }

}

extension StoryboardViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Selected Cell #\(indexPath.row)")
	}
}

extension StoryboardViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 6
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: "CollectionViewCell"), for: indexPath) as! StoryboardCollectionViewCell
		cell.label.text = "Cell #\(indexPath.row)"
		return cell
	}

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
	}

	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
	}
}
