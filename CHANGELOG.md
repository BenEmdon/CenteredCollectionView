# Changelog

## 2.3.0 (2026-11-19)

- Raised the minimum deployment target from iOS 9.0 / tvOS 9.0 to iOS 13.0 / tvOS 13.0.
- Raised the Swift tools and language floor to Swift 5.9.
- Replaced the dead Travis CI setup with GitHub Actions: SPM build, example app build, podspec lint, and the unit tests, now wired into the Swift package and run on an iOS Simulator in CI.
- Removed the stale bot. Issues and PRs are no longer auto-closed without a human reply.
- Bug fix found by running the tests on a modern simulator: the centering inset could go negative for a zero-size collection view or an oversized cell, which set a wrong content offset. The inset is now clamped at 0.
- No API changes. `CenteredCollectionViewFlowLayout` and the `UICollectionView` convenience initializer keep their signatures.

## 2.2.2 (2020-01-26)

- Last release before this modernization pass. See the GitHub releases page for earlier history.
