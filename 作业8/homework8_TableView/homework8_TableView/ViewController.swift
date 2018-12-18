//
//  ViewController.swift
//  homework8_TableView
//
//  Created by student on 2018/12/6.
//  Copyright © 2018年 2016110338. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //学生数组
    var students = [Student]()
    //教师数组
    var teachers = [Teacher]()
    //定义表头数组
    var tableTitle = ["Teacher", "Student"]
    //定义一个表视图
    var table: UITableView!
    //右边按钮
    var rightItem: UIBarButtonItem!
    //弹出框
    var alert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //生成3个Teacher对象
        for i in 1...3 {
            let temp = Teacher(title: "老师", firstName: "王", lastName: "\(i)", age: 30, gender: .female, department: .one)
            teachers.append(temp)
        }
        //生成4个Student对象
        for i in 1..<5 {
            let temp = Student(stuNo: 2016110338 + i, firstName: "张", lastName: "\(i)", age: 19, gender: .male, department: .two)
            students.append(temp)
        }
        //按全名排序
        teachers.sort { return $0.fullName < $1.fullName }
        students.sort { return $0.fullName < $1.fullName }
        
        //创建表视图，并设置代理和数据源
        table = UITableView(frame: self.view.bounds)
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
        rightItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(edit))
        self.navigationItem.rightBarButtonItem = rightItem
        
        let leftItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addStudent))
        self.navigationItem.leftBarButtonItem = leftItem
        
    }//viewDidLoad()方法结束
    // 编辑表视图
    @objc func edit() {
        if table.isEditing {
            rightItem.title = "编辑"
            table.isEditing = false
        } else {
            rightItem.title = "完成"
            table.isEditing = true
        }
    }
    // 添加学生提示框
    @objc func addStudent() {
        alert = UIAlertController(title: "hh", message: "ss", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "stuNum"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "firstName"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "lastName"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "gender"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "age"
        }
        let OKBtn = UIAlertAction(title: "ok", style: .default) { (alert) in
            self.add()
        }
        let cancelBtn = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(OKBtn)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
    }
    // 添加学生
    func add() {
        let no = Int(alert.textFields![0].text!)
        let firstName = alert.textFields![1].text!
        let lastName = alert.textFields![2].text!
        let gender: Gender
        switch alert.textFields![3].text! {
        case "男":
            gender = .male
        case "女":
            gender = .female
        default:
            gender = .unknow
        }
        let age = Int(alert.textFields![4].text!)
        let student = Student(stuNo: no!, firstName: firstName, lastName: lastName, age: age!, gender: gender)
        students.append(student)
        table.reloadData()
    }
    //两个协议必须实现的方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return teachers.count
        } else {
            return students.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = tableTitle[indexPath.section]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            let style: UITableViewCell.CellStyle = (identifier == "Teacher") ? .subtitle : .default
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
            cell?.accessoryType = .disclosureIndicator
        }
        switch identifier {
        case "Teacher":
            cell?.textLabel?.text = teachers[indexPath.row].fullName
            cell?.detailTextLabel?.text = teachers[indexPath.row].title
        case "Student":
            cell?.textLabel?.text = students[indexPath.row].fullName
        default:
            break
        }
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableTitle.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableTitle[section]
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    //删除数据
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if indexPath.section == 0 {
                teachers.remove(at: indexPath.row)
            } else {
                students.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section != destinationIndexPath.section {
            tableView.reloadData()
        } else {
            if sourceIndexPath.section == 0 {
                teachers.insert(teachers.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            } else {
                students.insert(students.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            }
        }
    }
   
   
}//类结束

