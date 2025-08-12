//
//  ReviewViewController.swift
//  UIKit7
//
//  Created by 송재훈 on 8/12/25.
//

import UIKit


final class ReviewViewModel {
    @MyObservable(value: 22) var text
    
    init() {

    }
}

final class ReviewViewController: UIViewController {
    let viewModel = ReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}
