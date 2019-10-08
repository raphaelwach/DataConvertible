// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "DataConvertible",
	platforms: [
		.macOS(.v10_15),
		.iOS(.v13)
	],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "DataConvertible",
            targets: ["DataConvertible"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "DataConvertible",
            dependencies: []),
        .testTarget(
            name: "DataConvertibleTests",
            dependencies: ["DataConvertible"]),
    ]
)
