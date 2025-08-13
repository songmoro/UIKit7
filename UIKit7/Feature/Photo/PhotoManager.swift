//
//  PhotoManager.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import Foundation
import Alamofire

final class PhotoManager {
    static let shared = PhotoManager()
    private init() { }
    
    func get<T: Decodable>(api: PhotoRouter, success: @escaping (T) -> Void) {
        guard let url = api.url else { return }
        
        AF.request(url, parameters: api.parameters).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
