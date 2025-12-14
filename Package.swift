// swift-tools-version: 6.2
import PackageDescription

let package = Package(
  name: "app-run-playground",
  platforms: [.macOS(.v26)],
  dependencies: [
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0")
  ],
  targets: [
    .executableTarget(
      name: "App",
      dependencies: [
        .product(name: "Vapor", package: "vapor")
      ],
      swiftSettings: swiftSettings,
    ),
    .testTarget(
      name: "AppTests",
      dependencies: [
        .target(name: "App"),

        .product(name: "VaporTesting", package: "vapor"),
      ],
      swiftSettings: swiftSettings,
    ),
  ],
  swiftLanguageModes: [.v6],
)
var swiftSettings: [SwiftSetting] {
  [
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("NonescapableTypes"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
  ]
}
