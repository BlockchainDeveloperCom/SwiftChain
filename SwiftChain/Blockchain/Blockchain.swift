//
//  Blockchain.swift
//  SwiftChainPackageDescription
//
//  Created by Pouria Almassi on 4/6/18.
//

import Foundation

struct Blockchain {
    private var _chain: [Block]
    private var _transactions: [Transaction]

    var chain: [Block] { return _chain }
    var transactions: [Transaction] { return _transactions }
    var lastBlock: Block? {
        guard _chain.count > 0 else {
            return nil
        }
        return _chain[_chain.count - 1]
    }

    init() {
        _chain = [Block]()
        _transactions = [Transaction]()
        // Create the genesis block
        createBlock(with: "0".data(using: .utf8), proof: 100)
    }

    /// Create a new Block in the Blockchain
    /// parameter:
    /// parameter:
    /// return: Block
    @discardableResult
    mutating func createBlock(with lastBlockHash: Data? = nil, proof: Int) -> Block {
        let block = Block(index: _chain.count,
                          timestamp: Date(),
                          transactions: _transactions,
                          proof: proof,
                          lastBlockHash: lastBlockHash)
        _transactions = []
        _chain.append(block)
        return block
    }

    /// Creates a new transaction to go into the next mined Block
    /// param sender: <str> Address of the Sender
    /// param recipient: <str> Address of the Recipient
    /// param amount: <int> Amount
    /// return: <int> The index of the Block that will hold this transaction
    @discardableResult
    mutating func addTransaction(with transaction: Transaction) -> Int {
        _transactions.append(transaction)
        guard let lastBlock = lastBlock else {
            return -1
        }
        return lastBlock.index + 1
    }

    /// Simple Proof of Work Algorithm:
    /// - Find a number p' such that hash(pp') contains leading 4 zeroes, where p is the previous p'
    /// - p is the previous proof, and p' is the new proof
    func proofOfWork(_ lastProof: Int) -> Int {
        var proof = 0
        while !isValidProof(lastProof, proof: proof) {
            proof += 1
        }
        return proof
    }

    /// Validates the Proof: Does hash(last_proof, proof) contain 4 leading zeros
    func isValidProof(_ lastProof: Int, proof: Int) -> Bool {
        guard let guess = Data(base64Encoded: "f\(lastProof)\(proof)") else {
            return false
        }
        let guessHash = guess.sha256.hexEncodedString()
        let offset = 1 // easy v hard
        let index = guessHash.index(guessHash.startIndex, offsetBy: offset)
        let result = String(guessHash[..<index]) == "0"         // easy
        //let result = String(guessHash[..<index]) == "0000"    // hard
        return result
    }
}
