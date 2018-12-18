//
//  ViewController.swift
//  homework11_MultiMVC
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 wq. All rights reserved.
//

import UIKit
//声明一个协议 实现反向传参
protocol StudentProtocol {
    func change(name: String, num: String)
}

class FirstViewController: UIViewController , StudentProtocol{
    var name = ""
    var num = ""
    
    //实现协议的方法
    func change(name: String, num: String) {
        self.name = name
        self.num = num
    }
    
    
    //正向传参
    @IBOutlet weak var tfNum: UITextField!
    @IBOutlet weak var tfName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //构造函数只会被调用一次 故要在一下方法中实现赋值
    override func viewWillAppear(_ animated: Bool) {
        tfNum.text = num
        tfName.text = name
    }
    //两种不同的展示方法
    //1.push-pop
    @IBAction func showSecondVC(_ sender: Any) {
        num = tfNum.text!
        name = tfName.text!
        let secVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        //正向传参
        secVC.num = tfNum.text!
        secVC.name = tfName.text!
        //反向传参
        secVC.delegate = self
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    //2.present-dismiss
    @IBAction func showThirdVC(_ sender: Any) {
        let thirdVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThirdVC")
        present(thirdVC, animated: true, completion: nil)
    }
}

