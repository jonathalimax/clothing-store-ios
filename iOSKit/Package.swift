// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "iOSKit",
	platforms: [.iOS(.v17)],
	products: [
		.library(
			name: "Authentication",
			targets: ["Authentication"]
		),
		.library(
			name: "Feed",
			targets: ["Feed"]
		),
		.library(
			name: "Main",
			targets: ["Main"]
		),
		.library(
			name: "Profile",
			targets: ["Profile"]
		),
		.library(
			name: "Services",
			targets: ["Services"]
		),
	],
	dependencies: [
		.package(path: "../Themes"),
		.package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.2.1"),
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.8.0")
	],
	targets: [
		.target(
			name: "Authentication",
			dependencies: [
				.byName(name: "Services"),
				.product(name: "Components", package: "Themes"),
				.product(name: "Resources", package: "Themes"),
				.product(name: "Theme", package: "Themes"),
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
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
		),
		.target(
			name: "Main",
			dependencies: [
				.byName(name: "Authentication"),
				.byName(name: "Feed"),
				.byName(name: "Profile"),
				.product(name: "Components", package: "Themes"),
				.product(name: "Resources", package: "Themes"),
				.product(name: "Theme", package: "Themes"),
			]
		),
		.target(
			name: "Profile",
			dependencies: [
				.byName(name: "Authentication"),
				.product(name: "Resources", package: "Themes"),
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
			]
		),
		.target(
			name: "Services",
			dependencies: [
				.product(name: "Dependencies", package: "swift-dependencies")
			]
		),
	]
)
