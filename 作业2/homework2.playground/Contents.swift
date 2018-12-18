import Foundation
import Glibc
//第2次上机作业  2016110338 王琴
//-----------------------------作业1（闭包、扩展、泛型）
//（1）    给定一个Dictionary数组，Dictionary包含key值name和key值age，用map函数返回name字符串数组
//map函数常用于将数组中的每一个元素，通过指定的方法进行转换，然后返回一个结果数组。其参数是一个闭包，闭包内容就是你对每个函数的转换方法。map函数就像一个系统自定义的循环，每一次循环都会调用你的闭包来对每个元素进行转换，所以其最多只能使用到$0。
print("第2次上机作业------------作业1")
let dic = [["name":"wq", "age":20], ["name":"wyf", "age":20], ["name":"wx", "age":19]]
let str = dic.map( { $0["name"]! } )//返回字典数组中每个字典元素"name"对应的值
print("题目1")
print(str)

//（2）    给定一个String数组，用filter函数选出能被转成Int的字符串
//filter函数见名知意，就是对数组中的所有元素进行过滤，筛选出满足条件的元素，并返回结果数组。filter函数的参数也是一个闭包，它跟map函数相似，但filter函数却不改变元素的值，而map函数会改变元素的值。
let array1 = ["wq","wyf","dw","1234"]
let array2 = array1.filter( { Int($0) != nil } )
print("题目2")
print(array2)

//（3）    用reduce函数把String数组中元素连接成一个字符串，以逗号分隔
//reduce函数常用来整合一个数组，将数组中的元素按一定方法整合之后，返回一个整合的结果。reduce函数有两个参数，第一个参数为初始值，第二个参数为一个闭包，闭包的内容为你整合的方法。因其整合过程中最多2对相邻的两个元素进行操作，所以其语法最多使用到$1。
let array3 = ["wq","wyf","dw","1234","wq"]
var str1 = array3.reduce("", { $0 + "," + $1})//整合字符串数组
str1.remove(at: str1.startIndex)
print("题目3")
print(str1)

//（4）    用 reduce 方法一次求出整数数组的最大值、最小值、总数和
let array4 = [12, 20, 30, 18, 50,66]
let tuple = array4.reduce((max:array4[0], min:array4[0], sum:0),{ (max: max($0.max, $1), min: min($0.min, $1), $0.sum + $1) })
print("题目4")
print(tuple)

//（5）    新建一个函数数组，函数数组里面保存了不同函数类型的函数，要求从数组里找出参数为一个整数，返回值为一个整数的所有函数；
func f1(a: Int) -> Int{
    return a
}//(Int)->Int
func f2(a: String) -> Int{
    return Int(a)!
}//(String)->Int
func f3(a: Int, b: Int) -> Int{
    return a+b
}//(Int, Int)->Int
func f4(a: Int) -> Int{
    return a*2
}//(Int)->Int
func f5(a: String) -> String{
    return a
}//(String)->String
let funArr: [Any] = [f1, f2, f3, f4, f5]
//因为循环过程中需要设计到数组的下标，要将数组元素一一列举出来，所以需要调用数组的enumerated()方法。
print("题目5")
for (index,value) in funArr.enumerated(){
    if value is (Int) -> Int {
        print(index)//输出类型为(Int) -> Int的函数在数组中的下标
    }
}

//（6）扩展Int，增加sqrt方法，可以计算Int的Sqrt值并返回浮点数，进行验证；
extension Int{
    func sqrt() -> Double {
        return  Glibc.sqrt(Double(self))
    }
}
print("题目6")
print(4.sqrt())

//（7）    实现一个支持泛型的函数，该函数接受任意个变量并返回最大和最小值，分别传入整数值、浮点数值、字符串进行验证。
func findMaxAndMin<T: Comparable>(a:T...) -> (T, T){
    var max = a[0]
    var min = a[0]
    for item in a{
        if item > max{
            max = item
        }else if item < min{
            min = item
        }
    }
    return (max, min)
}
print("题目7")
print(findMaxAndMin(a:1, 2, 3))
print(findMaxAndMin(a:1.0, 2.2, 3.0))
print(findMaxAndMin(a:"ab", "cd", "gh"))

//-----------------------------作业2（枚举、类、派生、协议）(红色字体为新增内容)
print("第2次上机作业------------作业2")
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
//定义Department枚举
enum Department {
    case one, two, three
}
//协议SchoolProtocol
protocol SchoolProtocol {
    var department: Department { get set }
    func lendBook()
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
    //Person 增加run()方法
    func run(){
        print("person \(self.fullName) is running ")
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
class Teacher: Person, SchoolProtocol{
    var title: String //增加title属性
    var department: Department
    //构造方法
    init(title: String, firstName: String ,lastName: String, age: Int, gender: Gender, department: Department){
        self.title = title
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender) //调用父类的构造方法
    }
    init(title: String, department: Department){
        self.title = title
        self.department = department
        super.init(firstName: "", lastName: "", age: 0, gender: .unknow)
    }
    convenience required init(){ //重写父类的required方法
        self.init(title: "", department: Department.one)
    }
    //重写父类计算属性，可以使用print输出对象内容
    override var description: String {
        return "title: \(self.title), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender), department: \(self.department)"
    }
    //重载run方法
    override func run(){
        print("Teacher \(self.fullName) is running ")
    }
    //实现协议
    func lendBook(){
        print("Teacher \(self.fullName) lends a book")
    }
}//Teacher类定义结束
//Teacher类的实例化
var t1 = Teacher(title: "hello", department: .one)
print(t1)
var t2 = Teacher(title: "world", firstName: "王", lastName: "琴", age: 20, gender: .female, department: .two)
print(t2)

//定义学生类
class Student: Person,  SchoolProtocol{
    var stuNo: Int //增加新属性stuNo
    var department: Department
    //构造方法
    init(stuNo: Int, firstName: String ,lastName: String, age: Int, gender: Gender, department: Department){
        self.stuNo = stuNo
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender) //调用父类的构造方法
    }
    init(stuNo: Int, department: Department){
        self.stuNo = stuNo
        self.department = department
        super.init(firstName: "", lastName: "", age: 0, gender: Gender.unknow)
    }
    convenience required init(){ //重写父类的required方法
        self.init(stuNo: 0, department:.one)
    }
    //重写父类计算属性，可以使用print输出对象内容
    override var description: String {
        return "stuNo: \(self.stuNo), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender), Department: \(self.department)"
    }
    //重载父类run方法
    override func run() {
        print("Student \(self.fullName) is running")
    }
    //实现协议
    func lendBook(){
        print("Student \(self.fullName) lends a book")
    }
}//Student类定义结束
//Student类的实例化
var stu1 = Student(stuNo: 2016110338, department: .one)
print(stu1)
var stu2 = Student(stuNo: 2016110339, firstName: "王", lastName: "一凡", age: 20, gender: .female, department: .two)
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
    let temp = Teacher(title: "teacher", firstName: "张", lastName: "\(i)", age: 30, gender: .female, department: .two)
    array.append(temp)
}
//构造3个Student类对象
for i in 1...3 {
    let temp = Student(stuNo: 2016110330+i, firstName: "陈", lastName: "\(i)", age: 18, gender: .male, department: .three)
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
//穷举，调用run方法和lendBook方法
print("---------------------------------------------------------")
for item in array{
    item.run()
    if let teacher = item as? Teacher{
        teacher.lendBook()
    }else if let student = item as? Student{
        student.lendBook()
    }
}





















