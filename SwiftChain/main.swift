//
//  main.swift
//  SwiftChain
//
//  Created by Pouria Almassi on 25/2/18.
//  Copyright © 2018 Pouria Almassi. All rights reserved.
//

import Foundation

let server = Server(blockchain: Blockchain())

server.addTransaction(with: Transaction(sender: "Mulder", recipient: "Skully", amount: 1000.0))

server.addTransaction(with: Transaction(sender: "Cigarette Smoking Man", recipient: "Mulder", amount: 2500.0))

server.mine(recipient: "miner0") { result in
    switch result {
    case .success(_): print("Successfully mined block.")
    case .fail: print("Error: failed to mine block.")
    }
}

print("Current chain: \(server.chain.description)")
