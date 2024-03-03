// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RexpaySDK",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RexpaySDK",
            targets: ["RexpaySDK"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RexpaySDK",
            dependencies: ["ObjectivePGP"],
            path: "RexpaySDK",
            exclude: [
                "Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/ObjectivePGP",
                "Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/Current/Resources/Info.plist",
                "Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/A/Resources/Info.plist",
                "Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/Current/Resources/LICENSE.txt",
                "Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Resources/Info.plist",
                "Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/A/ObjectivePGP",
                "Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Resources/LICENSE.txt",
                "Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/A/Resources/LICENSE.txt",
                "Frameworks/ObjectivePGP.xcframework/macos-arm64_x86_64/ObjectivePGP.framework/Versions/Current/ObjectivePGP"
        ],
        resources: [
            .process("Resources"),
            .process("ReadmeFiles")
        ]
        ),
        .binaryTarget(
            name: "ObjectivePGP",
            path: "RexpaySDK/Frameworks/ObjectivePGP.xcframework"
        )
    ]
)
