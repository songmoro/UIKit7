//
//  ARCTestViewController.swift
//  UIKit7
//
//  Created by 송재훈 on 8/14/25.
//

import UIKit

final class ARCTestViewController: UIViewController {
    init() {
        print(#function, "Parent")
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print(#function, "Parent")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transition(ARCTestChildViewController(), .push)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
    }
}

final class ARCTestChildViewController: UIViewController {
    var a = 0
    
    lazy var t = { [weak self] in
        print("..", self?.a)
    }
    
    init() {
        print(Self.self, #function)
        super.init(nibName: nil, bundle: nil)
        t()
    }
    
    deinit {
        print(Self.self, #function)
        print(a)
    }
    
    func bind() {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
}
