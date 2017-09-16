//
//  ControlCenterView.swift
//  CenteredCollectionView
//
//  Created by Benjamin Emdon on 2017-01-06.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

protocol ControlCenterViewDelegate: class {
	func stateChanged(scrollDirection: UICollectionViewScrollDirection)
	func stateChanged(scrollToEdgeEnabled: Bool)
}

class ControlCenterView: UIView {

	@objc let segmentedControl = UISegmentedControl()
	@objc let scrollToLabel = UILabel()
	@objc let scrollToSwitch = UISwitch()

	weak var delegate: ControlCenterViewDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = UIColor.clear
		segmentedControl.tintColor = UIColor.white
		scrollToLabel.textColor = UIColor.white
		scrollToSwitch.tintColor = UIColor.white

		// set property state
		segmentedControl.insertSegment(withTitle: "Horizontal", at: 1, animated: false)
		segmentedControl.insertSegment(withTitle: "Vertical", at: 0, animated: false)
		segmentedControl.selectedSegmentIndex = 1
		segmentedControl.addTarget(self, action: #selector(controlStateDidChange(sender:)), for: .valueChanged)

		scrollToLabel.text = "scrollToEdgeEnabled:"

		scrollToSwitch.addTarget(self, action: #selector(switchStateDidChange(sender:)), for: .valueChanged)

		// layout subviews
		preservesSuperviewLayoutMargins = false

		let scrollToStackView = UIStackView()
		scrollToStackView.alignment = .fill
		scrollToStackView.addArrangedSubview(scrollToLabel)
		scrollToStackView.addArrangedSubview(scrollToSwitch)

		addSubview(segmentedControl)
		addSubview(scrollToStackView)
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		scrollToStackView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			segmentedControl.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15),
			segmentedControl.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),

			scrollToStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 15),
			scrollToStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 15),
			scrollToStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -15),
			scrollToStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -15)
			])
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Actions

	@objc func controlStateDidChange(sender: UISegmentedControl) {
		guard let scrollDirection = UICollectionViewScrollDirection(rawValue: sender.selectedSegmentIndex) else { return }
		delegate?.stateChanged(scrollDirection: scrollDirection)
	}

	@objc func switchStateDidChange(sender: UISwitch) {
		delegate?.stateChanged(scrollToEdgeEnabled: sender.isOn)
	}

}
