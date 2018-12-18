//
//  ViewController.swift
//  homework4_2
//
//  Created by student on 2018/11/21.
//  Copyright © 2018年 tan. All rights reserved.
//

import UIKit
//创建自定义的UIView
class MyView: UIView {
    override func draw(_ rect: CGRect){
        let path = UIBezierPath(ovalIn: rect)
        UIColor.black.setStroke()//绿色边界
        path.stroke()
        UIColor.yellow.setFill()//黄色填充
        path.fill()
    }//方法体结束
}//类定义结束

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //使用自定义的UIView创建一个椭圆
        let oval = MyView(frame: CGRect(x: 100, y:100,width: 150, height: 100))
        oval.backgroundColor = UIColor.clear
        self.view.addSubview(oval)
        
        //使用自定义的UIView创建一个圆
        let cirle = MyView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        cirle.backgroundColor = UIColor.clear
        self.view.addSubview(cirle)
    }
}

