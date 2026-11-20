# CenteredCollectionView
[![CI](https://github.com/BenEmdon/CenteredCollectionView/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/BenEmdon/CenteredCollectionView/actions/workflows/ci.yml)
[![Version](https://img.shields.io/cocoapods/v/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Swift 5.9](https://img.shields.io/badge/Swift-5.9-orange.svg?style=flat)](https://swift.org)
[![Swift Package Index](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FBenEmdon%2FCenteredCollectionView%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/BenEmdon/CenteredCollectionView)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FBenEmdon%2FCenteredCollectionView%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/BenEmdon/CenteredCollectionView)
[![Platform](https://img.shields.io/badge/platforms-iOS%20%7C%20tvOS-orange.svg)](http://cocoapods.org/pods/CenteredCollectionView)

`CenteredCollectionView` is a lightweight drop in place `UICollectionViewFlowLayout` that _pages_ and keeps its cells centered, resulting in the _"carousel effect"_ 🎡

## Example

![Demo](/.github/demo.gif)

To try the example using Cocoapods:
```bash
pod try CenteredCollectionView
```

## Requirements
This pod requires a deployment target of iOS 13.0 or greater

## Installation

CenteredCollectionView is available through [Swift Package Manager](https://swift.org/package-manager/), [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage).

To install it with **Swift Package Manager**, add the URL `https://github.com/BenEmdon/CenteredCollectionView` in Xcode Add Package Dependency assistant ; or add to your own `Package.swift`:
```swift
dependencies: [
  .package(url: "https://github.com/BenEmdon/CenteredCollectionView", from: "2.3.0")
]
```

To install it with **Cocoapods**, add the following line to your `Podfile`:
```ruby
pod "CenteredCollectionView"
```

To install it with **Carthage**, add the following line to your `Cartfile`:
```
github "BenEmdon/CenteredCollectionView"
```

## Usage
Checkout [`USAGE.md`](/USAGE.md)

## API
Checkout [`API.md`](/API.md)

## Contributing

Have a suggestion? All contributions are welcome!

Issues and pull requests are triaged on a best effort basis, usually once a week. There is no stale bot here: a report from a real person stays open until a person answers it.

## Author

[@BenEmdon 👨‍💻](https://twitter.com/BenEmdon)

## License

CenteredCollectionView is available under the MIT license. See the LICENSE file for more info.
