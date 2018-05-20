//
//  main.swift
//  SwiftChain
//
//  Created by Pouria Almassi on 25/2/18.
//  Copyright © 2018 Pouria Almassi. All rights reserved.
//

/*

 # NOTES
 - difficult to find but easy to verify

 ## Last Position
 - Step 2: Our Blockchain as an API

 ## Sources
 - https://hackernoon.com/learn-blockchains-by-building-one-117428612f46
 - CryptoSwift

 */



import Foundation
import CryptoSwift

// MARK: - Type Aliases

// TODO: - Refactor.
typealias Block = [String : Any]

// MARK: -

struct Blockchain {
    var chain: [Block]
    var currentTransactions: [Transaction]

    init() {
        self.chain = [Block]()
        self.currentTransactions = [Transaction]()
        // Create the genesis block
        _ = self.newBlock(previousBlockHash: 1, proof: 100)
    }

    // TODO: Refactor. Why does this return? Should be init?
    mutating func newBlock(previousBlockHash: Int?, proof: Int) -> Block {
        guard let previousBlockHash = previousBlockHash else {
            let block: Block = [
                "index": 0,
                "timestamp": 0.0,
                "transactions": [],
                "proof": proof,
                "previousBlockHash": hash(from: chain[-1])
            ]
            currentTransactions = []
            chain.append(block)
            return block
        }

        let block: Block = [
            "index": 0,
            "timestamp": 0.0,
            "transactions": [],
            "proof": proof,
            "previousBlockHash": previousBlockHash
        ]

        // Reset the current list of transactions
        currentTransactions = []

        chain.append(block)
        return block
    }

    /// Creates a new transaction to go into the next mined Block
    /// param sender: <str> Address of the Sender
    /// param recipient: <str> Address of the Recipient
    /// param amount: <int> Amount
    /// return: <int> The index of the Block that will hold this transaction
    mutating func newTransaction(with transaction: Transaction) -> Int {
        currentTransactions.append(transaction)
        guard let indexOfLastBlock = lastBlock()["index"] as? Int else {
            return -1
        }
        return indexOfLastBlock + 1
    }

    func lastBlock() -> Block {
        return chain[chain.count - 1]
    }

    // Creates a SHA-256 hash of a Block
    func hash(from block: Block) -> Int {
        return 0
    }

    private func sha256(block: Block) -> Data? {
        let data = Data(base64Encoded: block.description)
        guard let nonNilData = data else { return nil }
        return nonNilData.sha256()
    }

    /// Simple Proof of Work Algorithm:
    /// - Find a number p' such that hash(pp') contains leading 4 zeroes, where p is the previous p'
    /// - p is the previous proof, and p' is the new proof
    func proofOfWork(_ lastProof: Int) -> Int {
        let proof = 0
        while !isValidProof(lastProof, proof: proof) {
            return proof + 1
        }
        return proof
    }

    /// Validates the Proof: Does hash(last_proof, proof) contain 4 leading zeroes?
    func isValidProof(_ lastProof: Int, proof: Int) -> Bool {
        guard let guess = Data(base64Encoded: "f\(lastProof)\(proof)") else { return false }
        let guessHash = guess.sha256().toHexString()
        let index = guessHash.index(guessHash.startIndex, offsetBy: 4)
        return guessHash[..<index] == "0000"
    }
}

// MARK: -

struct Transaction {
    private var sender: String
    private var recipient: String
    private var amount: Double
    init(sender: String, recipient: String, amount: Double) {
        self.sender = sender
        self.recipient = recipient
        self.amount = amount
    }
}
