//
//  Character+.swift
//  Shiny
//
//  Created by 杨益凡 on 2023/5/11.
//  Copyright © 2023 YYF. All rights reserved.
//

import Foundation

extension Character{
    
    //简单的emoji是一个标量 以emoji的形式呈现给用户
//    var isSimpleEmoji: Bool {
//        guard let firstProperties = unicodeScalars.first?.properties else{
//            return false
//        }
//        return unicodeScalars.count == 1 && (firstProperties.isEmojiPresentation || firstProperties.generalCategory == .otherSymbol)
//    }
//
//    //检测标量是否将合并到emoji中
//    var isCombineIntoEmoji: Bool{
//        return unicodeScalars.count > 1 && unicodeScalars.contains{$0.properties.isJoinControl || $0.properties.isVariationSelector}
//    }
    
    //属否为emoji表情
    var isEmoji: Bool {
        for scalar in unicodeScalars{
            switch scalar.value{
            case
                0x00A0...0x00AF,
                0x2030...0x204F,
                0x2120...0x213F,
                0x2190...0x21AF,
                0x2310...0x3000,
                0x1F000...0x1F9CF,
                0x1F9D0...0x1F9DF,
                0x1F9E0...0x1F9E5,
                0x1F9E7...0x1F9FF:
                return true
            default:
                break
            }
        }
        return false
//        return isSimpleEmoji || isCombineIntoEmoji
    }
    
}
