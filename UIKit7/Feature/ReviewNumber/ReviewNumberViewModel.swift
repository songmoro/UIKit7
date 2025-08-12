//
//  ReviewNumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class ReviewNumberViewModel {
    @MyObservable var amount: String?
    
    init(amount: String? = nil) {
        self._amount = .init(value: amount)
    }
    
    func validate(input: String?) -> String {
        guard let text = input else { return "" }
        guard !text.isEmpty else { return "값을 입력해주세요" }
        guard let num = Int(text) else { return "숫자만 입력해주세요" }
        guard 1...10000000 ~= num else { return "1,000만원 이하를 입력해주세요" }
        
        let format = NumberFormatter()
        format.numberStyle = .decimal
        let wonResult = format.string(from: num as NSNumber)!
        
        //            let converted = Double(num) / exchangeRate
        //            let convertedFormat = NumberFormatter()
        //            convertedFormat.numberStyle = .currency
        //            convertedFormat.currencyCode = "USD"
        //            let convertedResult = convertedFormat.string(from: converted as NSNumber)
        //            convertedAmountLabel.text = convertedResult
        
        return "₩" + wonResult
    }
}
