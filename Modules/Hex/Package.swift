// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hex",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Hex",
            targets: ["Hex"]),
    ],
    dependencies: [
      .package(
        url: "https://github.com/pointfreeco/swift-snapshot-testing",
        from: "1.18.1"
      ),
      .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Hex"),
        .testTarget(
            name: "HexTests",
            dependencies: [
                "Hex",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "Numerics", package: "swift-numerics"),
            ]
        ),
    ]
)
