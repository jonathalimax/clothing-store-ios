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
		.library(
			name: "Main",
			targets: ["Main"]
		),
	],
	dependencies: [
		.package(path: "../Themes"),
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.8.0")
	],
	targets: [
		.target(
			name: "Main",
			dependencies: [
				.product(name: "Components", package: "Themes"),
				.product(name: "Resources", package: "Themes"),
				.product(name: "Theme", package: "Themes"),
				.byName(name: "Feed"),
			]
		),
		.target(
			name: "Feed",
			dependencies: [
				.product(name: "Components", package: "Themes"),
				.product(name: "Resources", package: "Themes"),
				.product(name: "Theme", package: "Themes"),
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
			]
		)
	]
)
