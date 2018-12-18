import Foundation
import Glibc
//第3次上机作业  2016110338 王琴
//作业1（Date、String、文件、URL）
//1.显示当前准确的中文时间，包括北京、东京、纽约、伦敦，格式为（2016年9月28日星期三 上午10:25） 显示中文需要设置locale
//将指定的日期根据时区转换成相应的格式
func getDate(date: Date, zone: Int = 0) -> String {  //data:时间与日期  zone:时区 东区为正数，西区为负数
    let formatter = DateFormatter() //DateFormatter 格式化类
    formatter.dateFormat = "yyyy年MM月dd日EEEE aa KK:mm"//指定格式化的格式
    formatter.locale = Locale.current //设置当前位置,可以将对应的星期数和12小时制的上下午设置为中文
    if zone >= 0 {//东区
        formatter.timeZone = TimeZone(abbreviation: "UTC+\(zone):00")
    }else{//西区
        formatter.timeZone = TimeZone(abbreviation: "UTC\(zone):00")
    }
    let dateString = formatter.string(from: now)//将传入的日期格式转化为字符串
    return dateString  //返回指定格式的字符串
}
let now = Date()//获取当前时间日期
print("第3次上机作业----------------题目1：显示时间")
let beijing = getDate(date: now, zone: +8)//获取当前北京的时间
print("北京: \(beijing)")

let tokyo = getDate(date: now, zone: 9)//获取当前东京的时间
print("东京: \(tokyo)")

let newYork = getDate(date: now, zone: -5)//获取当前纽约的时间
print("纽约 : \(newYork)")

let london = getDate(date: now)//获取当前伦敦的时间
print("伦敦 : \(london)")

//2.处理字符串
let str = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS."
//返回字符串从第6个字符到第20个字符的子串；(空格也算字符且从0开始计数）
let index1 = str.index(str.startIndex, offsetBy: 6)
let index2 = str.index(str.startIndex, offsetBy: 20)
let newstr = str[index1...index2]
print("第3次上机作业----------------题目2：字符串处理")
print("提取字符串从第6个字符到第20个字符的子串为:")
print(newstr)
//删除其中所有的OS字符
print("删除其中所有的OS字符：")
let substr = str.replacingOccurrences(of: "OS", with: "")
print(substr)

//3.将1、2题的时间和字符串存入一个字典中，并存入沙盒中的Document某文件中
let dic = ["date": ["beijing":beijing, "tokyo":tokyo,"newYork":newYork, "london":london], "string":substr] as AnyObject
let defaultDoc = FileManager.default //获取默认工作路径
if var path = defaultDoc.urls(for: .documentDirectory, in: .userDomainMask).first?.path{ //获取工作路径下的Document文件夹
    path.append("/test.txt")//在文件夹路径下增加一个.txt 文件
    print(dic.write(toFile: path, atomically: true))//新建上面指定的文件，并将数据写入
}

//4.从网上下载一张照片并保存到本地沙盒的Document的某文件中；
let image = try Data(contentsOf: URL(string:"http://i.shangc.net/2018/0823/20180823111645544.jpg")!)//通过指定的url获取图片，并转换为二进制数据
if var url = defaultDoc.urls(for: .documentDirectory, in: .userDomainMask).first {
    url.appendPathComponent("image.png")
    try image.write(to: url)//将转换后的二进制数据存储为png图片
}

//5.从网上查找访问一个JSon接口文件，并采用JSONSerialization和字典对其进行简单解析
let url = URL(string:"http://www.weather.com.cn/data/sk/101110101.html")! //api的路径
let str1 = try String(contentsOf: url)
print(str1)//显示json数据内容
let data = try Data(contentsOf: url)//将json转换为二进制数据
let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)//序列化json

//解析json数据
if let dic = json as? [String: Any] {
    if let weather = dic["weatherinfo"] as? [String: Any] {
        let city = weather["city"]!
        let temp = weather["temp"]!
        let wd = weather["WD"]!
        let ws = weather["WS"]!
        print("城市：\(city), 温度：\(temp), 风向: \(wd), 风力：\(ws)")
    }
}

