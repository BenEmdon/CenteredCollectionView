//
//  CenterCellCollectionViewFlowLayout.swift
//  Carousel
//
//  Created by Benjamin Emdon on 2016-09-01.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
	
	override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
		
		if let collectionView = self.collectionView {
			let halfWidth = collectionView.bounds.size.width * 0.5;
			let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth;
			
			if let attributesForVisibleCells = layoutAttributesForElementsInRect(collectionView.bounds) {
				var candidateAttributes : UICollectionViewLayoutAttributes?
				
				for attributes in attributesForVisibleCells {
					// Skip comparison with non-cell items (section headers and footers)
					if attributes.representedElementCategory != UICollectionElementCategory.Cell {
						continue
					}
					
					if let candAttrs = candidateAttributes {
						let a = attributes.center.x - proposedContentOffsetCenterX
						let b = candAttrs.center.x - proposedContentOffsetCenterX
						
						if fabsf(Float(a)) < fabsf(Float(b)) {
							candidateAttributes = attributes;
						}
					} else {
						// First time in the loop
						candidateAttributes = attributes;
						continue;
					}
				}
				return CGPoint(x: round(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)
			}
		}
		// Fallback
		return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
	}
}
