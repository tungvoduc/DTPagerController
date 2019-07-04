// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "DTPagerController",
    products: [
        .library(name: "DTPagerController", targets: ["DTPagerController"]),
    ],
    targets: [
        .target(
            name: "DTPagerController",
            path: "DTPagerController/Classes"),
    ]
)
