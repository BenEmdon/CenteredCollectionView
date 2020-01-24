// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "CenteredCollectionView",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9)
    ],
    products: [
        .library(name: "CenteredCollectionView", targets: ["CenteredCollectionView"]),
    ],
    targets: [
        .target(name: "CenteredCollectionView", path: "CenteredCollectionView/Classes")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
