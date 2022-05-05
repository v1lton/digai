//
//  WaitingRoomViewController.swift
//  digai
//
//  Created by Morgana Galamba on 02/05/22.
//

import UIKit

class WaitingRoomViewController: UIViewController {
    
    private var viewModel: WaitingRoomViewModel
   
    init(roomName: String, socketManager: GameSocketManager?){
        
        self.viewModel = WaitingRoomViewModel(roomName: roomName, socketManager: socketManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Começar partida", for: .normal)
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
        view.addSubview(startButton)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                                   .font: UIFont(name: "Rubik-Bold", size: 32)]
        self.navigationItem.title = self.viewModel.getRoomId()
        setupConstraints()
               
    }
    
    func setupConstraints(){
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 106).isActive = true
    }
    
    @objc private func didTapStartButton(_ sender: UIButton) {
        viewModel.startGame()
    }
}

extension WaitingRoomViewController: WaitingRoomDelegate {
    func didStopGame() {
        navigationController?.pushViewController(ResultViewController(), animated: false)
    }
    
    func didStartGame(roomResponse: CreateRoomResponse) {
        navigationController?.pushViewController(GameViewController(room: roomResponse, socket: viewModel.socketManager!), animated: true)
    }
}
