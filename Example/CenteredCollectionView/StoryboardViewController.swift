//
//  StoryboardViewController.swift
//  CenteredCollectionView_Example
//
//  Created by Benjamin Emdon on 2018-04-10.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class StoryboardViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	let cellPercentWidth: CGFloat = 0.7

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "CenteredCollectionView"

		view.backgroundColor = UIColor.lightGray
		collectionView.backgroundColor = UIColor.clear
		view.applyGradient()

		// delegate & data source
//		collectionView.delegate = self
//		collectionView.dataSource = self
    }

}
