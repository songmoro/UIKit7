//
//  NumberViewModel.swift
//  UIKit7
//
//  Created by 송재훈 on 8/8/25.
//

import Foundation
import UIKit

class NumberViewModel {
    var text: MyObservable<String?> =  .init(value: "")
    var outputText: MyObservable<String> = .init(value: "")
    var outputColor: MyObservable<UIColor> = .init(value: .clear)
    
    init() {
        bind()
    }
    
    private func bind() {
        text.bind { [weak self] in
            guard let output = self?.validate($0) else { return }
            self?.outputText.wrappedValue = output.0
            self?.outputColor.wrappedValue = output.1
        }
    }
    
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
