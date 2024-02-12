// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "CSKit",
	platforms: [.iOS(.v17)],
	products: [
		.library(
			name: "Feed",
			targets: ["Feed"]
		),
	],
	dependencies: [
		.package(path: "../Themes"),
	],
	targets: [
		.target(
			name: "Feed",
			dependencies: [
				.product(name: "Resources", package: "Themes"),
				.product(name: "Components", package: "Themes"),
				.product(name: "Theme", package: "Themes")
			]
		),
		.testTarget(
			name: "FedeTests",
			dependencies: ["Feed"]
		),
	]
)
