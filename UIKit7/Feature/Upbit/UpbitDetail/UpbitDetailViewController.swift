//
//  UpbitDetailViewController.swift
//  UIKit7
//
//  Created by 송재훈 on 8/12/25.
//

import UIKit
import SnapKit

final class UpbitDetailViewController: BaseViewController<UpbitDetailViewModel> {
    private let label = UILabel()
    
    override init(viewModel: UpbitDetailViewModel) {
        super.init(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
                
        label.snp.makeConstraints {
            $0.edges.equalToSuperview(\.safeAreaLayoutGuide)
        }
        
        label.text = viewModel.upbit.overview
        label.textAlignment = .center
    }
}
