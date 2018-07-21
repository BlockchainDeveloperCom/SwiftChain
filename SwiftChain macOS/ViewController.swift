//
//  ViewController.swift
//  SwiftChain macOS
//
//  Created by Pouria Almassi on 21/7/18.
//  Copyright © 2018 Blockchain Developer. All rights reserved.
//

import Cocoa

final class ViewController: NSViewController {

    // MARK: - Properties

    private let server = Server(blockchain: Blockchain())
    @IBOutlet var textView: NSTextView!
    @IBOutlet var senderTextField: NSTextField!
    @IBOutlet var recipientTextField: NSTextField!
    @IBOutlet var amountTextField: NSTextField!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        textView.string = server.chain.description
    }

    // MARK: - Actions

    @IBAction func addTransaction(_ sender: NSButton) {
        guard
            !senderTextField.stringValue.isEmpty,
            !recipientTextField.stringValue.isEmpty,
            !amountTextField.stringValue.isEmpty,
            let amountValue = Double(amountTextField.stringValue)
            else {
                return
        }

        server.addTransaction(with: Transaction(sender: senderTextField.stringValue,
                                                recipient: recipientTextField.stringValue,
                                                amount: amountValue))
        senderTextField.stringValue = ""
        recipientTextField.stringValue = ""
        amountTextField.stringValue = ""
    }

    @IBAction func mine(_ sender: NSButton) {
        server.mine(recipient: "me") { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(_): self.textView.string = self.server.chain.description
            case .fail: print("Error: failed to mine block.")
            }
        }
    }
}

