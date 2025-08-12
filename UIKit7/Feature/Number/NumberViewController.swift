//
//  NumberViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/8/25.
//

import UIKit
import SnapKit
import Combine

class NumberViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    private let vm = NumberViewModel()

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "값을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        configureUI()
        configureConstraints()
    }
    
    private func bind() {
        vm.$outputText.bind { [weak self] in
            self?.formattedAmountLabel.text = $0
        }
        
        vm.$outputColor.bind { [weak self] in
            self?.formattedAmountLabel.textColor = $0
        }
        
        amountTextField.publisher(.editingChanged)
            .compactMap { $0 as? UITextField }
            .compactMap(\.text)
            .assign(to: \.vm.text, on: self)
            .store(in: &cancellables)
    }
}

extension NumberViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
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
    }
}
