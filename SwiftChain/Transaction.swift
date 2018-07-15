//
//  Transaction.swift
//  SwiftChainPackageDescription
//
//  Created by Pouria Almassi on 4/6/18.
//

import Foundation

struct Transaction: Codable {
    let sender: String
    let recipient: String
    let amount: Double
}
