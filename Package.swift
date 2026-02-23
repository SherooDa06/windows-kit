// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "windows-kit",
    products: [
        .plugin(name: "windows-kit", targets: ["Plugin"]),
    ],

    dependencies: [
        .package(url: "https://github.com/apple/swift-binary-parsing", branch: "main"),
        .package(url: "https://github.com/apple/swift-system", branch: "main"),
        .package(url: "https://github.com/apple/swift-algorithms", branch: "main"),
    ],

    targets: [
        .executableTarget(
            name: "Generator",
            dependencies: [
                .product(name: "BinaryParsing", package: "swift-binary-parsing"),
                .product(name: "SystemPackage", package: "swift-system"),
                .product(name: "Algorithms", package: "swift-algorithms"),
            ],
            swiftSettings: [
                .enableExperimentalFeature("Lifetimes"),
            ]
        ),
        .plugin(
            name: "Plugin",
            capability: .command(
                intent: .custom(verb: "Generate", description: ""),
                permissions: [.writeToPackageDirectory(reason: "This command generates bindings to Windows APIs")]
            ),
            dependencies: ["Generator"]
        ),
    ]
)
