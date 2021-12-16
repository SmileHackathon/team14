//
//  MessageViewController.swift
//  ForWastedYou
//
//  Created by 石澤大輔 on 2021/12/12.
//

import UIKit

class MessageViewController: UIViewController, UITextFieldDelegate {
    
    var messageFields: [UITextField]?
    
    
    @IBOutlet weak var addTextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextButton.setTitle("addText", for: .normal)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func TappedAddTextButton(_ sender: Any) {
        
        let unitWidth = view.frame.width
        let unitHeight = view.frame.height
        
        let messageField: UITextField = UITextField(frame: CGRect(x: unitWidth/2, y: unitHeight/2, width: 50.0, height: 50.0))
        messageField.delegate = self
        messageField.placeholder = "入力してください。"
        messageField.keyboardType = UIKeyboardType.default
        messageFields?.append(messageField)
        self.view.addSubview(messageField)
        print("作ったよ")
    }
    
    
}
