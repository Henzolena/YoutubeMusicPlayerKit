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
                "YoutubeMusicPlayerKit"
            ]
        )
    ],
    targets: [
        .target(
            name: "YoutubeMusicPlayerKit",
            path: "Sources"
        ),
        .testTarget(
            name: "YoutubeMusicPlayerKitTests",
            dependencies: [
                "YoutubeMusicPlayerKit"
            ],
            path: "Tests"
        )
    ]
)
