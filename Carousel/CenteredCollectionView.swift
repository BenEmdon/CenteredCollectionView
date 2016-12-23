//
//  CenteredCollectionView.swift
//  Carousel
//
//  Created by Benjamin Emdon on 2016-12-22.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

public class CenteredCollectionView: UICollectionView {

	let flowLayout = CarouselCollectionViewFlowLayout()
	var _currentCenteredPage: Int = 0

	public override var delegate: UICollectionViewDelegate? {
		get {
			return super.delegate
		}
		set {
			delegateInterceptor = newValue
		}
	}

	weak var delegateInterceptor: UICollectionViewDelegate?

	public var currentCenteredPage: Int {
		return _currentCenteredPage
	}

	public var minimumLineSpacing: CGFloat {
		get {
			return flowLayout.minimumLineSpacing
		}
		set {
			flowLayout.minimumLineSpacing = newValue
		}
	}

	public var itemSize: CGSize {
		get {
			return flowLayout.itemSize
		}
		set {
			flowLayout.itemSize = newValue
		}
	}

	var pageWidth: CGFloat {
		switch flowLayout.scrollDirection {
		case .horizontal:
			return flowLayout.itemSize.width + flowLayout.minimumLineSpacing
		case .vertical:
			return flowLayout.itemSize.height + flowLayout.minimumLineSpacing
		}
	}

	var currentContentOffset: CGFloat {
		switch flowLayout.scrollDirection {
		case .horizontal:
			return contentOffset.x + contentInset.left
		case .vertical:
			return contentOffset.y + contentInset.top
		}
	}

	// TODO: Add support for .vertical
	public init(frame: CGRect) {
		flowLayout.scrollDirection = .horizontal
		super.init(frame: frame, collectionViewLayout: flowLayout)
		decelerationRate = UIScrollViewDecelerationRateFast
		backgroundColor = UIColor.clear
		super.delegate = self
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public func scrollTo(page: Int, animated: Bool) {
		let pageOffset: CGFloat
		switch flowLayout.scrollDirection {
		case .horizontal:
			pageOffset = CGFloat(page) * pageWidth - contentInset.left
			setContentOffset(CGPoint(x: pageOffset, y: 0), animated: animated)
		case .vertical:
			pageOffset = CGFloat(page) * pageWidth - contentInset.top
			setContentOffset(CGPoint(x: 0, y: pageOffset), animated: animated)
		}
		_currentCenteredPage = page
		isUserInteractionEnabled = !animated
	}
}

extension CenteredCollectionView: UICollectionViewDelegate {

	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegateInterceptor?.collectionView!(collectionView, didSelectItemAt: indexPath)
	}

	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		_currentCenteredPage = Int(currentContentOffset / pageWidth)
	}

	public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		isUserInteractionEnabled = true
	}
}
