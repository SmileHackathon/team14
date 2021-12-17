//
//  MessageViewController.swift
//  ForWastedYou
//
//  Created by 石澤大輔 on 2021/12/12.
//

import UIKit

class MessageViewController: UIViewController, UITextFieldDelegate {
    
    var messageViews: [UITextView]? = []
    
    
    @IBOutlet weak var addTextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextButton.setTitle("addText", for: .normal)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func TappedAddTextButton(_ sender: Any) {
        
        let unitWidth = view.frame.width
        let unitHeight = view.frame.height
        
        let messageView: UITextView = UITextView(frame: CGRect(x: unitWidth/2, y: unitHeight/2, width: 50.0, height: 50.0))
        messageView.keyboardType = UIKeyboardType.default
        messageView.layer.borderWidth = 5
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        messageViews?.append(messageView)
        self.view.addSubview(messageView)
        print("作ったよ")
    }
    
    @IBAction func tappedDebugButton(_ sender: Any) {
        print(messageViews!.count)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let messageFieldsArray = messageViews {
            print("tochesBegan")
            let messageArrayNumber = messageFieldsArray.count - 1
            
            // Labelアニメーション.
            UIView.animate(withDuration: 0.06,
                                       // アニメーション中の処理.
                animations: { () -> Void in
                    // 縮小用アフィン行列を作成する.
                self.messageViews![messageArrayNumber].transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                })
            { (Bool) -> Void in
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let messageFieldsArray = messageViews {
            print("touchsMoved")
            
            let messageArrayNumber = messageFieldsArray.count - 1
            
            let aTouch: UITouch = touches.first!
            
            let location = aTouch.location(in: self.messageViews![messageArrayNumber])
            
            let prevLocation = aTouch.previousLocation(in: self.messageViews![messageArrayNumber])
            
            var myFrame: CGRect = self.messageViews![messageArrayNumber].frame
            
            let deltaX: CGFloat = location.x - prevLocation.x
            let deltaY: CGFloat = location.y - prevLocation.y
            
            myFrame.origin.x += deltaX
            myFrame.origin.y += deltaY
            
            self.messageViews![messageArrayNumber].frame = myFrame
                
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        
        if let messageFieldsArray = messageViews {
            print("touchesEnd")
            
            let messageArrayNumber = messageFieldsArray.count - 1
            
            // Labelアニメーション.
            UIView.animate(withDuration: 0.1,

                // アニメーション中の処理.
                animations: { () -> Void in
                    // 拡大用アフィン行列を作成する.
                    self.messageViews![messageArrayNumber].transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                    // 縮小用アフィン行列を作成する.
                    self.messageViews![messageArrayNumber].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            { (Bool) -> Void in

            }
        }
    }
    
}
