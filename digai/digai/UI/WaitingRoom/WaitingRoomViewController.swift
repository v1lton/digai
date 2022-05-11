//
//  WaitingRoomViewController.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import UIKit

class WaitingRoomViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private var viewModel: WaitingRoomViewModel
    
    // MARK: - UI
    
    private lazy var playersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont(name: "Rubik-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("Começar", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 14)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        
        button.addTarget(self, action: #selector(didTapStartButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - INITIALIZERS
   
    init(_ response: JoinRoomResponse, socketManager: GameSocketManager?){
        
        self.viewModel = WaitingRoomViewModel(response, socketManager: socketManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupView()
        
        playersLabel.text = viewModel.playersText
    }
    
    // MARK: - ACTIONS

    @objc private func didTapStartButton(_ sender: UIButton) {
        viewModel.startGame()
    }
}

// MARK: - WaitingRoomDelegate

extension WaitingRoomViewController: WaitingRoomDelegate {
    func didUpdatePlayers() {
        playersLabel.text = viewModel.playersText
    }

    func didStartGame(roomResponse: CreateRoomResponse) {
        let gameController = GameViewController(room: roomResponse, socketManager: viewModel.socketManager)
        navigationController?.pushViewController(gameController, animated: true)
    }
}

// MARK: - VIEW CODE

extension WaitingRoomViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(playersLabel)
        view.addSubview(startButton)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            playersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            playersLabel.bottomAnchor.constraint(lessThanOrEqualTo: startButton.topAnchor, constant: -20),
            playersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            startButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
            startButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 106),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .white
        
        navigationItem.title = viewModel.roomId
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                                   .font: UIFont(name: "Rubik-Bold", size: 32)]
    }
}
