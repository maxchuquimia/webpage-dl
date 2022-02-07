// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "webpage-dl",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/Building42/Telegraph.git", from: "0.29.0"),
    ],
    targets: [
        .executableTarget(
            name: "webpage-dl",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .testTarget(
            name: "webpage-dlTests",
            dependencies: [
                "webpage-dl",
                "Telegraph",
            ],
            resources: [
                .copy("Resources")
            ]
        ),
    ]
)
