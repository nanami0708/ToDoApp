//
//  AddViewController.swift
//  ToDoApp
//
//  Created by Nanami Mizuno on 2018/10/21.
//  Copyright © 2018年 Nanami Mizuno. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var mojiColor: UITextField!
    
    var toolBar:UIToolbar!
    var datePicker: UIDatePicker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    let list = ["赤", "黒", "黄色", "緑", "グレー", "オレンジ", "ピンク"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //↓ここから期限設定
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        //datepicker上のtoolbarのdoneボタン
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .done, target: self, action: #selector(dateDone))
        //キャンセルボタン dateCancelを呼び出す
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dateCancel))
        // ツールバーに登録
        toolBar.items = [toolBarBtn, cancelItem]
        dateText.inputAccessoryView = toolBar
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        dateText.inputView = datePicker
        //↑ここまで期限設定
        
        
        //↓ここから文字色ピッカー
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true

        //pickerView上のtoolbar
        let colorPickerToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:view.frame.size.width, height:35))
        // Doneボタン
        let colorDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(colorDone))
        // キャンセルボタン
        let colorCancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(colorCancel))
        // ツールバーに登録
        colorPickerToolbar.setItems([colorDoneItem, colorCancelItem], animated: true)
        self.mojiColor.inputView = pickerView
        self.mojiColor.inputAccessoryView = colorPickerToolbar
        //↑ここまで文字色
        
        // ->背景色をグレーに変更する
        self.view.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        
        
    }
    
    // 日付決定ボタンを押した時
    @objc func dateDone() {
        dateText.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateText.text = formatter.string(from: datePicker.date)
       
    }
    
    // 日付キャンセルボタンを押した時
    @objc func dateCancel() {
        dateText.text = ""
        dateText.resignFirstResponder()
    }
    
    // カラーDoneボタンを押した時
    @objc func colorDone() {
        self.mojiColor.endEditing(true)
        dateText.resignFirstResponder()
    }
    
    // カラーキャンセルボタンを押した時
    @objc func colorCancel() {
        self.mojiColor.endEditing(true)
        dateText.resignFirstResponder()
    }
    
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    var array = [String]()
    
    let userDefaults: UserDefaults = UserDefaults.standard
    
    @IBAction func back(_ sender: Any){
        //画面を戻る
        self.navigationController?.popViewController(animated: true)
        
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.mojiColor.text = list[row]
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
