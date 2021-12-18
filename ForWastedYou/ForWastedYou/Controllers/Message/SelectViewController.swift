//
//  SelectViewController.swift
//  ForWastedYou
//
//  Created by 石澤大輔 on 2021/12/18.
//

import UIKit

class SelectViewController: UIViewController {

    @IBOutlet weak var girlTextView: UIView!
    @IBOutlet weak var inputNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // segueのIDを確認して特定のsegueのときのみ動作させる
            if segue.identifier == "toMessageMake" {
                // 2. 遷移先のViewControllerを取得
                let next = segue.destination as? MessageViewController
                // 3. １で用意した遷移先の変数に値を渡す
                next?.name = self.inputNameTextField.text
            }
        }
    
    
    @IBAction func toMessageButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toMessageMake", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // キーボードを閉じる
            textField.resignFirstResponder()
            return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
