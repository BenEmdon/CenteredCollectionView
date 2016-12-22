//
//  CarouselCollectionViewFlowLayout.swift
//  Carousel
//
//  Created by Benjamin Emdon on 2016-09-05.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

class CarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {
	
	fileprivate var lastCollectionViewSize: CGSize = CGSize.zero
	
	class func configureLayout(collectionView: UICollectionView, itemSize: CGSize, minimumLineSpacing: CGFloat) -> CarouselCollectionViewFlowLayout {
		// default config
		
		let layout = CarouselCollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = minimumLineSpacing
		layout.itemSize = itemSize
		collectionView.decelerationRate = UIScrollViewDecelerationRateFast
		collectionView.collectionViewLayout = layout
		return layout
	}
	
	override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
		super.invalidateLayout(with: context)
		guard let collectionView = collectionView else { return }
		// invalidate layout to center first and last
		
		let currentCollectionViewSize = collectionView.bounds.size
		if !currentCollectionViewSize.equalTo(lastCollectionViewSize) {
			let inset = (collectionView.bounds.size.width - itemSize.width) / 2
			collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
			collectionView.contentOffset = CGPoint(x: -inset, y: 0)
			lastCollectionViewSize = currentCollectionViewSize
		}
	}
	
	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
		guard let collectionView = collectionView else { return proposedContentOffset }
		
		let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
		
		guard let layoutAttributes = layoutAttributesForElements(in: proposedRect) else { return proposedContentOffset }
		
		var candidateAttributes: UICollectionViewLayoutAttributes?
		let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.size.width / 2
		
		for attributes: UICollectionViewLayoutAttributes in layoutAttributes {
			guard attributes.representedElementCategory == .cell else { continue }
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
		return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
	}
}
