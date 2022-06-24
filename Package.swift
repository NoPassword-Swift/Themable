// swift-tools-version:5.0

import PackageDescription

let package = Package(
	name: "Themable",
	platforms: [
		.iOS("13.0"),
		.macOS("10.15"),
	],
	products: [
		.library(
			name: "Themable",
			targets: ["Themable"]),
	],
	dependencies: [
		.package(url: "https://github.com/NoPassword-Swift/CoreCombine.git", "0.0.1"..<"0.1.0"),
	],
	targets: [
		.target(
			name: "Themable",
			dependencies: [
				"CoreCombine",
			]),
	]
)
