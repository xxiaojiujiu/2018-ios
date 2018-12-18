//
//  ViewController.swift
//  homework9.3_ScrollView
//
//  Created by student on 2018/12/12.
//  Copyright © 2018年 wq. All rights reserved.
//

import UIKit
//要想实现轮播和缩放效果，需要先让ViewController遵循UIScrollViewDelegate协议。
class ViewController: UIViewController, UIScrollViewDelegate{
    //声明三个属性
    //轮播 第一个scroll与pagecontroll配合使用
    var scroll1: UIScrollView!
    var page: UIPageControl!
    //缩放
    var scroll2: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        let width = self.view.bounds.width - 20
        let height = width * 0.56
        
        //配置scroll1
        scroll1 = UIScrollView(frame: CGRect(x: 10, y:100, width: width, height: height))
        //按一页一页的方式滚动
        scroll1.isPagingEnabled = true
        //隐藏水平滚动条
        scroll1.showsHorizontalScrollIndicator = false
        //设置内容大小
        //使用scrollview必须设置其内容的大小，否则内容大小与scrollview大小一致，这样就不能实现轮播效果了。
        scroll1.contentSize = CGSize(width: width*5, height: height)
        //设置代理
        scroll1.delegate = self
        self.view.addSubview(scroll1)
        
        //配置pagecontroll
        page = UIPageControl(frame: CGRect(x: 10, y: 100+height, width: width, height: 30))
        //总页数
        page.numberOfPages = 5
        //当前页
        page.currentPage = 0
        //指示器未选中时颜色
        page.pageIndicatorTintColor = UIColor.brown
        //指示器选中时颜色
        page.currentPageIndicatorTintColor = UIColor.red
        //添加事件
        page.addTarget(self, action: #selector(pageChanged(page:)), for: .touchUpInside)
        self.view.addSubview(page)
        
        //向scroll1中添加图片视图
        for i in 1...5 {
            let image = UIImage(named: "\(i)")
            let imageView = UIImageView(frame: CGRect(x: width*CGFloat(i-1), y: 0, width: width, height: height))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            scroll1.addSubview(imageView)
        }
        
        //实现缩放
        scroll2 = UIScrollView(frame: CGRect(x: 10, y: 200+height, width: width, height: height))
        scroll2.backgroundColor = UIColor.yellow
        scroll2.contentSize = CGSize(width: width, height: height)
        //最大缩放比例
        scroll2.maximumZoomScale = 10
        //最小缩放比例
        scroll2.minimumZoomScale = 0.1
        scroll2.delegate = self
        self.view.addSubview(scroll2)
        let image = UIImage(named: "6")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        scroll2.addSubview(imageView)
        
    }
    //实现scrollview里面的图片滚动后，将pagecontroll的当前页做相应的更改 需要UIScrollViewDelegate中的方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / (self.view.bounds.width - 20))
        page.currentPage = currentPage
    }
    //实现pagecontroll绑定的方法
    @objc func pageChanged(page: UIPageControl){
        let rect = CGRect(x: scroll1.bounds.width*CGFloat(page.currentPage), y: 0, width: scroll1.bounds.width, height: scroll1.bounds.height)
        scroll1.scrollRectToVisible(rect, animated: true)
    }
    
    //实现UIScrollViewDelegate中的方法，返回需要缩放的视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scroll2.subviews.first
    }


}

