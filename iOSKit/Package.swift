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
			name: "Network",
			targets: ["Network"]
		),
		.library(
			name: "Profile",
			targets: ["Profile"]
		),
		.library(
			name: "Services",
			targets: ["Services"]
		),
		.library(
			name: "Tools",
			targets: ["Tools"]
		),
	],
	dependencies: [
		.package(path: "../Themes"),
		.package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.2.2"),
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.9.2")
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
				"Network",
				"Tools",
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
			name: "Network",
			dependencies: [
				"Tools",
				.product(name: "Dependencies", package: "swift-dependencies")
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
				"Network",
				.product(name: "Dependencies", package: "swift-dependencies")
			]
		),
		.target(
			name: "Tools",
			dependencies: [
				.product(name: "Resources", package: "Themes"),
			]
		),
	]
)
