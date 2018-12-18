//
//  ViewController.swift
//  homework9.2_Alert
//
//  Created by student on 2018/12/12.
//  Copyright © 2018年 wq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //声明两个属性
    var v: UIView!       //用于改变背景颜色进行交互
    var label: UILabel!  //用于保存用户输入的用户名和密码
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //向控制器的根视图添加子视图并且在导航栏上添加两个按钮
        title = "Alert"
        self.view.backgroundColor = UIColor.white
        label = UILabel(frame: CGRect(x: 0, y: 300, width: self.view.bounds.width, height: 70))
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        self.view.addSubview(label)
        
        v = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        v.backgroundColor = UIColor.cyan
        self.view.addSubview(v)
        
        let rightBtn = UIBarButtonItem(title: "Alert", style: .plain, target: self, action: #selector(alertLogin))
        self.navigationItem.rightBarButtonItem = rightBtn
        
        let leftBtn = UIBarButtonItem(title: "Action", style: .plain, target: self, action: #selector(actionSheet))
        self.navigationItem.leftBarButtonItem = leftBtn
    }
    //实现alert(rightBtn)
    //这里的交互使用弹出一个提示框，让用户输入用户名和密码，然后在界面上显示输入的用户名和密码。
    @objc func alertLogin(){
        let alert = UIAlertController(title: " 填写信息", message: nil, preferredStyle: .alert)
        alert.addTextField{ (tf) in
            tf.placeholder = "用户名"
        }
        alert.addTextField{ (tf) in
            tf.placeholder = "密码"
        }
        let OKBtn = UIAlertAction(title: "确定", style: .default) { _ in
            let username = alert.textFields![0].text ?? ""
            let password = alert.textFields![1].text ?? ""
            let string = "用户名：\(username)\n密码：\(password)"
            self.label.text = string
        }
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(OKBtn)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
    }//alertLogin()实现结束
    
    //实现actionsheet（leftBtn）
    //使用其弹出几个选择颜色的按钮，用户点击一个按钮将视图的背景颜色更改为相应的颜色。
    @objc func actionSheet(){
        let action = UIAlertController(title: "选择背景颜色", message: nil, preferredStyle: .actionSheet)
        let redBtn = UIAlertAction(title: "红色", style: .default){ (_) in
            self.v.backgroundColor = UIColor.red
        }
        let greenBtn = UIAlertAction(title: "绿色", style: .default) { (_) in
            self.v.backgroundColor = UIColor.green
        }
        let blueBtn = UIAlertAction(title: "蓝色", style: .default) { (_) in
            self.v.backgroundColor = UIColor.blue
        }
        let yellowBtn = UIAlertAction(title: "黄色", style: .default) { (_) in
            self.v.backgroundColor = UIColor.yellow
        }
        let blackBtn = UIAlertAction(title: "黑色", style: .default) { (_) in
            self.v.backgroundColor = UIColor.black
        }
        let grayBtn = UIAlertAction(title: "灰色", style: .default) { (_) in
            self.v.backgroundColor = UIColor.gray
        }
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        action.addAction(redBtn)
        action.addAction(greenBtn)
        action.addAction(blueBtn)
        action.addAction(yellowBtn)
        action.addAction(blackBtn)
        action.addAction(grayBtn)
        action.addAction(cancelBtn)
        
        self.present(action, animated: true, completion: nil)
    }
    
}

