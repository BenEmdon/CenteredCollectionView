# CenteredCollectionView
[![Build Status](https://travis-ci.org/BenEmdon/CenteredCollectionView.svg?branch=master)](https://travis-ci.org/BenEmdon/CenteredCollectionView)
[![Version](https://img.shields.io/cocoapods/v/CenteredCollectionView.svg?style=flat)](http://cocoapods.org/pods/CenteredCollectionView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org)
[![Platform](https://img.shields.io/badge/platforms-iOS%20%7C%20tvOS-orange.svg)](http://cocoapods.org/pods/CenteredCollectionView)

`CenteredCollectionView` is a lightweight drop in place `UICollectionViewFlowLayout` that _pages_ and keeps its cells centered, resulting in the _"carousel effect"_ 🎡

## Example

![Demo](/.github/demo.gif)

To try the example using Cocoapods:
```bash
pod try CenteredCollectionView
```

## Requirements
This pod requires a deployment target of iOS 9.0 or greater

## Installation

CenteredCollectionView is available through [Swift Package Manager](https://swift.org/package-manager/), [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage).

To install it with **Swift Package Manager**, add the URL `https://github.com/BenEmdon/CenteredCollectionView` in Xcode Add Package Dependency assistant ; or add to your own `Package.swift`:
```swift
dependencies: [
  .package(url: "https://github.com/BenEmdon/CenteredCollectionView", from: "2.2.2")
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

If you make a pull request or an issue, you're likely to get a _swift_ response!

## Author

[@BenEmdon 👨‍💻](https://twitter.com/BenEmdon)

## License

CenteredCollectionView is available under the MIT license. See the LICENSE file for more info.
