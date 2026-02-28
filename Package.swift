// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "PokemonCalcCross",
    defaultLocalization: "en",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .macCatalyst(.v13)],
    dependencies: [
        .package(
            url: "https://github.com/moreSwift/swift-cross-ui",
            revision: "611e31651031bffcc7db6d3544805c54aedab338"
        )
    ],
    targets: [
        .executableTarget(
            name: "PokemonCalcCross",
            dependencies: [
                .product(name: "SwiftCrossUI", package: "swift-cross-ui"),
                .product(name: "DefaultBackend", package: "swift-cross-ui"),
            ],
            resources: [
                .process("Resources"),
//                .process("Resources/zh-Hans.lproj"),
            ]
        )
    ]
)
