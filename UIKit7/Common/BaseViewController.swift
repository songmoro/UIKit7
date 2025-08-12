//
//  BaseViewController.swift
//  UIKit7
//
//  Created by 송재훈 on 8/12/25.
//

import UIKit

class BaseViewController<ViewModel>: UIViewController {
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
