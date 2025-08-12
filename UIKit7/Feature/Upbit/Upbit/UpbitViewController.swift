//
//  UpbitViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import UIKit
import SnapKit

class UpbitViewController: BaseViewController<UpbitViewModel> {
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        return tableView
    }()
    
    override init(viewModel: UpbitViewModel = .init()) {
        super.init(viewModel: viewModel)
        bindData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputAction = .viewDidLoad
        
        configure()
    }
    
    private func configure() {
        navigationItem.title = "마켓 목록"
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindData() {
        viewModel.$list.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.$outputAction.bind { [weak self] in
            switch $0 {
            case .transition(let upbit):
                let vm = UpbitDetailViewModel(upbit: upbit)
                self?.transition(UpbitDetailViewController(viewModel: vm), .push)
            default:
                break
            }
        }
    }
}

extension UpbitViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let overview = viewModel.list[indexPath.row].overview
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        viewModel.inputAction = .transition(row: index)
    }
}
