import PackageDescription

let package = Package(
    name: "SwiftChain",
    dependencies: [
        .Package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", versions: Version(0,8,0)..<Version(0,8,3))
    ]
)
