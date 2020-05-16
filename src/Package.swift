// swift-tools-version:4.0
//
//  Package.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 03/08/2017.
//  Copyright © 2017 Vladimir Aubrecht. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "SimpleView",
    products: [
        .executable(name: "SimpleView", targets: ["SimpleView"])
        ],
    dependencies: [
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMajor(from: "1.9.0")),
        .package(url: "https://github.com/seanparsons/SwiftTryCatch.git", .revision("6a177252cfa2ef649b0aa7b2d16ab221386ca51c"))
    ],
    targets: [
        .target(
            name: "SimpleView",
            dependencies: [
                "SwiftyBeaver",
                "SwiftTryCatch"
                ]
        )
    ]
)
