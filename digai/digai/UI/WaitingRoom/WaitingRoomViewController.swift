//
//  WaitingRoomViewController.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import UIKit

class WaitingRoomViewController: UIViewController {
    
    private var viewModel: WaitingRoomViewModel
   
    init(_ response: JoinRoomResponse, socketManager: GameSocketManager?){
        
        self.viewModel = WaitingRoomViewModel(response, socketManager: socketManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        button.setTitle("Começar", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapStartButton(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .white
        view.addSubview(playersLabel)
        view.addSubview(startButton)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                                   .font: UIFont(name: "Rubik-Bold", size: 32)]
        self.navigationItem.title = self.viewModel.getRoomId()
        setupConstraints()
        
        playersLabel.text = viewModel.getPlayersText()
    }
    
    func setupConstraints(){
        playersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        playersLabel.bottomAnchor.constraint(lessThanOrEqualTo: startButton.topAnchor, constant: -20).isActive = true
        playersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        playersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        startButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 36).isActive = true
        startButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 106).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                            constant: -20).isActive = true
    }
    
    @objc private func didTapStartButton(_ sender: UIButton) {
        viewModel.startGame()
    }
}

extension WaitingRoomViewController: WaitingRoomDelegate {
    func didUpdatePlayers() {
        playersLabel.text = viewModel.getPlayersText()
    }
    
    func didStopGame() {
        navigationController?.pushViewController(ResultViewController(), animated: false)
    }
    
    func didStartGame(roomResponse: CreateRoomResponse) {
        navigationController?.pushViewController(GameViewController(room: roomResponse,
                                                                    socketManager: viewModel.socketManager), animated: true)
    }
}
