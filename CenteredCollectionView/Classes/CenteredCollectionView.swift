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
	var _currentCenteredPage: Int = 0
	public var scrollToEdgeEnabled: Bool = false

	public override weak var delegate: UICollectionViewDelegate? {
		get {
			return super.delegate
		}
		set(newValue) {
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
		super.delegate = self
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
		_currentCenteredPage = index
		isUserInteractionEnabled = !shouldAnimate
	}
}

extension CenteredCollectionView: UICollectionViewDelegate {

	// MARK: - Utilized delegate methods
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegateInterceptor?.collectionView?(collectionView, didSelectItemAt: indexPath)
		if scrollToEdgeEnabled && !collectionView.isDragging && !collectionView.isDecelerating && !collectionView.isTracking && indexPath.row != currentCenteredPage {
			scrollTo(index: indexPath.row, animated: true)
		}
	}

	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		_currentCenteredPage = Int((currentContentOffset + 1) / pageWidth)
		delegateInterceptor?.scrollViewDidEndDecelerating?(scrollView)
	}

	public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		isUserInteractionEnabled = true
		delegateInterceptor?.scrollViewDidEndScrollingAnimation?(scrollView)
	}

	// MARK: - Purely rerouting delegate messages

	// ScrollViewDelegate

	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		delegateInterceptor?.scrollViewDidScroll?(scrollView)
	}

	public func scrollViewDidZoom(_ scrollView: UIScrollView) {
		delegateInterceptor?.scrollViewDidZoom?(scrollView)
	}

	public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		delegateInterceptor?.scrollViewWillBeginDragging?(scrollView)
	}

	public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		delegateInterceptor?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
	}

	public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		delegateInterceptor?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
	}

	public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		delegateInterceptor?.scrollViewWillBeginDecelerating?(scrollView)
	}

	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return delegateInterceptor?.viewForZooming?(in: scrollView) ?? nil
	}

	public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
		delegateInterceptor?.scrollViewWillBeginZooming?(scrollView, with: view)
	}

	public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
		delegateInterceptor?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
	}

	public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
		return delegateInterceptor?.scrollViewShouldScrollToTop?(scrollView) ?? true
	}

	public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
		delegateInterceptor?.scrollViewDidScrollToTop?(scrollView)
	}

	// CollectionViewViewDelegate

	public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
		return delegateInterceptor?.collectionView?(collectionView, shouldHighlightItemAt: indexPath) ?? true
	}

	public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
		delegateInterceptor?.collectionView?(collectionView, didHighlightItemAt: indexPath)
	}

	public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
		delegateInterceptor?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)
	}

	public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
		return delegateInterceptor?.collectionView?(collectionView, shouldHighlightItemAt: indexPath) ?? true
	}

	public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
		return delegateInterceptor?.collectionView?(collectionView, shouldDeselectItemAt: indexPath) ?? true
	}

	public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		delegateInterceptor?.collectionView?(collectionView, didDeselectItemAt: indexPath)
	}

	public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		delegateInterceptor?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
	}

	public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
		delegateInterceptor?.collectionView?(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)
	}

	public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		delegateInterceptor?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
	}

	public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
		delegateInterceptor?.collectionView?(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, at: indexPath)
	}

	public func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
		return delegateInterceptor?.collectionView?(collectionView, shouldShowMenuForItemAt: indexPath) ?? false
	}

	public func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
		return delegateInterceptor?.collectionView?(collectionView, canPerformAction: action, forItemAt: indexPath, withSender: sender) ?? false
	}

	public func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
		delegateInterceptor?.collectionView?(collectionView, performAction: action, forItemAt: indexPath, withSender: sender)
	}

	public func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
		return delegateInterceptor?.collectionView?(collectionView, transitionLayoutForOldLayout: fromLayout, newLayout: toLayout) ?? UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
	}

	public func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
		return delegateInterceptor?.collectionView?(collectionView, canFocusItemAt: indexPath) ?? true
	}

	public func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
		return delegateInterceptor?.collectionView?(collectionView, shouldUpdateFocusIn: context) ?? true
	}

	public func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
		delegateInterceptor?.collectionView?(collectionView, didUpdateFocusIn: context, with: coordinator)
	}
}
