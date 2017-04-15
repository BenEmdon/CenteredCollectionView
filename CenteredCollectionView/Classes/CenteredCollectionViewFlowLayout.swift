//
//  CenteredCollectionViewFlowLayout.swift
//  CenteredCollectionView
//
//  Created by Benjamin Emdon on 2016-09-05.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

class CenteredCollectionViewFlowLayout: UICollectionViewFlowLayout {

	fileprivate var lastCollectionViewSize: CGSize = CGSize.zero
	fileprivate var lastScrollDirection: UICollectionViewScrollDirection!

	override init() {
		super.init()
		lastScrollDirection = scrollDirection
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
		super.invalidateLayout(with: context)
		guard let collectionView = collectionView else { return }
		// invalidate layout to center first and last

		let currentCollectionViewSize = collectionView.bounds.size
		if !currentCollectionViewSize.equalTo(lastCollectionViewSize) || lastScrollDirection != scrollDirection {
			let inset: CGFloat
			switch scrollDirection {
			case .horizontal:
				inset = (collectionView.bounds.size.width - itemSize.width) / 2
				collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
				collectionView.contentOffset = CGPoint(x: -inset, y: 0)
			case .vertical:
				inset = (collectionView.bounds.size.height - itemSize.height) / 2
				collectionView.contentInset = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
				collectionView.contentOffset = CGPoint(x: 0, y: -inset)
			}
			lastCollectionViewSize = currentCollectionViewSize
			lastScrollDirection = scrollDirection
		}
	}

	private func determineProposedRect(collectionView: UICollectionView, proposedContentOffset: CGPoint) -> CGRect {
		let size = collectionView.bounds.size
		let origin: CGPoint
		switch scrollDirection {
		case .horizontal:
			origin = CGPoint(x: proposedContentOffset.x, y: 0)
		case .vertical:
			origin = CGPoint(x: 0, y: proposedContentOffset.y)
		}
		return CGRect(origin: origin, size: size)
	}

	private func attributesForRect(
		collectionView: UICollectionView,
		layoutAttributes: [UICollectionViewLayoutAttributes],
		proposedContentOffset: CGPoint
		) -> UICollectionViewLayoutAttributes? {

		var candidateAttributes: UICollectionViewLayoutAttributes?
		let proposedCenterOffset: CGFloat

		switch scrollDirection {
		case .horizontal:
			proposedCenterOffset = proposedContentOffset.x + collectionView.bounds.size.width / 2
		case .vertical:
			proposedCenterOffset = proposedContentOffset.y + collectionView.bounds.size.height / 2
		}

		for attributes: UICollectionViewLayoutAttributes in layoutAttributes {
			guard attributes.representedElementCategory == .cell else { continue }
			guard candidateAttributes != nil else {
				candidateAttributes = attributes
				continue
			}

			switch scrollDirection {
			case .horizontal:
				if fabs(attributes.center.x - proposedCenterOffset) < fabs(candidateAttributes!.center.x - proposedCenterOffset) {
					candidateAttributes = attributes
				}
			case .vertical:
				if fabs(attributes.center.y - proposedCenterOffset) < fabs(candidateAttributes!.center.y - proposedCenterOffset) {
					candidateAttributes = attributes
				}
			}
		}
		return candidateAttributes
	}

	// swiftlint:disable line_length
	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
		guard let collectionView = collectionView else { return proposedContentOffset }

		let proposedRect: CGRect = determineProposedRect(collectionView: collectionView, proposedContentOffset: proposedContentOffset)

		guard let layoutAttributes = layoutAttributesForElements(in: proposedRect),
			let candidateAttributesForRect = attributesForRect(
				collectionView: collectionView,
				layoutAttributes: layoutAttributes,
				proposedContentOffset: proposedContentOffset
			) else { return proposedContentOffset }

		var newOffset: CGFloat
		let offset: CGFloat
		switch scrollDirection {
		case .horizontal:
			newOffset = candidateAttributesForRect.center.x - collectionView.bounds.size.width / 2
			offset = newOffset - collectionView.contentOffset.x

			if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
				let pageWidth = itemSize.width + minimumLineSpacing
				newOffset += velocity.x > 0 ? pageWidth : -pageWidth
			}
			return CGPoint(x: newOffset, y: proposedContentOffset.y)

		case .vertical:
			newOffset = candidateAttributesForRect.center.y - collectionView.bounds.size.height / 2
			offset = newOffset - collectionView.contentOffset.y

			if (velocity.y < 0 && offset > 0) || (velocity.y > 0 && offset < 0) {
				let pageHeight = itemSize.height + minimumLineSpacing
				newOffset += velocity.y > 0 ? pageHeight : -pageHeight
			}
			return CGPoint(x: proposedContentOffset.x, y: newOffset)
		}
	}
}
