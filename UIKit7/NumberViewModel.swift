//
//  NumberViewModel.swift
//  UIKit7
//
//  Created by 송재훈 on 8/8/25.
//

import Foundation
import UIKit

class NumberViewModel {
    var inputText: String? = "" {
        willSet {
            output = validate(inputText)
        }
    }
    
    var output: (String, UIColor) = ("", .clear)
    
    private func validate(_ text: String?) -> (String, UIColor) {
        guard let text else { return ("", .red) }
        guard !text.isEmpty else { return ("값을 입력해주세요", .red) }
        guard let num = Int(text) else { return ("숫자만 입력해주세요", .red) }
        guard 0...1_000_000 ~= num else { return ("백만원 이하를 입력해주세요", .red) }
        
        let format = NumberFormatter()
        format.numberStyle = .decimal
        let result = format.string(from: num as NSNumber)!
        
        return ("₩" + result, .blue)
    }
}
