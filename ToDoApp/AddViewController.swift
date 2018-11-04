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
//    var datePicker: UIDatePicker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    let list = ["赤", "黒", "黄色", "緑", "グレー", "オレンジ", "ピンク"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //↓ここから文字色
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x:0, y:0, width:view.frame.size.width, height:35))
        let colorDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(stringColorDone))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, colorDoneItem], animated: true)
        
        self.mojiColor.inputView = pickerView
        self.mojiColor.inputAccessoryView = toolbar
        
        //↑ここまで文字色
        
     //↓ここから期限設定
        
        //datepicker上のtoolbarのdoneボタン
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: "doneBtn")
        toolBar.items = [toolBarBtn]
        dateText.inputAccessoryView = toolBar
        
        // ピッカー設定
//        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
//        datePicker.timeZone = NSTimeZone.local
//        datePicker.locale = Locale.current
//        dateText.inputView = datePicker
//
//        // 決定バーの生成
//        let dateToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
////        let dateDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateDone))
////        toolbar.setItems([spacelItem, dateDoneItem], animated: true)
//
//        // インプットビュー設定
//        self.dateText.inputView = datePicker
//        self.dateText.inputAccessoryView = dateToolbar
     //↑ここまで期限設定
        // ->背景色をグレーに変更する
        self.view.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    
//    // 決定ボタン押下
//    @objc func dateDone() {
//        dateText.endEditing(true)
//
//        // 日付のフォーマット
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        dateText.text = "\(formatter.string(from: Date()))"
//    }
    
    //↓ここから期限
    
    //テキストフィールドが選択されたらdatepickerを表示
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), for: UIControl.Event.valueChanged)
    }
    
    //datepickerが選択されたらtextfieldに表示
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd";
        dateText.text = dateFormatter.string(from: sender.date)
    }
    
    //toolbarのdoneボタン
    func doneBtn(){
        dateText.resignFirstResponder()
    }
    
    //↑ここまで期限
    
    @objc func cancel() {
        self.mojiColor.text = ""
        self.mojiColor.endEditing(true)
    }
    
    @objc func stringColorDone() {
        self.mojiColor.endEditing(true)
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
