//
//  ViewController.swift
//  homework4_3
//
//  Created by student on 2018/11/24.
//  Copyright © 2018年 pxy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var label: UILabel!
    var btn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        label.text = "hello world"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.red
        self.view.addSubview(label)
        
        btn = UIButton(frame: CGRect(x: 100, y: 400, width: 50, height: 40))
        btn.setTitle("Click", for: .normal)
        btn.backgroundColor = UIColor.yellow
        btn.setTitleColor(UIColor.black, for: .highlighted)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(cilcked), for: .touchUpInside)
    }
    @IBAction func cilcked() {
        if label.text! == "Clicked"{
            label.text = "hello world"
            btn.setTitle("Click", for: .normal)
        }else{
            label.text = "Clicked"
            btn.setTitle("hello", for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

