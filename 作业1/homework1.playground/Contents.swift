//第一次上机作业 王琴 2016110338
import Foundation
//import Glibc

/*第一次上机作业--------作业1：闭包*/
func findPrimNumber() -> [Int] {//定义函数 返回一个整型数组
    var num = [2,3]     //定义可变数组用于存储找到的质数
    var flag = true
    var sqr = 0
    for x in 4...10000 {
        sqr = Int(sqrt(Double(x)))
        for y in 2...sqr {
            if x % y == 0 {
                flag = false //该数不是质数 标志变量置为false
                break
            }
        }//内层循环结束
        if flag{            //若该数是质数，则将其存入数组中
            num.append(x)
        }
        flag = true
    }//外层循环结束
    // print(num)
    return num
}//函数定义结束 返回存储1-10000中所有质数的数组
var numbers = findPrimNumber()

//降序排序
//方法一:将函数作为参数传递进排序函数
func descending(x: Int, y: Int) -> Bool {
    return x > y
}
numbers.sort(by: descending) //调用
print(numbers)

//方法二:指定参数名和类型的闭包 标准闭包语法
numbers.sort {  (x: Int, y: Int) -> Bool in
    return x > y
}

//方法三:基于类型推导简写方法二
numbers.sort {  (x, y) -> Bool in
    return x > y
}
//方法四:利用推断省略返回值类型 简写方法三
numbers.sort {  (x, y) in
    return x > y
}

//方法五:利用推断省略参数和返回值
numbers.sort(by: { return $0 > $1 })

//方法六:省略return的闭包,当闭包中只有一句return语句时，可以省略return
numbers.sort(by: { $0 > $1 })

//方法七:其传入操作符函数的闭包，在Swift中，操作符也定义为函数，所以操作符也可以作闭包使用
numbers.sort(by: > )

//升序排序
numbers.sort()
print(numbers)

/*第一次上机作业--------作业2：枚举 类 派生*/
//定义性别的枚举变量
enum Gender: Int {
    case male
    case female
    case unknow //用于后面便利初始器对值的初始化
    //重载>操作符
    static func >(a: Gender, b: Gender) -> Bool {
        return a.rawValue < b.rawValue
    }
}
//定义Person类并实例化
class Person: CustomStringConvertible {
    //定义存储属性
    var firstName: String
    var lastName: String
    var age: Int
    var gender: Gender
    //定义计算属性
    var fullName: String { //全名
        get {
            return firstName + lastName
        }
    }
    //定义初始化方法
    init(firstName: String ,lastName: String, age: Int, gender: Gender){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    //定义便利初始化器
    convenience init(firstName: String, age: Int, gender: Gender){
        self.init(firstName: firstName, lastName: "", age: age, gender: gender)
    }
    convenience init(firstName: String){
        self.init(firstName: firstName, age: 0, gender: Gender.unknow)
    }
    required convenience init(){ //当子类含有异于父类的初始化方法时，子类必须实现父类的required初始化方法
        self.init(firstName: "")
    }
    //重载==
    static func ==(a: Person, b: Person) -> Bool {
        return a.fullName==b.fullName && a.age==b.age && a.gender==b.gender
    }
    //重载!=
    static func !=(a: Person, b: Person) -> Bool {
        return !(a == b)
    }
    //实现CustomStringConvertible协议中的计算属性，可以使用print直接输出对象内容
    var description: String {
        return "fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
}//Person类定义结束

//实例化Person类
var p1 = Person(firstName: "王")
var p2 = Person(firstName: "王", age: 20, gender: .male)
print(p1)
print(p2)
print(p1 == p2)
print(p1 != p2)

//定义教师类
class Teacher: Person{
    var title: String //增加title属性
    //构造方法
    init(title: String, firstName: String ,lastName: String, age: Int, gender: Gender){
        self.title = title
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender) //调用父类的构造方法
    }
    init(title: String){
        self.title = title
        super.init(firstName: "", lastName: "", age: 0, gender: .unknow)
    }
    convenience required init(){ //重写父类的required方法
        self.init(title: "")
    }
    //重写父类计算属性，可以使用print输出对象内容
    override var description: String {
        return "title: \(self.title), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
}//Teacher类定义结束
//Teacher类的实例化
var t1 = Teacher(title: "hello")
print(t1)
var t2 = Teacher(title: "world", firstName: "王", lastName: "琴", age: 20, gender: .female)
print(t2)

//定义学生类
class Student: Person{
    var stuNo: Int //增加新属性stuNo
    //构造方法
    init(stuNo: Int, firstName: String ,lastName: String, age: Int, gender: Gender){
        self.stuNo = stuNo
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender) //调用父类的构造方法
    }
    init(stuNo: Int){
        self.stuNo = stuNo
        super.init(firstName: "", lastName: "", age: 0, gender: .unknow)
    }
    convenience required init(){ //重写父类的required方法
        self.init(stuNo: 0)
    }
    //重写父类计算属性，可以使用print输出对象内容
    override var description: String {
        return "stuNo: \(self.stuNo), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
}//Student类定义结束
//Student类的实例化
var stu1 = Student(stuNo: 2016110338)
print(stu1)
var stu2 = Student(stuNo: 2016110339, firstName: "王", lastName: "一凡", age: 20, gender: .female)
print(stu2)

//初始化一个空的Person数组
var array = [Person]()
//构造5个Person类对象
for i in 1...5 {
    let temp = Person(firstName: "王", lastName: "\(i)", age: 20, gender: .male)
    array.append(temp)
}
//构造4个Teacher类对象
for i in 1...4 {
    let temp = Teacher(title: "teacher", firstName: "张", lastName: "\(i)", age: 30, gender: .female)
    array.append(temp)
}
//构造3个Student类对象
for i in 1...3 {
    let temp = Student(stuNo: 2016110330+i, firstName: "陈", lastName: "\(i)", age: 18, gender: .male)
    array.append(temp)
}
//输出创建的对象的信息
for i in 0...11 {
    print(array[i])
}
//定义字典用于统计每个类的对象个数
var dict = ["Person": 0, "Teacher": 0, "Student": 0]
for item in array {
    if item is Teacher {
        dict["Teacher"]! += 1
    }else if item is Student {
        dict["Student"]! += 1
    }else{
        dict["Person"]! += 1
    }
}

//输出字典值
for (key, value) in dict {
    print ("\(key) has \(value) items")
}
//数组操作
//原始数组
print("------------------------原始数组---------------------")
for item in array {
    print(item)
}
//根据age从小到大排序
print("-------------------根据age从小到大排序----------------")
array.sort{ return $0.age < $1.age }
for item in array {
    print(item)
}
//根据全名从前往后排序
print("-------------------根据全名从前往后排序----------------")
array.sort{ return $0.fullName < $1.fullName }
for item in array {
    print(item)
}
//根据gender和age从大往小排序
print("--------------根据gender和age从大往小排序----------------")
array.sort{ return ($0.gender > $1.gender) && ($0.age > $1.age) }
for item in array {
    print(item)
}
