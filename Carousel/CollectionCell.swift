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
		mainView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		
		NSLayoutConstraint.activateConstraints([
			mainView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor),
			mainView.topAnchor.constraintEqualToAnchor(contentView.topAnchor),
			mainView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor),
			mainView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor),
			
			titleLabel.leadingAnchor.constraintEqualToAnchor(mainView.layoutMarginsGuide.leadingAnchor),
			titleLabel.bottomAnchor.constraintEqualToAnchor(mainView.layoutMarginsGuide.bottomAnchor)
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
