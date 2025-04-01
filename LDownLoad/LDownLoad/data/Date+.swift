//
//  Dataformater+..swift
//  BilibiliLive
//
//  Created by yicheng on 2022/10/23.
//

import Foundation

extension Date {
    

    /// 时间戳转string
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - formatter: yyyy-MM-dd HH:mm:ss
    /// - Returns: string
    static func stringFor(timestamp: Int?,formatter:String) -> String? {
        let formater = DateFormatter()
        formater.dateFormat = formatter
        guard let timestamp = timestamp else { return nil }
        return formater.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    
    /// 当前时间转string
    /// - Returns: yyyy-MM-dd HH:mm:ss
    static func nowDateString()->String{
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if #available(iOS 15, *) {
            let nowStr = formater.string(from: Date.now)
            return nowStr
        } else {
            // Fallback on earlier versions
            let nowStr = formater.string(from: Date())
            return nowStr
        }
    }
    
    
    /// date转string
    /// - Parameters:
    ///   - form: yyyy-MM-dd HH:mm:ss
    /// - Returns: string
    func toString(_ form:String)->String{
        let formater = DateFormatter()
        formater.dateFormat = form
        return formater.string(from: self)
    }
    
}
