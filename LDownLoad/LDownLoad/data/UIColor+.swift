//
//  UIColor+.swift
//  Shiny
//
//  Created by 杨益凡 on 2023/5/5.
//  Copyright © 2023 YYF. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    /// rgba颜色
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    ///   - a: alpha 0-1，默认1
    /// - Returns: color
    static func rgba(_ r:CGFloat, g:CGFloat ,b:CGFloat,a:CGFloat? = nil )->UIColor{
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a ?? 1)
    }
    
    
    /// 16进制的颜色
    /// - Parameter value: 0x
    /// - Returns: color
    static func color16(_ value:Int)->UIColor{
        return UIColor(red: ((CGFloat)((value & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((value & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(value & 0xFF)) / 255.0, alpha: 1);
    }
}
