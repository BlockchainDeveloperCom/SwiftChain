//
//  ViewController.swift
//  SwiftChain
//
//  Created by Almassi, Pouria on 18/7/18.
//  Copyright © 2018 Blockchain Developer. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private let server = Server(blockchain: Blockchain())
    @IBOutlet var textView: UITextView!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var senderLabel: UILabel!
    @IBOutlet var recipientLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = server.chain.description
    }

    @IBAction func addTransaction(_ sender: UIButton) {
        // guard
        //     let amountString = amountLabel.text,
        //     let amountValue = Double(amountString),
        //     let senderString = senderLabel.text,
        //     let recipientString = recipientLabel.text else { return }
        // server.addTransaction(with: Transaction(sender: senderString, recipient: recipientString, amount: amountValue))
        server.addTransaction(with: Transaction(sender: "me", recipient: "you", amount: 500.0))
    }

    @IBAction func mine(_ sender: UIButton) {
        server.mine(recipient: "me") { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(_): self.textView.text = self.server.chain.description
            case .fail: print("Error: failed to mine block.")
            }
        }
    }
}
