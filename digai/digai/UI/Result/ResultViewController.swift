//
//  ResultViewController.swift
//  digai
//
//  Created by Wilton Ramos on 31/03/22.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private var viewModel: ResultViewModelProtocol
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Acertos"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    private lazy var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.register(ResultTableViewCell.self,
                           forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
        tableView.register(LoadingTableViewCell.self,
                           forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var playAgainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "playAgainButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapPlayAgainButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - INITIALIZERS
    
    init(socketManager: GameSocketManager?){
        self.viewModel = ResultViewModel(socketManager: socketManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupView()
    }

    // MARK: - ACTIONS
    
    @objc private func didTapPlayAgainButton(_ sender: UIButton) {
        print("De novo! De novo!")
    }
}

// MARK: - ResultViewModelDelegate

extension ResultViewController: ResultViewModelDelegate {
    func didGetResults() {
        resultsTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

// MARK: - UITableViewDataSource

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getResultsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? ResultTableViewCell
        
        guard let cell = cell else { return UITableViewCell() }
        
        if let result = viewModel.getIndividualResult(at: indexPath.row) {
            cell.setName(result.name, for: indexPath.row)
            cell.setResult(userScore: result.crowns, maxiumScore: viewModel.getMaximumScore())
        }
        
        return cell
    }
}

// MARK: - ViewCode

extension ResultViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(resultsTableView)
        view.addSubview(playAgainButton)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            playAgainButton.widthAnchor.constraint(equalToConstant: 233),
            playAgainButton.heightAnchor.constraint(equalToConstant: 60),
            playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -96),
            
            resultsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: playAgainButton.topAnchor, constant: 32)
        ])
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .white
    }
}
