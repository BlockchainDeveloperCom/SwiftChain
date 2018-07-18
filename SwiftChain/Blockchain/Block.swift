//
//  Block.swift
//  SwiftChainPackageDescription
//
//  Created by Pouria Almassi on 15/7/18.
//

import Foundation

struct Block: Codable {
    let index: Int
    let timestamp: Date
    let transactions: [Transaction]
    let proof: Int
    let lastBlockHash: Data?

    var hash: Data? {
        do {
            return try JSONEncoder().encode(self).sha256
        } catch {
            return nil
        }
    }
}

extension Block: CustomStringConvertible {
    var description: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let encoded = try? encoder.encode(self) else { return "" }
        return String(data: encoded, encoding: .utf8) ?? ""
    }
}
