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
		titleLabel.textAlignment = .left
		mainView.backgroundColor = UIColor.white
		mainView.layer.cornerRadius = 3
		
		// prepare subviews for layout
		contentView.addSubview(mainView)
		mainView.translatesAutoresizingMaskIntoConstraints = false
		mainView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		mainView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		
		NSLayoutConstraint.activate([
			mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
			mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			
			titleLabel.leadingAnchor.constraint(equalTo: mainView.layoutMarginsGuide.leadingAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: mainView.layoutMarginsGuide.bottomAnchor)
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
