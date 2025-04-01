//
//  Data.swift
//  SwiftPro
//
//  Created by 杨益凡 on 2023/4/13.
//

import Foundation

extension Data{
    
    
    /// data 转utf8编码
    /// - Returns: string
    func toString() -> String?{
        String(data: self, encoding: .utf8)
    }
}
