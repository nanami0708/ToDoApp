//
//  EditViewController.swift
//  ToDoApp
//
//  Created by Nanami Mizuno on 2018/11/04.
//  Copyright © 2018 Nanami Mizuno. All rights reserved.
//

import UIKit

class EditViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var mojiColor: UITextField!
    @IBOutlet weak var memo: UITextView!
    
    var userDefaults:UserDefaults = UserDefaults.standard
    var titleArray = [String]()
    var dayArray:[String] = []
    var mojiColorArray:[String] = []
    var memoArray:[String] = []
    
    var cellNum: Int!
    
    var toolBar:UIToolbar!
    var datePicker: UIDatePicker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    let list = ["●", "●", "●", "●", "●", "●", "●", "●", "●", "●"]
    let display = ["赤", "ピンク", "紫", "青", "水色", "緑", "黄色", "オレンジ", "グレー", "黒"]
    
    override func viewDidLoad() {
        
        //texufieldの枠線
        textField.borderStyle = UITextField.BorderStyle.line
        //textfield カーソルの色
        textField.tintColor = UIColor(red: 1, green: 0.435, blue: 0.38, alpha: 1.0)
        dateText.tintColor = UIColor(red: 1, green: 0.435, blue: 0.38, alpha: 1.0)
        mojiColor.tintColor = UIColor(red: 1, green: 0.435, blue: 0.38, alpha: 1.0)
        memo.tintColor = UIColor(red: 1, green: 0.435, blue: 0.38, alpha: 1.0)
        
        super.viewDidLoad()

        textField.delegate = self
        //テキストフィールド下線
        mojiColor.addUnderline(width: 1.0, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        dateText.addUnderline(width: 1.0, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        //↓ここから期限設定
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateText.inputView = datePicker
        
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        //datepicker上のtoolbarのdoneボタン
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .done, target: self, action: #selector(dateDone))
        //キャンセルボタン dateCancelを呼び出す
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dateCancel))
        // ツールバーに登録
        toolBar.items = [toolBarBtn, cancelItem]
        dateText.inputAccessoryView = toolBar
        
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
        
        // Do any additional setup after loading the view.
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
        mojiColor.resignFirstResponder()
    }
    
    // カラーキャンセルボタンを押した時
    @objc func colorCancel() {
        self.mojiColor.endEditing(true)
        mojiColor.resignFirstResponder()
    }
    
    @IBAction func backButton(_ sender: Any) {
        let alertController = UIAlertController(title: "保存されていません。",message: "保存しますか?", preferredStyle: .alert)
        
        //        ②-1 OKボタンの実装
        let okAction = UIAlertAction(title: "保存", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            //        ②-2 OKがクリックされた時の処理
            //title現在の配列の状況を取り出す
            if self.userDefaults.object(forKey: "titleArray") != nil{
                self.titleArray = self.userDefaults.object(forKey: "titleArray") as! [String]
            }
            //titleその配列をアプリ内に保存する
            self.titleArray[self.cellNum] = self.textField.text!
            self.userDefaults.set(self.titleArray, forKey: "titleArray")
            //print(titleArray)
            
            
            //day現在の配列の状況を取り出す
            if self.userDefaults.object(forKey: "dayArray") != nil{
                self.dayArray = self.userDefaults.object(forKey: "dayArray") as! [String]
            }
            //dayその配列をアプリ内に保存する
            self.dayArray[self.cellNum] = self.dateText.text!
            self.userDefaults.set(self.dayArray, forKey: "dayArray")
            
            
            //moji現在の配列の状況を取り出す
            if self.userDefaults.object(forKey: "mojiColorArray") != nil{
                self.mojiColorArray = self.userDefaults.object(forKey: "mojiColorArray") as! [String]
            }
            //mojiその配列をアプリ内に保存する
            self.mojiColorArray[self.cellNum] = self.mojiColor.text!
            self.userDefaults.set(self.mojiColorArray, forKey: "mojiColorArray")
            
            
            
            //memo現在の配列の状況を取り出す
            if self.userDefaults.object(forKey: "memoArray") != nil{
                self.memoArray = self.userDefaults.object(forKey: "memoArray") as! [String]
            }
            //memoその配列をアプリ内に保存する
            self.memoArray[self.cellNum] = self.memo.text!
            self.userDefaults.set(self.memoArray, forKey: "memoArray")
            
            //画面を戻る
            self.dismiss(animated: true, completion: nil)

        }
        //        CANCELボタンの実装
        let cancelButton = UIAlertAction(title: "保存しない。", style: UIAlertAction.Style.cancel, handler: { action in
            //画面を戻る
            self.dismiss(animated: true, completion: nil)
            //self.navigationController?.popViewController(animated: true)
        })
        
        //        ③-1 ボタンに追加
        alertController.addAction(okAction)
        //        ③-2 CANCELボタンの追加
        alertController.addAction(cancelButton)
        
        //        ④ アラートの表示
        present(alertController,animated: true,completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //アプリ内にあるtitleArrayというキー値で保存された、配列titleArrayを取り出す
        if userDefaults.object(forKey: "titleArray") != nil{
            
            titleArray = userDefaults.object(forKey: "titleArray") as! [String]
            textField.text = String(titleArray[cellNum])
        }
        
        //アプリ内にあるdayArrayというキー値で保存された、配列dayArrayを取り出す
        if userDefaults.object(forKey: "dayArray") != nil{
            
           dayArray = userDefaults.object(forKey: "dayArray") as! [String]
           dateText.text = String(dayArray[cellNum])
        }
        
        //アプリ内にあるmojiColorArrayというキー値で保存された、配列mojiColorArrayを取り出す
        if userDefaults.object(forKey: "mojiColorArray") != nil{
            
            mojiColorArray = userDefaults.object(forKey: "mojiColorArray") as! [String]
            mojiColor.text = String(mojiColorArray[cellNum])
        }
        
        //アプリ内にあるmemoArrayというキー値で保存された、配列memoArrayを取り出す
        if userDefaults.object(forKey: "memoArray") != nil{
            
            memoArray = userDefaults.object(forKey: "memoArray") as! [String]
            memo.text = String(memoArray[cellNum])
        }
}
    
    //returnが押されたらキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    //キーボード以外をタッチでキーボードを閉じるtextView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func editSave(_ sender: Any) {
        
        //title現在の配列の状況を取り出す
        if userDefaults.object(forKey: "titleArray") != nil{
            titleArray = userDefaults.object(forKey: "titleArray") as! [String]
        }
        //titleその配列をアプリ内に保存する
        titleArray[cellNum] = textField.text!
        userDefaults.set(titleArray, forKey: "titleArray")
        //print(titleArray)
        
        
        //day現在の配列の状況を取り出す
        if userDefaults.object(forKey: "dayArray") != nil{
            dayArray = userDefaults.object(forKey: "dayArray") as! [String]
        }
        //dayその配列をアプリ内に保存する
        dayArray[cellNum] = dateText.text!
        userDefaults.set(dayArray, forKey: "dayArray")
        
        
        //moji現在の配列の状況を取り出す
        if userDefaults.object(forKey: "mojiColorArray") != nil{
            mojiColorArray = userDefaults.object(forKey: "mojiColorArray") as! [String]
        }
        //mojiその配列をアプリ内に保存する
        mojiColorArray[cellNum] = mojiColor.text!
        userDefaults.set(mojiColorArray, forKey: "mojiColorArray")
        
        
        
        //memo現在の配列の状況を取り出す
        if userDefaults.object(forKey: "memoArray") != nil{
            memoArray = userDefaults.object(forKey: "memoArray") as! [String]
        }
        //memoその配列をアプリ内に保存する
        memoArray[cellNum] = memo.text!
        userDefaults.set(memoArray, forKey: "memoArray")
        
        
        //アラートを出す
        let alert: UIAlertController = UIAlertController(title: "保存", message: "メモの保存が完了しました。", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
        title: "OK",
        style: .default,
        handler: { action in
            //画面を戻る
            self.dismiss(animated: true, completion: nil)
            //self.navigationController?.popViewController(animated: true)
            }
        )
        )
        
        present(alert, animated: true,completion: nil)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    //func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //    return list[row]
    //}
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

//extenßsion UITextField {
//    func addUnderline(width: CGFloat, color: UIColor) {
//        let border = CALayer()
//        border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
//        border.backgroundColor = color.cgColor
//        self.layer.addSublayer(border)
//    }
//}
