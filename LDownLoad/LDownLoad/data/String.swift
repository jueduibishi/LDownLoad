//
//  String.swift
//  BilibiliLive
//
//  Created by whw on 2022/10/31.
//

import Foundation
import UIKit
import CryptoKit
import CommonCrypto

extension String {
    
    /// 数字自加 var a:String="1" a += 2 ----> a=3
    /// - Parameters:
    ///   - lhs: self
    ///   - rhs: int
    static func += (lhs: inout String, rhs: Int) {
        if let number = Int(lhs) {
            lhs = String(number + rhs)
        }
    }
    
    
    /// 数字自减 var a:String="3" a -= 1 ----> a=2
    /// - Parameters:
    ///   - lhs: self
    ///   - rhs: int
    static func -= (lhs: inout String, rhs: Int) {
        if let number = Int(lhs) {
            lhs = String(number - rhs)
        }
    }
    
    /// 转utf8编码的data
    /// - Returns: data
    func toUTF8Data()->Data?{
        self.data(using: .utf8)
    }
    
    /// url编码
    /// - Returns: new string
    func urlEncode()->String{
        self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    /// 从url提取参数
    /// - Returns: dic "action?a=1&b=2"  ---->["b": "2", "a": "1"]
    func urlParamToDic() -> [String : Any] {
        var dic=[String : Any]()
        let urlCom=NSURLComponents.init(string: self.removingPercentEncoding ?? self)
        let array:[URLQueryItem] = urlCom?.queryItems ?? [URLQueryItem.init(name: "", value: "")]
        _=array.map { item in
            dic[item.name]=item.value
        }
        return dic
    }
    
    /// 从url提取参数，返回String
    /// - Returns: dic "action?a=1&b=2"  ---->["b": "2", "a": "1"]
    func urlStringParamToDic() -> [String : String] {
        var dic=[String : String]()
        let urlCom=NSURLComponents.init(string: self.removingPercentEncoding ?? self)
        let array:[URLQueryItem] = urlCom?.queryItems ?? [URLQueryItem.init(name: "", value: "")]
        _=array.map { item in
            dic[item.name]=item.value
        }
        return dic
    }
    
    
    /// 获取数字字母的随机数
    /// - Parameter count: n位
    /// - Returns: string
    static func randomString(_ count:Int)->String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<count).map{ _ in letters.randomElement()! })
    }
    
    /// 判断字符串是否是数字
    /// - Returns: Bool
    func isNumber() -> Bool{
        let scanner = Scanner(string: self)
        var number:Int = 0
        if scanner.scanInt(&number) == true {
            //扫描结束后，看下跟原来是不是一样，遇到非数字会终止
            if number.string() == self{
                return true
            }
        }
        return false
    }
    
    /// string转时间
    /// - Parameters:
    ///   - form: yyyy-MM-dd HH:mm:ss
    /// - Returns: date
    func toDate(_ form:String)->Date?{
        let formater = DateFormatter()
        formater.dateFormat = form
        return formater.date(from: self)
    }
    
    
    /// 保留1位小数  不显示结尾.0
    /// - Returns: number
    func numberString() -> String {
        if self.count>0{
            if let num = Float(self){
                if num < 10000 {//万以内
                    return self
                }
                else if num < 100000000{//亿以内
                    var str = String(format: "%.1f", num/1000.0/10.0)
                    //去掉0
                    str = str.deleteZero()
                    return str+"万"
                }
                else{//亿
                    var str = String(format: "%.1f", num/10000000.0/10.0)
                    //去掉0
                    str = str.deleteZero()
                    return str+"亿"
                }
            }
        }
        return "0"
    }
    
    
    /// 去掉尾部的.0
    /// - Returns: string
    func deleteZero()->String{
        if self.hasSuffix(".0") {
            let end = self.index(self.endIndex, offsetBy: -2)
            return String(self[..<end])
        }
        return self
    }
    
    /// 限制显示字数，尾部用...代替 123456
    /// - Parameters:
    ///   - num: num 3
    /// - Returns: 123...
    func limitNumber(_ num:Int)->String{
        if self.count > num{
            let end = self.index(self.startIndex, offsetBy: num)
            return String(self[..<end])+"..."
        }
        return self
    }
    
    /// 多行文本，根据字体和固定宽度，返回每行显示的文字数组
    /// - Parameters:
    ///   - font: 字体
    ///   - width: 宽度
    /// - Returns: [每行文字]
    func linesArrayWithFont(_ font:UIFont,
                            width:CGFloat)->[String]{
        let myFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: self)
        if let range = self.range(of: self) {
            attStr.addAttribute(NSAttributedString.Key.font, value: myFont, range:NSRange(range, in: self))
        }
        let frameSetter = CTFramesetterCreateWithAttributedString(attStr)
        let path = CGPath(rect: CGRectMake(0, 0, width, 10000), transform: nil)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        var linesArray:[String] = []
        if let lines = CTFrameGetLines(frame) as? [CTLine]{
            for line in lines {
                let lineRange = CTLineGetStringRange(line)
                let start = self.index(self.startIndex, offsetBy: lineRange.location)
                let end = self.index(self.startIndex, offsetBy: lineRange.location+lineRange.length)
                linesArray.append(String(self[start..<end]))
            }
        }
        
        return linesArray
    }
    
    
    /// 根据字体、定高，计算文本宽度
    /// - Parameters:
    ///   - font: UIFont?
    ///   - height: 固定高度
    /// - Returns: CGFloat
    func width(_ font:UIFont? = nil,
               height:CGFloat) -> CGFloat {
        self.boundingRect(with: CGSize(width: CGFLOAT_MAX, height: height), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: font == nil ? nil : [NSAttributedString.Key.font:font as Any], context: nil).size.width
    }
    
    
    /// 根据字体、定宽、缩进、行间距计算文本高度
    /// - Parameters:
    ///   - font: UIFont?
    ///   - width: 固定宽度
    ///   - indent: 首行缩进
    ///   - lineSpace: 行间距
    /// - Returns: CGFloat
    func height(_ font:UIFont? = nil,
                width:CGFloat,
                indent:CGFloat? = nil,
                lineSpace:CGFloat? = nil) -> CGFloat {
        let style = NSMutableParagraphStyle()
        if indent != nil {
            style.firstLineHeadIndent = indent!
        }
        if lineSpace != nil {
            style.lineSpacing = lineSpace!
        }
        let dic = [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle:style]
        return self.boundingRect(with: CGSize(width: width, height: CGFLOAT_MAX), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: font == nil ? nil : dic as [NSAttributedString.Key : Any], context: nil).size.height
    }
    
    /// SHA256加密
    /// - Returns: string
    func sha256() -> String {
        if #available(iOS 13, *) {
            guard let data = self.data(using: .utf8) else { return "" }
                let hash = SHA256.hash(data: data)
                return hash.compactMap { String(format: "%02x", $0) }.joined()
        } else {
            guard let data = self.data(using: .utf8) else { return "" }
                var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
                data.withUnsafeBytes { bytes in
                    _ = CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &digest)
                }
                return digest.map { String(format: "%02hhx", $0) }.joined()
        }
    }
    //MARK: emoji
    /// 是否为单个emoji表情
    var isSingleEmoji: Bool {
        return count == 1 && containsEmoji
    }

    /// 包含emoji表情
    var containsEmoji: Bool {
        return contains{ $0.isEmoji}
    }

    /// 只包含emoji表情
    var containsOnlyEmoji: Bool {
        return !isEmpty && !contains{!$0.isEmoji}
    }

    /// 提取emoji表情字符串
    var emojiString: String {
        return emojis.map{String($0) }.reduce("",+)
    }

    /// 提取emoji表情数组
    var emojis: [Character] {
        return filter{ $0.isEmoji}
    }

    /// 提取单元编码标量
    var emojiScalars: [UnicodeScalar] {
        return filter{ $0.isEmoji}.flatMap{ $0.unicodeScalars}
    }
    
}
