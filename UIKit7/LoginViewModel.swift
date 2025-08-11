//
//  LoginViewModel.swift
//  UIKit7
//
//  Created by 송재훈 on 8/11/25.
//

import Foundation
import Combine

final class LoginViewModel {
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        print(#function, "2")
    }
    
    @Published var idText: String? = ""
    @Published var pwdText: String? = ""
    
    let output = CurrentValueSubject<(String, Bool), Never>(("", false))
    
    init(idText: String? = nil, pwdText: String? = nil) {
        self.idText = idText
        self.pwdText = pwdText
        
        bind()
    }
    
    private func bind() {
        $idText.combineLatest($pwdText)
            .compactMap { [weak self] in
                return self?.validate($0.0, $0.1)
            }
            .sink { [weak self] in
                self?.output.send($0)
            }
            .store(in: &cancellables)
    }
    
    private func validate(_ idText: String?, _ pwdText: String?) -> (String, Bool) {
        guard let id = idText, let pw = pwdText else {
            return ("nil입니다", false)
        }
        
        if id.count >= 4 && pw.count >= 4 {
            return ("잘 했어요", true)
        } else {
            return ("아이디, 비밀번호 4자리 이상입니다.", false)
        }
    }
}
