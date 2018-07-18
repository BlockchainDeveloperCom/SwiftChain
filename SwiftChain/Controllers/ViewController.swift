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

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = server.chain.description
    }

    @IBAction func addTransaction(_ sender: UIButton) {
        let alert = UIAlertController(title: "",
                                      message: nil,
                                      preferredStyle: .alert)

        alert.addTextField { tf in tf.placeholder = "Sender" }
        alert.addTextField { tf in tf.placeholder = "Recipient" }
        alert.addTextField { tf in tf.placeholder = "Amount"; tf.keyboardType = .decimalPad }

        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard
                let `self` = self,
                let textFields = alert.textFields,
                let senderString = textFields[0].text,
                let recipientString = textFields[1].text,
                !senderString.isEmpty,
                !recipientString.isEmpty,
                let amountString = textFields[2].text,
                let amountValue = Double(amountString)
                else { return }

            self.server.addTransaction(with: Transaction(sender: senderString,
                                                         recipient: recipientString,
                                                         amount: amountValue))
        }

        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true, completion: nil)
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
