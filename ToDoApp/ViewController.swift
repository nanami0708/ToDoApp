//
//  ViewController.swift
//  ToDoApp
//
//  Created by Nanami Mizuno on 2018/10/21.
//  Copyright © 2018年 Nanami Mizuno. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var resultArray = [String]()
    
    let userDefaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        // ->背景色をグレーに変更する
        self.view.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //アプリ内にあるarrayというキー値で保存された、配列arrayを取り出す
        if userDefaults.object(forKey: "array") != nil{
            
            resultArray = userDefaults.object(forKey: "array") as! [String]
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            //配列のセルのスライドされた番号の削除
            
            resultArray.remove(at: indexPath.row)
            
            //その配列を再びアプリ内保存
            
            userDefaults.set(resultArray, forKey: "array")
            
            //tableviewを更新
            tableView.reloadData()
        }
    }
    
    //cell の高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }

}

