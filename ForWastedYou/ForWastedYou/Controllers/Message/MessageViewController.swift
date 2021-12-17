//
//  MessageViewController.swift
//  ForWastedYou
//
//  Created by 石澤大輔 on 2021/12/12.
//

import UIKit

class MessageViewController: UIViewController, UITextFieldDelegate {
    
    var messageViews: [UITextView]? = []
    var prevPinch: CGFloat = 1
    let pinchGesture = UIPinchGestureRecognizer()
    
    @IBOutlet weak var addTextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextButton.setTitle("addText", for: .normal)
        
        
        pinchGesture.addTarget(self, action: #selector(pinchAction(_:)))
    }
    
    
    @objc func pinchAction(_ gesture: UIPinchGestureRecognizer) {
        if messageViews!.count > 0 {
            print("pinchUp")
            let rate = gesture.scale - 1 + prevPinch
            
            self.messageViews![messageViews!.count - 1].transform = CGAffineTransform(scaleX: rate, y: rate)
            
            if (gesture.state == .ended) {
                prevPinch = rate
            }
        }
    }
    
    
    
    @IBAction func TappedAddTextButton(_ sender: Any) {
        
        let unitWidth = view.frame.width
        let unitHeight = view.frame.height
        
        let messageView: UITextView = UITextView(frame: CGRect(x: unitWidth/2, y: unitHeight/2, width: 100.0, height: 70.0))
        messageView.keyboardType = UIKeyboardType.default
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        messageViews?.append(messageView)
        self.view.addSubview(messageView)
        self.messageViews![messageViews!.count - 1].addGestureRecognizer(pinchGesture)
        
        if messageViews!.count >= 2 {
            messageViews![messageViews!.count - 2].layer.borderWidth = 0
        }
        
        prevPinch = 1
        print("作ったよ")
    }
    
    @IBAction func tappedDebugButton(_ sender: Any) {
        print(messageViews!.count)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if messageViews!.count > 0 {
            print("tochesBegan")
            let messageArrayNumber = messageViews!.count - 1
            
            // Labelアニメーション.
            UITextView.animate(withDuration: 0.06,
                    // アニメーション中の処理.
                animations: { () -> Void in
                    // 縮小用アフィン行列を作成する.
                self.messageViews![messageArrayNumber].transform = CGAffineTransform(scaleX: (self.prevPinch * 0.9), y: (self.prevPinch * 0.9))
                })
            { (Bool) -> Void in
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if messageViews!.count > 0 {
            //print("touchsMoved")
            
            let messageArrayNumber = messageViews!.count - 1
            
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

        
        if messageViews!.count > 0 {
            print("touchesEnd")
            /*
            let messageArrayNumber = messageViews!.count - 1
            
            // Labelアニメーション.
            UITextView.animate(withDuration: 0.1,
                
                // アニメーション中の処理.
                animations: { () -> Void in
                    // 拡大用アフィン行列を作成する.
                self.messageViews![messageArrayNumber].transform = CGAffineTransform(scaleX: (self.prevPinch * 0.4), y: (self.prevPinch * 0.4))
                    // 縮小用アフィン行列を作成する.
                self.messageViews![messageArrayNumber].transform = CGAffineTransform(scaleX: (self.prevPinch * 1.0), y: (self.prevPinch * 1.0))
                })
            { (Bool) -> Void in

            }*/
        }
    }
    
}
