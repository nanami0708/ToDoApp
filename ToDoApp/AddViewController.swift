//
//  AddViewController.swift
//  ToDoApp
//
//  Created by Nanami Mizuno on 2018/10/21.
//  Copyright © 2018年 Nanami Mizuno. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var array = [String]()
    
    let userDefaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func add(_ sender: Any) {
        
        //現在の配列の状況を取り出す
        if userDefaults.object(forKey: "array") != nil{
            array = userDefaults.object(forKey: "array") as! [String]
        }
        
        //テキストフィールドで記入されたテキストを配列に入れて
        
        array.append(textField.text!)
        
        //その配列をアプリ内に保存する
        userDefaults.set(array, forKey: "array")
        print(array)
        //画面を戻る
        self.navigationController?.popViewController(animated: true)
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
