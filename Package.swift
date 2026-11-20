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
        .target(name: "CenteredCollectionView", path: "CenteredCollectionView/Classes"),
        .testTarget(
            name: "CenteredCollectionViewTests",
            dependencies: ["CenteredCollectionView"],
            path: "Example/Tests",
            exclude: ["Info.plist"]
        )
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
