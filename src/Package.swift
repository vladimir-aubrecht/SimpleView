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
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.5.1"),
        .package(url: "https://github.com/seanparsons/SwiftTryCatch.git", .revision("e7074a72e4d4dc516f391bc4d4afd8ca6a845b4b"))
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
