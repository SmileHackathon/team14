//
//  TopViewController.swift
//  ForWastedYou
//
//  Created by 石澤大輔 on 2021/12/12.
//

import UIKit

class TopViewController: UIViewController {
    //UILabelの変数宣言は、Titleにて使用
    @IBOutlet weak var myLabel_haikei: UILabel!
    @IBOutlet weak var my_Label_yoitubure: UILabel!
    @IBOutlet weak var TitleMenu: UILabel!
    
    @IBOutlet weak var TitileSTART: UIButton!
    @IBOutlet weak var TItleINF: UIButton!
    @IBOutlet weak var TitleHELP: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //haikeiとyoitubureはTitleにて使用
        myLabel_haikei.text = "拝啓"
        my_Label_yoitubure.text = "〜酔い潰れた君へ〜"
        TitleMenu.text = "本日のお品書き"
        
        //TitleButtonの設定
        TitileSTART.titleLabel!.font = UIFont(name: ".SFNS-Regular",size: CGFloat(30))
        TItleINF?.titleLabel!.font = UIFont(name: ".SFNS-Regular",size: CGFloat(30))
        TitleHELP?.titleLabel!.font = UIFont(name: ".SFNS-Regular",size: CGFloat(30))

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
