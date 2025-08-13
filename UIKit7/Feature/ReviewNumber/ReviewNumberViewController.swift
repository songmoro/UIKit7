//
//  ReviewNumberViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import UIKit
import SnapKit
import Combine

class ReviewNumberViewController: BaseViewController<ReviewNumberViewModel> {
    private var cancellables = Set<AnyCancellable>()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "₩0"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private let convertedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(viewModel: ReviewNumberViewModel = ReviewNumberViewModel()) {
        super.init(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        bindData()
    }
    
    private func bindData() {
        amountTextField.publisher(.editingChanged)
            .compactMap { $0 as? UITextField }
            .map(\.text)
            .sink { [weak self] in
                self?.viewModel.input.amount = $0
            }
            .store(in: &cancellables)
        
        viewModel.output.$won.bind { [weak self] in
            self?.formattedAmountLabel.text = $0
        }
        
        viewModel.output.$usd.bind { [weak self] in
            self?.convertedAmountLabel.text = $0
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let open = UIAlertAction(title: "확인", style: .default)
        let delete = UIAlertAction(title: "삭제", style: .destructive)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        [cancel, delete, open].forEach(alert.addAction)
        
        present(alert, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        [amountTextField, formattedAmountLabel, convertedAmountLabel].forEach(view.addSubview)
    }
    
    private func configureConstraints() {
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        formattedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
        convertedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(formattedAmountLabel.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }
}
