//
//  AddViewController.swift
//  ToDoApp
//
//  Created by Nanami Mizuno on 2018/10/21.
//  Copyright © 2018年 Nanami Mizuno. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var mojiColor: UITextField!
    @IBOutlet weak var memo: UITextView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    
    var titleArray = [String]()
    
    let userDefaults: UserDefaults = UserDefaults.standard
    
    var saveData:UserDefaults = UserDefaults.standard
    var dayArray:[String] = []
    var mojiColorArray:[String] = []
    var memoArray:[String] = []
    
    
    var toolBar:UIToolbar!
    var datePicker: UIDatePicker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    let list = ["●", "●", "●", "●", "●", "●", "●", "●", "●", "●"]
    let display = ["赤", "ピンク", "紫", "青", "水色", "緑", "黄色", "オレンジ", "グレー", "黒"]
    
    override func viewDidLoad() {
        
//        textField.backgroundColor = UIColor(red: 0.26, green: 0.9, blue: 0.81, alpha: 0.5) //背景色の設定
        
        //元から入ってる文字
       textField.placeholder = "title"
        dateText.placeholder = "いつまで？"
        mojiColor.placeholder = "文字の色は？"
        
        
        //texufieldの枠線
        textField.borderStyle = UITextField.BorderStyle.line
        
        
        //textfield カーソルの色
        textField.tintColor = UIColor(red: 1, green: 0.435, blue: 0.38, alpha: 1.0)
        dateText.tintColor = UIColor(red: 1, green: 0.435, blue: 0.38, alpha: 1.0)
        mojiColor.tintColor = UIColor(red: 1, green: 0.435, blue: 0.38, alpha: 1.0)
        memo.tintColor = UIColor(red: 1, green: 0.435, blue: 0.38, alpha: 1.0)
        
        //テキストフィールド下線
        mojiColor.addUnderline(width: 1.0, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        dateText.addUnderline(width: 1.0, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        textField.delegate = self
        
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
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
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
    
    //returnが押されたらキーボードを閉じるtextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    //キーボード以外をタッチでキーボードを閉じるtextView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    //テキストフィールドが選択されたらdatepickerを表示
//    @IBAction func textFieldEditing(sender: UITextField) {
//        let datePickerView:UIDatePicker = UIDatePicker()
//        datePickerView.datePickerMode = UIDatePicker.Mode.date
//        sender.inputView = datePickerView
//        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), for: UIControl.Event.valueChanged)
//    }
//
//    //datepickerが選択されたらtextfieldに表示
//    func datePickerValueChanged(sender:UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy/MM/dd";
//        dateText.text = dateFormatter.string(from: sender.date)
//    }
    
//    //toolbarのdoneボタン
//    func doneBtn(){
//        dateText.resignFirstResponder()
//    }
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
        mojiColor.resignFirstResponder()
    }
    
    // カラーキャンセルボタンを押した時
    @objc func colorCancel() {
        self.mojiColor.endEditing(true)
        mojiColor.resignFirstResponder()
    }

    
    @IBAction func back(_ sender: Any){
        
        let alertController = UIAlertController(title: "保存されていません。",message: "保存しますか?", preferredStyle: .alert)
        
        //        ②-1 OKボタンの実装
        let okAction = UIAlertAction(title: "保存", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            //        ②-2 OKがクリックされた時の処理
            //title現在の配列の状況を取り出す
            if self.userDefaults.object(forKey: "titleArray") != nil{
                self.titleArray = self.userDefaults.object(forKey: "titleArray") as! [String]
            }
            //titleテキストフィールドで記入されたテキストを配列に入れて
            
            self.titleArray.append(self.textField.text!)
            
            //titleその配列をアプリ内に保存する
            self.userDefaults.set(self.titleArray, forKey: "titleArray")
            //print(titleArray)
            
            
            
            //day現在の配列の状況を取り出す
            if self.userDefaults.object(forKey: "dayArray") != nil{
                self.dayArray = self.userDefaults.object(forKey: "dayArray") as! [String]
            }
            //dayテキストフィールドで記入されたテキストを配列に入れて
            
            self.dayArray.append(self.dateText.text!)
            
            //dayその配列をアプリ内に保存する
            self.userDefaults.set(self.dayArray, forKey: "dayArray")
            
            
            
            //moji現在の配列の状況を取り出す
            if self.userDefaults.object(forKey: "mojiColorArray") != nil{
                self.mojiColorArray = self.userDefaults.object(forKey: "mojiColorArray") as! [String]
            }
            //mojiテキストフィールドで記入されたテキストを配列に入れて
            
            self.mojiColorArray.append(self.mojiColor.text!)
            
            //mojiその配列をアプリ内に保存する
            self.userDefaults.set(self.mojiColorArray, forKey: "mojiColorArray")
            
            
            
            //memo現在の配列の状況を取り出す
            if self.userDefaults.object(forKey: "memoArray") != nil{
                self.memoArray = self.userDefaults.object(forKey: "memoArray") as! [String]
            }
            //memoテキストフィールドで記入されたテキストを配列に入れて
            
            self.memoArray.append(self.memo.text!)
            
            //memoその配列をアプリ内に保存する
            self.userDefaults.set(self.memoArray, forKey: "memoArray")
            
            //画面を戻る
            self.navigationController?.popViewController(animated: true)
        
    }
        
        //        CANCELボタンの実装
        let cancelButton = UIAlertAction(title: "保存しない。", style: UIAlertAction.Style.cancel, handler: { action in
            //画面を戻る
            self.navigationController?.popViewController(animated: true)
        })
        
        //        ③-1 ボタンに追加
        alertController.addAction(okAction)
        //        ③-2 CANCELボタンの追加
        alertController.addAction(cancelButton)
        
        //        ④ アラートの表示
        present(alertController,animated: true,completion: nil)

    }
    
    @IBAction func add(_ sender: Any) {
        
        //title現在の配列の状況を取り出す
        if userDefaults.object(forKey: "titleArray") != nil{
            titleArray = userDefaults.object(forKey: "titleArray") as! [String]
        }
        //titleテキストフィールドで記入されたテキストを配列に入れて
        
        titleArray.append(textField.text!)
        
        //titleその配列をアプリ内に保存する
        userDefaults.set(titleArray, forKey: "titleArray")
        //print(titleArray)
        
        
        
        //day現在の配列の状況を取り出す
        if userDefaults.object(forKey: "dayArray") != nil{
            dayArray = userDefaults.object(forKey: "dayArray") as! [String]
        }
        //dayテキストフィールドで記入されたテキストを配列に入れて
        
        dayArray.append(dateText.text!)
        
        //dayその配列をアプリ内に保存する
        userDefaults.set(dayArray, forKey: "dayArray")
        
        
        
        //moji現在の配列の状況を取り出す
        if userDefaults.object(forKey: "mojiColorArray") != nil{
            mojiColorArray = userDefaults.object(forKey: "mojiColorArray") as! [String]
        }
        //mojiテキストフィールドで記入されたテキストを配列に入れて
        
        mojiColorArray.append(mojiColor.text!)
        
        //mojiその配列をアプリ内に保存する
        userDefaults.set(mojiColorArray, forKey: "mojiColorArray")
        
        
        
        //memo現在の配列の状況を取り出す
        if userDefaults.object(forKey: "memoArray") != nil{
            memoArray = userDefaults.object(forKey: "memoArray") as! [String]
        }
        //memoテキストフィールドで記入されたテキストを配列に入れて

        memoArray.append(memo.text!)

        //memoその配列をアプリ内に保存する
        userDefaults.set(memoArray, forKey: "memoArray")
        
        
        
        //画面を戻る
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return list[row]
//    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // 表示するラベルを生成する
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
        label.textAlignment = .center
        label.text = list[row]
        switch row {
        case 0:
            label.textColor = #colorLiteral(red: 0.9294117647, green: 0.3294117647, blue: 0.3568627451, alpha: 1)
        case 1:
            label.textColor = #colorLiteral(red: 1, green: 0.6549019608, blue: 0.7882352941, alpha: 1)
        case 2:
            label.textColor = #colorLiteral(red: 0.6731770833, green: 0.5671946674, blue: 0.9686274529, alpha: 1)
        case 3:
            label.textColor = #colorLiteral(red: 0.3709504014, green: 0.5388568935, blue: 1, alpha: 1)
        case 4:
            label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case 5:
            label.textColor = #colorLiteral(red: 0.307081886, green: 0.8122610856, blue: 0.6520350981, alpha: 1)
        case 6:
            label.textColor = #colorLiteral(red: 1, green: 0.8686066395, blue: 0.2203507263, alpha: 1)
        case 7:
            label.textColor = #colorLiteral(red: 1, green: 0.6066246015, blue: 0.1194213494, alpha: 1)
        case 8:
            label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case 9:
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default:
            break
        }
        label.font = UIFont(name: list[row],size:50)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.mojiColor.text = display[row]
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

extension UITextField {
    func addUnderline(width: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
