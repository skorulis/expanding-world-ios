// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Battler",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Battler",
            targets: ["Battler"]),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../DesignSystem"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.18.1"
        ),
        .package(
            url: "https://github.com/skorulis/ASKCoordinator",
            branch: "main"
        ),
        .package(url: "https://github.com/cashapp/knit.git", branch: "skorulis/resolver-class"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Battler",
            dependencies: [
                "Core",
                "DesignSystem",
                .product(name: "Knit", package: "knit"),
                .product(name: "ASKCoordinator", package: "ASKCoordinator"),
            ],
            resources: [.process("Resource/Assets.xcassets")],
            plugins: [
                .plugin(name: "KnitBuildPlugin", package: "knit")
            ]
        ),
        .testTarget(
            name: "BattlerTests",
            dependencies: [
                "Battler",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "Numerics", package: "swift-numerics"),
            ]
        ),
    ]
)
