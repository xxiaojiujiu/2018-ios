//
//  MyViewController.swift
//  homework5_helloworld
//
//  Created by student on 2018/12/5.
//  Copyright © 2018年 ZXJ. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    
    //声明UILabel对象
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置根视图视图背景色
        self.view.backgroundColor = UIColor.white
        
        //创建UILabel对象
        label = UILabel(frame: CGRect(x:150, y:100,width:100,height:40))
        //设置label显示文字
        label.text = "Hello World "
         //将label加入到视图控制器中
        self.view.addSubview(label)
        
        //创建UIButton对象
        let btn = UIButton(frame: CGRect(x:150, y: 200, width: 100, height: 40))
        //设置正常状态下按钮的标题
        btn.setTitle("pick me", for: .normal)
        //设置按钮边框宽度
        btn.layer.borderWidth = 1
        //设置正常状态下标题的颜色
        btn.setTitleColor(UIColor.black, for: .normal)
        //设置高亮状态下（被点击且未释放鼠标）标题的颜色
        btn.setTitleColor(UIColor.red, for: .highlighted)
        btn.setTitleShadowColor(UIColor.yellow, for: .highlighted)
        //给按钮添加target-action
        btn.addTarget(self, action: #selector(clicked), for:.touchUpInside)
        self.view.addSubview(btn)
        
        //创建UIImageView对象
        let imageView = UIImageView(frame: CGRect(x: 10, y: 400, width: self.view.frame.width-20, height: (self.view.frame.width - 20) * 0.618))
        //获取图片资源路径
        let path = Bundle.main.path(forResource: "timg", ofType: "jpg")
        //以该路径创建图片
        let image = UIImage(contentsOfFile: path!)
        //将图片加入到imageView中
        imageView.image = image
        //将imageView加入到控制器中
        self.view.addSubview(imageView)
        
    }
    // 按钮点击事件，改变label显示的文字
    @objc func clicked(){
        if label.text == "Hello World "{
            label.text = "I am clicked"
            label.textColor = UIColor.red
        }else{
            label.text = "Hello World "
            label.textColor = UIColor.black
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
