//
//  CollectionCell.swift
//  Carousel
//
//  Created by Benjamin Emdon on 2016-09-01.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

class CollectionCell: UICollectionViewCell {
	
	let titleLabel = UILabel()
	let mainView = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		// subview config
		titleLabel.textAlignment = .Left
		mainView.backgroundColor = UIColor.whiteColor()
		mainView.layer.cornerRadius = 3
		
		// prepare subviews for layout
		contentView.addSubview(mainView)
		mainView.translatesAutoresizingMaskIntoConstraints = false
		mainView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		mainView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		
		NSLayoutConstraint.activateConstraints([
			mainView.leadingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.leadingAnchor),
			mainView.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
			mainView.trailingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.trailingAnchor),
			mainView.bottomAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.bottomAnchor),
			
			titleLabel.leadingAnchor.constraintEqualToAnchor(mainView.layoutMarginsGuide.leadingAnchor),
			titleLabel.bottomAnchor.constraintEqualToAnchor(mainView.layoutMarginsGuide.bottomAnchor)
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
