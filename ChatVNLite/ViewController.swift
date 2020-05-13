//
//  ViewController.swift
//  ChatVNLite
//
//  Created by hien on 5/13/20.
//  Copyright © 2020 hien. All rights reserved.
//

import UIKit
import Firebase


let kCollectionKey = "Chat"
let kDocumentKey = "Message"
let kNameField = "Annonimous"

class ViewController: UIViewController {
    
    private let chatDb = Firestore.firestore().collection(kCollectionKey).document(kDocumentKey)

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBAction func sendMessage(_ sender: UIButton) {
        let message = inputField.text ?? ""
        chatDb.setData([kNameField:message]) { (error) in
            print("Send Ok")
        }
    }
    
    private func updateListener() {
        chatDb.addSnapshotListener { (snapshot, error) in
            if let snapshot = snapshot, snapshot.exists, let data = snapshot.data() {
                self.messageLabel.text = data[kNameField] as? String ?? "error"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateListener()
    }
}

