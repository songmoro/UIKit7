//
//  Router.swift
//  UIKit7
//
//  Created by 송재훈 on 8/13/25.
//

import Foundation
import Alamofire

protocol Router {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}

enum PhotoRouter: Router {
    case id(id: Int)
    case list(page: Int)
    
    var baseURL: String {
        return "https://picsum.photos"
    }
    
    var path: String {
        switch self {
        case .id(let id):
            "/id/\(id)/info"
        case .list:
            "/v2/list"
        }
    }
    
    var url: URL? {
        URL(string: baseURL + path)
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .id:
            nil
        case .list(let page):
            ["page": page.description]
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
}
