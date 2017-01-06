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
	let control = UISegmentedControl()
	let cellPercentWidth: CGFloat = 0.7

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.lightGray
		centeredCollectionView.backgroundColor = UIColor.clear

		control.insertSegment(withTitle: "Horizontal", at: 1, animated: false)
		control.insertSegment(withTitle: "Vertical", at: 0, animated: false)
		control.selectedSegmentIndex = 1
		control.addTarget(self, action: #selector(controlStateDidChange), for: .valueChanged)

		// delegate & data source
		centeredCollectionView.delegate = self
		centeredCollectionView.dataSource = self

		// layout subviews
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 15

		stackView.addArrangedSubview(centeredCollectionView)
		stackView.addArrangedSubview(control)

		view.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stackView.topAnchor.constraint(equalTo: view.topAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
			])

		// register collection cells
		centeredCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))

		// configure layout
		centeredCollectionView.itemSize = CGSize(width: view.bounds.width * cellPercentWidth, height: view.bounds.height * cellPercentWidth)
		centeredCollectionView.minimumLineSpacing = 20
		centeredCollectionView.showsVerticalScrollIndicator = false
		centeredCollectionView.showsHorizontalScrollIndicator = false
		centeredCollectionView.scrollToEdgeEnabled = true
	}

	// MARK: - Actions

	func controlStateDidChange(sender: UISegmentedControl) {
		guard let scrollDirection = UICollectionViewScrollDirection(rawValue: sender.selectedSegmentIndex) else { return }
		centeredCollectionView.scrollDirection = scrollDirection
	}
}

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Selected Cell #\(indexPath.row)")
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

