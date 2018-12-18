//
//  ViewController.swift
//  homework9.1_Gesture
//
//  Created by student on 2018/12/12.
//  Copyright © 2018年 wq. All rights reserved.
//

import UIKit
//先自定制一个视图 重写其draw(_:)方法
class Myview: UIView {
    //重写方法raw(_:)方法
    override func draw(_ rect: CGRect){
        let viewRect = UIBezierPath(rect: rect)
        //使用arc4random()方法来生成一个随机数，这个方法会返回一个UInt32的随机数，然后使用这个方法来生成rgb颜色，使用该颜色填充和描边矩形区域。
        let redColor = CGFloat(Float(arc4random() % 255) / 255)
        let greenColor = CGFloat(Float(arc4random() % 255) / 255)
        let blueColor = CGFloat(Float(arc4random() % 255) / 255)

        UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0).set()
        viewRect.stroke()
        viewRect.fill()
    }
    //重写初始化函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    //如果子类自己重写了初始化函数的话，也必须实现UIView的另一个初始化函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //我们需要在初始化函数中对自定义的视图类加一些功能，所以我们就把这些添加的功能放在一个setup()方法当中
    //在这个setup()方法中，我们可以设置视图的阴影并添加要求的手势
    func setup(){
        //设置矩形区域圆角
        self.layer.cornerRadius = 20
        //设置阴影
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 0.8
        //设置视图的内容模式为重绘
        self.contentMode = .redraw
        //pan移动
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        self.addGestureRecognizer(panGesture)
        //pinch缩放
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(gesture:)))
        self.addGestureRecognizer(pinchGesture)
        //rotation旋转
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotation(gesture:)))
        self.addGestureRecognizer(rotationGesture)
    }
    //在初始化手势时，需要传入一个手势对应的方法
    //pan移动
    @objc func pan(gesture: UIPanGestureRecognizer){
        self.center = gesture.location(in: superview)
    }
    //tap删除
    @objc func tap(gesture: UITapGestureRecognizer){
        self.removeFromSuperview()
    }
    //pinch缩放
    @objc func pinch(gesture: UIPinchGestureRecognizer){
        let scale = gesture.scale
        self.transform = self.transform.scaledBy(x: scale, y: scale)
        //在使用完手势获取的值之后，都需要将它初始化一次，否则的话手势的值会在之前的基础上增加
        gesture.scale = 1
    }
    //rotation旋转
    @objc func rotation(gesture: UIRotationGestureRecognizer){
        let rotation = gesture.rotation
        self.transform = self.transform.rotated(by: rotation)
        gesture.rotation = 0
    }
}//myView类定义结束

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //设置根视图的标题和背景颜色
        title = "this is root view"
        self.view.backgroundColor = UIColor.lightGray
        let addBtn = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addView))
        let moveBtn = UIBarButtonItem(title: "移动", style: .plain, target: self, action: #selector(moveViews))
        
        self.navigationItem.rightBarButtonItems = [addBtn, moveBtn]
        
        let clearBtn = UIBarButtonItem(title: "清空", style: .plain, target: self, action: #selector(clearView))
        self.navigationItem.leftBarButtonItem = clearBtn
        
    }
    
    //实现添加功能
    //当点击这个按钮后，我们要在随机位置生成随机大小的自定义视图
    @objc func addView(){
        //为了不是随机生成的自定义视图太大，设置其最大宽度
        let maxWidth: CGFloat = 150
        //我们需要随机生成一个点，这个点就是自定义视图的左上角的点
        let x = CGFloat(arc4random() % UInt32(self.view.bounds.width))
        let y = CGFloat(arc4random() % UInt32(self.view.bounds.height - 40)) + 40
        let point = CGPoint(x: x, y: y)
         //然后再随机生成大小值
        let width = CGFloat(arc4random() % UInt32(maxWidth))
        let height = CGFloat(arc4random() % UInt32(maxWidth))
        let size = CGSize(width: width, height: height)
        //用这个点和大小来初始化一个自定义视图，并添加到根视图上
        let view = Myview(frame: CGRect(origin: point, size: size))
        self.view.addSubview(view)
    }
    //实现清除功能
    @objc func clearView(){
        self.view.subviews.map{$0.removeFromSuperview()}
    }
    //实现移动功能
    @objc func moveViews(){
        self.view.subviews.map{(view) in
            let x = CGFloat(arc4random() % UInt32(self.view.bounds.width))
            let y = CGFloat(arc4random() % UInt32(self.view.bounds.height - 40)) + 40
            let point = CGPoint(x: x, y: y)
            UIView.animate(withDuration: 3, animations: {
                view.center = point
            })
        }
    }
    
}

