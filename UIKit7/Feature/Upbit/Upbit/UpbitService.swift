//
//  UpbitService.swift
//  UIKit7
//
//  Created by 송재훈 on 8/12/25.
//

import Alamofire

struct UpbitService {
    func callUpbit(handler: @escaping ([Upbit]) -> Void ) {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url)
            .responseDecodable(of: [Upbit].self) {
                switch $0.result {
                case .success(let response):
                    handler(response)
                default:
                    handler([])
                }
            }
    }
}
