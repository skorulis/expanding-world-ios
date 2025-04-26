// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        .package(path: "../Hex"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.18.1"
        ),
        .package(
            url: "https://github.com/koher/CGPointVector",
            from: "0.4.1"
        ),
        .package(path: "/Users/alex/dev/ios/knit")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                "Hex",
                .product(name: "CGPointVector", package: "CGPointVector"),
                .product(name: "Knit", package: "knit"),
            ],
            resources: [.process("Resource/Assets.xcassets")]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: [
                "Core",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
    ]
)
