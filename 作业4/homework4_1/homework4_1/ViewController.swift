//
//  ViewController.swift
//  homework4_1
//
//  Created by student on 2018/11/21.
//  Copyright © 2018年 tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        //super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let manager = FileManager.default
        let document = manager.urls(for: .documentDirectory, in: .userDomainMask).first?.path
        let file = document?.appending("/image")//图片文件夹
        
        //print(document!)//输出Document路径，方便查看
        if manager.fileExists(atPath: file!){//若该文件夹存在
            let image = file?.appending("/bd.png")//图片文件
            if manager.fileExists(atPath: image!){//若该文件存在，则显示到界面上
                do{
                    let data = try Data(contentsOf: URL(fileURLWithPath: image!))
                    let img = UIImage(data: data)
                    let imageView = UIImageView(image: img)
                    imageView.frame = CGRect(x: 0, y: 100, width: 400, height: 300)
                    self.view.addSubview(imageView)
                }catch{
                    print(error)
                }
            }else{//若图片不存在，则从网络上下载一个图片并保存为图片文件
                let url = URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542779611867&di=0ef4e6e953da3a29a39aff5afb615078&imgtype=0&src=http%3A%2F%2Fimages.newsing.com%2Fuploadfile%2F2017%2F0704%2Fk5oyk2er5k0.jpg")
                do{
                    let data = try Data(contentsOf: url!)
                    try data.write(to: URL(fileURLWithPath: image!),options: .atomicWrite)
                    print("文件不存在，已成功创建文件")
                }catch{
                    print(error)
                }
            }
        }else{//若该文件夹不存在 则创建文件夹
            do{
                try manager.createDirectory(atPath: file!, withIntermediateDirectories: true, attributes: nil)
                  print("文件夹不存在，已成功创建文件夹")
            }catch{
                print(error)
            }
        }
    }//函数体结束


}//类定义结束

