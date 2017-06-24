//
//  ViewController.swift
//  Example
//
//  Created by Benjamin Emdon on 2016-12-28.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit
import CenteredCollectionView

class ViewController: UIViewController {
	
	let centeredCollectionView = CenteredCollectionView()
	let controlCenter = ControlCenterView()
	let cellPercentWidth: CGFloat = 0.7
	var scrollToEdgeEnabled = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "CenteredCollectionView"
		
		view.backgroundColor = UIColor.lightGray
		centeredCollectionView.backgroundColor = UIColor.clear
		view.applyGradient()
		
		// delegate & data source
		controlCenter.delegate = self
		centeredCollectionView.delegate = self
		centeredCollectionView.dataSource = self
		
		// layout subviews
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.addArrangedSubview(centeredCollectionView)
		stackView.addArrangedSubview(controlCenter)
		view.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stackView.topAnchor.constraint(equalTo: view.topAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
		
		// register collection cells
		centeredCollectionView.register(
			CollectionViewCell.self,
			forCellWithReuseIdentifier: String(describing: CollectionViewCell.self)
		)
		
		// configure layout
		centeredCollectionView.itemSize = CGSize(
			width: view.bounds.width * cellPercentWidth,
			height: view.bounds.height * cellPercentWidth * cellPercentWidth
		)
		centeredCollectionView.minimumLineSpacing = 20
		centeredCollectionView.showsVerticalScrollIndicator = false
		centeredCollectionView.showsHorizontalScrollIndicator = false
	}
}

extension ViewController: ControlCenterViewDelegate {
	func stateChanged(scrollDirection: UICollectionViewScrollDirection) {
		centeredCollectionView.scrollDirection = scrollDirection
	}
	
	func stateChanged(scrollToEdgeEnabled: Bool) {
		self.scrollToEdgeEnabled = scrollToEdgeEnabled
	}
}

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Selected Cell #\(indexPath.row)")
		if scrollToEdgeEnabled,
			let currentCenteredPage = centeredCollectionView.currentCenteredPage,
			currentCenteredPage != indexPath.row {
			centeredCollectionView.scrollTo(index: indexPath.row, animated: true)
		}
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 6
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		// swiftlint:disable:next force_cast line_length
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as! CollectionViewCell
		cell.titleLabel.text = "Cell #\(indexPath.row)"
		return cell
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		print("Current centered index: \(String(describing: centeredCollectionView.currentCenteredPage ?? nil))")
	}
	
	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		print("Current centered index: \(String(describing: centeredCollectionView.currentCenteredPage ?? nil))")
	}
}
