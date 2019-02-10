//
//  kabegamiViewController.swift
//  ToDoApp
//
//  Created by Nanami Mizuno on 2019/01/13.
//  Copyright © 2019 Nanami Mizuno. All rights reserved.
//

import UIKit

class kabegamiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var screenShotButton: UIButton!
    @IBOutlet var timelabel: UILabel!
    @IBOutlet weak var selectBackground: UIButton!
    @IBOutlet var haikeiImageView : UIImageView!
    
    var resultArray: [String] = []
    var mojiColorArray:[String] = []
    
    let userDefaults: UserDefaults = UserDefaults.standard
    
    var cellNum: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        // ->背景色をグレーに変更する
        self.view.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //アプリ内にあるtitleArrayというキー値で保存された、配列titleArrayを取り出す
        if userDefaults.object(forKey: "titleArray") != nil{
            
            resultArray = userDefaults.object(forKey: "titleArray") as! [String]
        }
        
        if userDefaults.object(forKey: "mojiColorArray") != nil{
            
            mojiColorArray = userDefaults.object(forKey: "mojiColorArray") as! [String]
        }
        
        
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //動的に処理する
        return resultArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cell関連
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let label1 = cell.viewWithTag(2) as! UILabel
        
        label1.text = resultArray[indexPath.row]
        switch mojiColorArray[indexPath.row] {
        case "赤":
            label1.textColor = #colorLiteral(red: 0.9294117647, green: 0.3294117647, blue: 0.3568627451, alpha: 1)
        case "ピンク":
            label1.textColor = #colorLiteral(red: 1, green: 0.6549019608, blue: 0.7882352941, alpha: 1)
        case "紫":
            label1.textColor = #colorLiteral(red: 0.6731770833, green: 0.5671946674, blue: 0.9686274529, alpha: 1)
        case "青":
            label1.textColor = #colorLiteral(red: 0.3709504014, green: 0.5388568935, blue: 1, alpha: 1)
        case "水色":
            label1.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case "緑":
            label1.textColor = #colorLiteral(red: 0.307081886, green: 0.8122610856, blue: 0.6520350981, alpha: 1)
        case "黄色":
            label1.textColor = #colorLiteral(red: 1, green: 0.8686066395, blue: 0.2203507263, alpha: 1)
        case "オレンジ":
            label1.textColor = #colorLiteral(red: 1, green: 0.6066246015, blue: 0.1194213494, alpha: 1)
        case "グレー":
            label1.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case "黒":
            label1.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default:
            break
        }
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2788250191)
        
        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            //配列のセルのスライドされた番号の削除
            
            resultArray.remove(at: indexPath.row)
            
            //その配列を再びアプリ内保存
            
            userDefaults.set(resultArray, forKey: "titleArray")
            
            //tableviewを更新
            tableView.reloadData()
        }
    }
    @IBAction func screenShotButton(_ sender: Any) {
        backButton.isHidden = true
        screenShotButton.isHidden = true
        timelabel.isHidden = true
        //キャプチャ取得 変数screenshotにUIImageが保存される
        let layer = UIApplication.shared.keyWindow?.layer

        //let scale = tableView.bounds.minX
        let size: CGSize = CGSize(width: self.view.frame.size.width/*tableView.frame.size.width*/, height: self.view.frame.size.height/*tableView.frame.size.height*/)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)  // スクリーンショットの取得開始

        let context = UIGraphicsGetCurrentContext()!
        
        let affinMove = CGAffineTransform(translationX: 0, y: 0/*-tableView.frame.origin.y*/)
        context.concatenate(affinMove)
        layer!.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()  // 描画が行われたスクリーンショットの取得
        UIGraphicsEndImageContext()  // スクリーンショットの取得終了

        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)  // アルバムに保存
        backButton.isHidden = false
        screenShotButton.isHidden = false
        timelabel.isHidden = false
    }
    @IBAction func selectBackground(_ sender: Any) {
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        
        haikeiImageView.image = image
        
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //cell の高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}
