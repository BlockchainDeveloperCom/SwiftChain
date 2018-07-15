import PackageDescription

let package = Package(
    name: "SwiftChain",
    dependencies: [
        .Package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", Version("0.9.0"))
    ]
)
