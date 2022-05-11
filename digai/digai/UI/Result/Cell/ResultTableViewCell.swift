//
//  ResultTableViewCell.swift
//  digai
//
//  Created by Wilton Ramos on 04/05/22.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    // MARK: - PUBLIC PROPERTIES
    
    static let reuseIdentifier = "ResultCell"
    
    // MARK: - UI
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 0.979, green: 0.982, blue: 0.988, alpha: 1)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - INITIALIZERS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - PUBLIC FUCTIONS
    
    func setName(_ name: String, for position: Int) {
        let decorator = position == 0 ? "🎉" : ""
        nameLabel.text = "\(decorator) \(position + 1). \(name)"
    }
    
    func setResult(userScore: Int, maxiumScore: Int) {
        resultLabel.text = "\(userScore)/\(maxiumScore)"
    }
}

// MARK: - ViewCode

extension ResultTableViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(resultLabel)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            resultLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    func additionalConfiguration() {
        contentView.backgroundColor = .white
    }
}
