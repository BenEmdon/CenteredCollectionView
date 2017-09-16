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

	@objc let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()
	@objc let collectionView: UICollectionView

	@objc let controlCenter = ControlCenterView()
	@objc let cellPercentWidth: CGFloat = 0.7
	@objc var scrollToEdgeEnabled = false

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		collectionView = UICollectionView(centeredCollectionViewFlowLayout: centeredCollectionViewFlowLayout)
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "CenteredCollectionView"

		view.backgroundColor = UIColor.lightGray
		collectionView.backgroundColor = UIColor.clear
		view.applyGradient()

		// delegate & data source
		controlCenter.delegate = self
		collectionView.delegate = self
		collectionView.dataSource = self

		// layout subviews
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.addArrangedSubview(collectionView)
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
		collectionView.register(
			CollectionViewCell.self,
			forCellWithReuseIdentifier: String(describing: CollectionViewCell.self)
		)

		// configure layout
		centeredCollectionViewFlowLayout.itemSize = CGSize(
			width: view.bounds.width * cellPercentWidth,
			height: view.bounds.height * cellPercentWidth * cellPercentWidth
		)
		centeredCollectionViewFlowLayout.minimumLineSpacing = 20
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
	}
}

extension ViewController: ControlCenterViewDelegate {
	@objc func stateChanged(scrollDirection: UICollectionViewScrollDirection) {
		centeredCollectionViewFlowLayout.scrollDirection = scrollDirection
	}

	@objc func stateChanged(scrollToEdgeEnabled: Bool) {
		self.scrollToEdgeEnabled = scrollToEdgeEnabled
	}
}

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Selected Cell #\(indexPath.row)")
		if scrollToEdgeEnabled,
			let currentCenteredPage = centeredCollectionViewFlowLayout.currentCenteredPage,
			currentCenteredPage != indexPath.row {
			centeredCollectionViewFlowLayout.scrollToPage(index: indexPath.row, animated: true)
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
		print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
	}

	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
	}
}
