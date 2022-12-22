// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SimpleLayout",
    products: [
        .library(
            name: "SimpleLayout",
            targets: ["SimpleLayout"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SimpleLayout",
            dependencies: [],
            path: "SimpleLayout/Sources"),
        .testTarget(
            name: "SimpleLayoutTests",
            dependencies: ["SimpleLayout"],
            path: "SimpleLayout/Tests"),
    ]
)
