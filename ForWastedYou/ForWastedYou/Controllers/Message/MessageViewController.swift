//
//  MessageViewController.swift
//  ForWastedYou
//
//  Created by 石澤大輔 on 2021/12/12.
//

import UIKit

class MessageViewController: UIViewController {
    
    
    @IBOutlet weak var addTextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextButton.setTitle("addText", for: .normal)

        // Do any additional setup after loading the view.
    }
    
    
    
}
