// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Themes",
	platforms: [.iOS(.v17)],
	products: [
		.library(
			name: "Avocado",
			targets: ["Avocado"]
		),
		.library(
			name: "Baju",
			targets: ["Baju"]
		),
		.library(
			name: "Components",
			targets: ["Components"]
		),
		.library(
			name: "Resources",
			targets: ["Resources"]
		),
		.library(
			name: "Theme",
			targets: ["Theme"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/airbnb/lottie-ios", from: "4.4.1")
	],
	targets: [
		.target(
			name: "Avocado",
			dependencies: ["Components", "Resources"]
		),
		.target(
			name: "Baju",
			dependencies: ["Components"]
		),
		.target(
			name: "Components",
			dependencies: [
				"Resources",
				.product(name: "Lottie", package: "lottie-ios")
			]
		),
		.target(
			name: "Resources",
			resources: [
				.process("Animation/Assets"),
				.process("Colors/Assets"),
				.process("Fonts/Assets"),
				.process("Images/Assets"),
			]
		),
		.target(
			name: "Theme",
			dependencies: [
				"Avocado",
				"Baju",
			]
		),
	]
)
