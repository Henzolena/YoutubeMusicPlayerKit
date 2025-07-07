// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "YoutubeMusicPlayerKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "YoutubeMusicPlayerKit",
            targets: [
                "YoutubeMusicPlayerKitKit"
            ]
        )
    ],
    targets: [
        .target(
            name: "YoutubeMusicPlayerKitKit",
            path: "Sources"
        ),
        .testTarget(
            name: "YoutubeMusicPlayerKitKitTests",
            dependencies: [
                "YoutubeMusicPlayerKitKit"
            ],
            path: "Tests"
        )
    ]
)
