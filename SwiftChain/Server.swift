//
//  Server.swift
//  SwiftChainPackageDescription
//
//  Created by Pouria Almassi on 15/7/18.
//

import Foundation

enum Result<T> {
    case success(T)
    case fail
}

final class Server {
    private var blockchain: Blockchain

    init(blockchain: Blockchain) {
        self.blockchain = blockchain
    }

    // GET /mine
    func mine(recipient: String, completion: ((Result<Block>) -> ())?) {
        // We run the proof of work algorithm to get the next proof...
        guard let lastBlock = blockchain.lastBlock else {
            completion?(Result.fail)
            return
        }
        let proof = blockchain.proofOfWork(lastBlock.proof)

        // We must receive a reward for finding the proof.
        // The sender is "0" to signify that this node has mined a new coin.
        let transaction = Transaction(sender: "0", recipient: recipient, amount: 1.0)
        blockchain.addTransaction(with: transaction)

        // Forge the new block by adding it to the chain
        let block = blockchain.createBlock(proof: proof)
        completion?(Result.success(block))
    }

    // POST /transactions/new
    func addTransaction(with transaction: Transaction) {
        blockchain.addTransaction(with: transaction)
    }

    // GET /chain
    var chain: [Block] { return blockchain.chain }
}
