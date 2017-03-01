//
//  CenteredCollectionView.swift
//  CenteredCollectionView
//
//  Created by Benjamin Emdon on 2016-12-22.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

public class CenteredCollectionView: UICollectionView {

	let flowLayout = CenteredCollectionViewFlowLayout()

	public var currentCenteredPage: Int? {
		let currentCenteredPoint = CGPoint(x: contentOffset.x + bounds.width/2, y: contentOffset.y + bounds.height/2)
		let indexPath = indexPathForItem(at: currentCenteredPoint)
		return indexPath?.row
	}

	public var minimumLineSpacing: CGFloat {
		get {
			return flowLayout.minimumLineSpacing
		}
		set(newValue) {
			flowLayout.minimumLineSpacing = newValue
		}
	}

	public var itemSize: CGSize {
		get {
			return flowLayout.itemSize
		}
		set(newValue)  {
			flowLayout.itemSize = newValue
		}
	}

	public var scrollDirection: UICollectionViewScrollDirection {
		get {
			return flowLayout.scrollDirection
		}
		set(newValue) {
			flowLayout.scrollDirection = newValue
		}
	}

	var pageWidth: CGFloat {
		switch scrollDirection {
		case .horizontal:
			return flowLayout.itemSize.width + flowLayout.minimumLineSpacing
		case .vertical:
			return flowLayout.itemSize.height + flowLayout.minimumLineSpacing
		}
	}

	var currentContentOffset: CGFloat {
		switch scrollDirection {
		case .horizontal:
			return contentOffset.x + contentInset.left
		case .vertical:
			return contentOffset.y + contentInset.top
		}
	}

	public init(frame: CGRect) {
		super.init(frame: frame, collectionViewLayout: flowLayout)
		decelerationRate = UIScrollViewDecelerationRateFast
		backgroundColor = UIColor.clear
		scrollDirection = .horizontal
	}

	public convenience init() {
		self.init(frame: CGRect.zero)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public func scrollTo(index: Int, animated: Bool) {
		let pageOffset: CGFloat
		let proposedContentOffset: CGPoint
		let shouldAnimate: Bool
		switch scrollDirection {
		case .horizontal:
			pageOffset = CGFloat(index) * pageWidth - contentInset.left
			proposedContentOffset = CGPoint(x: pageOffset, y: 0)
			shouldAnimate = fabs(contentOffset.x - pageOffset) > 1 ? animated : false
		case .vertical:
			pageOffset = CGFloat(index) * pageWidth - contentInset.top
			proposedContentOffset = CGPoint(x: 0, y: pageOffset)
			shouldAnimate = fabs(contentOffset.y - pageOffset) > 1 ? animated : false
		}
		setContentOffset(proposedContentOffset, animated: shouldAnimate)
	}
}
