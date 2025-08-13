//
//  UpbitViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class UpbitViewModel {
    enum InputAction {
        case none
        case viewDidLoad
        case transition(row: Int)
    }
    
    enum OutputAction {
        case none
        case transition(Upbit)
    }
    
    private let service: UpbitService
    
    @MyObservable private(set) var list: [Upbit]
    @MyObservable var inputAction: InputAction
    @MyObservable private(set) var outputAction: OutputAction
    
    init(service: UpbitService = UpbitService(), list: [Upbit] = [], inputAction: InputAction = .none, outputAction: OutputAction = .none) {
        self.service = service
        self._list = .init(value: list)
        self._inputAction = .init(value: inputAction)
        self._outputAction = .init(value: outputAction)
        
        bind()
    }
    
    private func bind() {
        $inputAction.bind {
            switch $0 {
            case .viewDidLoad:
                self.callAPI()
            case .transition(let row):
                self.outputAction = .transition(self.list[row])
            default:
                break
            }
        }
    }
    
    private func callAPI() {
        service.callUpbit { [weak self] in
            self?.list = $0
        }
    }
}
