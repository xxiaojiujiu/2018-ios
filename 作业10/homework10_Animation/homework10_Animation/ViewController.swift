//
//  ViewController.swift
//  homework10_Animation
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 wq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //声明两个属性用于视图的切换
    var firstView: UIView!
    var secondView: UIView!
    
    //声明两个属性用于动力学动画使用
    var animator: UIDynamicAnimator!
    var gravity = UIGravityBehavior() //UIGravityBehavior为重力的行为
    var collision = UICollisionBehavior()//UICollisionBehavior为碰撞的行为

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 调用几个方法
        animation()
        transition()
        dynamicAnimation()
//        let btn = UIButton(frame: CGRect(x: 100, y: 600, width: 600, height: 100))
//        btn.setTitle("点击随机产生小方块", for: .normal)
//        btn.setTitleColor(UIColor.black, for: .normal)
//        self.view.addSubview(btn)
    }
    //调用UIView的工厂方法
    func animation(){
        //创建了一个视图
        let view = UIView(frame: CGRect(x: 300, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.orange
        self.view.addSubview(view)
        //调用UIView的animate方法
        //第一个参数设置整个动画完成所需要的时间
        //第二个参数设置延迟多少秒之后将该动画加入线程队列中(所以真正开始执行动画的时间可能会有一些微妙的延迟)
        //第三个是一些动画的参数选项，参数很多，可以使用数组来搭配，这里选择了重复和自动倒转
        //第四个参数设置动画的内容，我们只需要设置在动画结束那一个时刻的视图的状态，中间的过渡Swift会帮你计算
        //最后一个参数是动画整体完成之后的一些设置
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            view.frame = CGRect(x: 0, y: 20, width: 10, height: 10)
            view.backgroundColor = UIColor.black
            view.transform = view.transform.rotated(by: CGFloat.pi)
        }, completion: nil)
    }//这个动画效果就是一个视图从一个位置移动到另一个位置，并在移动的过程中从橙色变为黄色，并且大小改变的同时旋转
    
    //初始化这两个UIView：firstView/secondView,并添加一个开始动画的按钮
    func transition(){
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 44))
        btn.setTitle("切换视图", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(changeView), for: .touchUpInside)
        self.view.addSubview(btn)
        
        firstView = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        firstView.backgroundColor = UIColor.purple
        self.view.addSubview(firstView)
        
        secondView = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        secondView.backgroundColor = UIColor.brown
        self.view.addSubview(secondView)
    }
    //实现动画的执行
    @objc func changeView() {
        UIView.transition(from: secondView, to: firstView, duration: 3, options: [.transitionCurlUp], completion: nil)
    }
    
    //随机产生一些视图
    func dynamicAnimation(){
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        //设置了UICollisionBehavior的translatesReferenceBoundsIntoBoundary，这个设置为真，就是将参考视图的边界作为碰撞的边界，在这个边界中的Item碰到边界时会有碰撞效果产生。
        collision.translatesReferenceBoundsIntoBoundary = true
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ (t) in
            let x = CGFloat(arc4random() % (UInt32(self.view.frame.width) - 50))
            let view = UIView(frame: CGRect(x: x, y: 20, width: 50, height: 50))
            view.backgroundColor = UIColor.red
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 10
            self.view.addSubview(view)
            
            self.gravity.addItem(view)
            self.collision.addItem(view)
        }
    }

}

