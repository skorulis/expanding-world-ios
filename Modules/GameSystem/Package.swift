// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameSystem",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GameSystem",
            targets: ["GameSystem"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/cashapp/knit.git",
            branch: "skorulis/spm-plugin"
        ),
        .package(
            url: "https://github.com/skorulis/ASKCore",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "GameSystem",
            dependencies: [
                .product(name: "Knit", package: "knit"),
                .product(name: "KnitMacros", package: "knit"),
                .product(name: "ASKCore", package: "ASKCore"),
            ],
            plugins: [
                .plugin(name: "KnitBuildPlugin", package: "knit")
            ]
        ),
    ]
)
