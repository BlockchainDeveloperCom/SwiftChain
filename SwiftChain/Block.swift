//
//  Block.swift
//  SwiftChainPackageDescription
//
//  Created by Pouria Almassi on 15/7/18.
//

import Foundation
import CryptoSwift

struct Block: Codable {
    let index: Int
    let timestamp: Date
    let transactions: [Transaction]
    let proof: Int
    let lastBlockHash: Data?

    var hash: Data? {
        do {
            let data = try JSONEncoder().encode(self)
            return data.sha256()
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
