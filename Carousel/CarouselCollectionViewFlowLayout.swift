//
//  CarouselCollectionViewFlowLayout.swift
//  Carousel
//
//  Created by Benjamin Emdon on 2016-09-05.
//  Copyright © 2016 TravelNPlay. All rights reserved.
//

import UIKit

class CarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {
	
	private var lastCollectionViewSize: CGSize = CGSizeZero
	
	class func configureLayout(collectionView collectionView: UICollectionView, itemSize: CGSize, minimumLineSpacing: CGFloat) -> CarouselCollectionViewFlowLayout {
		// default config
		
		let layout = CarouselCollectionViewFlowLayout()
		layout.scrollDirection = .Horizontal
		layout.minimumLineSpacing = minimumLineSpacing
		layout.itemSize = itemSize
		collectionView.decelerationRate = UIScrollViewDecelerationRateFast
		collectionView.collectionViewLayout = layout
		return layout
	}
	
	override func invalidateLayoutWithContext(context: UICollectionViewLayoutInvalidationContext) {
		super.invalidateLayoutWithContext(context)
		guard let collectionView = collectionView else { return }
		// invalidate layout to center first and last
		
		let currentCollectionViewSize = collectionView.bounds.size
		if !CGSizeEqualToSize(currentCollectionViewSize, lastCollectionViewSize) {
			let inset = (collectionView.bounds.size.width - itemSize.width) / 2
			collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
			collectionView.contentOffset = CGPoint(x: -inset, y: 0)
			lastCollectionViewSize = currentCollectionViewSize
		}
	}
	
	override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
		guard let collectionView = collectionView else { return proposedContentOffset }
		
		let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
		
		guard let layoutAttributes = layoutAttributesForElementsInRect(proposedRect) else { return proposedContentOffset }
		
		var candidateAttributes: UICollectionViewLayoutAttributes?
		let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.size.width / 2
		
		for attributes: UICollectionViewLayoutAttributes in layoutAttributes {
			guard attributes.representedElementCategory == .Cell else { continue }
			guard candidateAttributes != nil else {
				candidateAttributes = attributes
				continue
			}
			
			if fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
				candidateAttributes = attributes
			}
		}
		
		guard let candidateAttributesForRect = candidateAttributes else { return proposedContentOffset }
		
		var newOffsetX = candidateAttributesForRect.center.x - collectionView.bounds.size.width / 2
		let offset = newOffsetX - collectionView.contentOffset.x
		
		if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
			let pageWidth = itemSize.width + minimumLineSpacing
			newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
		}
		return CGPointMake(newOffsetX, proposedContentOffset.y)
	}
}
