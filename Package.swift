// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "PokemonCalcCross",
    defaultLocalization: "en",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "PokemonCalc", targets: ["PokemonCalcCross"]),
        .library(name: "PokemonCore", targets: ["PokemonCore"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/moreSwift/swift-cross-ui",
            revision: "611e31651031bffcc7db6d3544805c54aedab338"
        )
    ],
    targets: [
        .target(name: "PokemonCore"),
        .testTarget(name: "PokemonCoreTest", dependencies: ["PokemonCore"]),
        .executableTarget(
            name: "PokemonCalcCross",
            dependencies: [
                .target(name: "PokemonCore"),
                .product(name: "SwiftCrossUI", package: "swift-cross-ui"),
                .product(name: "DefaultBackend", package: "swift-cross-ui"),
            ],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
