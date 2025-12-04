// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "EventerSDK",
    platforms: [ .iOS(.v15) ],
    products: [
        .library(
            name: "EventerSDK",
            targets: ["EventerSDK"]
        ),
    ],

    targets: [
        .target(
            name: "EventerSDK",
            path: "Sources/",
            resources: [] // если будут картинки/JSON — здесь
        )
    ]
)
