//
//  ReviewNumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class ReviewNumberViewModel {
    struct Input {
        @MyObservable var amount: String?
    }
    
    struct Output {
        @MyObservable var won: String?
        @MyObservable var usd: String?
    }
    
    var input: Input
    private(set) var output: Output
    
    init(input: Input = .init(amount: .init(value: "")), output: Output = .init(won: .init(value: ""), usd: .init(value: ""))) {
        self.input = input
        self.output = output
        
        bind()
    }
    
    private func bind() {
        input.$amount.bind { [unowned self] in
            let num = validate(input: $0)
            
            guard let number = Int(num) else {
                output.won = num
                return
            }
            
            output.won = formatWon(number)
        }
        
        input.$amount.bind { [unowned self] in
            let num = validate(input: $0)
            
            guard let number = Int(num) else {
                output.usd = num
                return
            }
            
            output.usd = formatUSD(number)
        }
    }
    
    private func validate(input: String?) -> String {
        guard let text = input else { return "" }
        guard !text.isEmpty else { return "값을 입력해주세요" }
        guard let num = Int(text) else { return "숫자만 입력해주세요" }
        guard 1...10000000 ~= num else { return "1,000만원 이하를 입력해주세요" }
        return num.description
    }
    
    private func formatWon(_ number: Int) -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        let wonResult = format.string(from: number as NSNumber)!
        return "₩" + wonResult
    }
    
    private func formatUSD(_ number: Int) -> String {
        let converted = Double(number) / 1350.0
        let convertedFormat = NumberFormatter()
        convertedFormat.numberStyle = .currency
        convertedFormat.currencyCode = "USD"
        let convertedResult = convertedFormat.string(from: converted as NSNumber)!
        return convertedResult
    }
}
