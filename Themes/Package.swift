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
			name: "Components"
		),
		.target(
			name: "Resources",
			resources: [
				.process("Colors.xcassets")
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
