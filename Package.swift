// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "CenteredCollectionView",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13)
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
