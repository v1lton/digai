//
//  LoadingTableViewCell.swift
//  digai
//
//  Created by Jacqueline Alves on 10/05/22.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    // MARK: - PUBLIC PROPERTIES
    
    static let reuseIdentifier = "LoadingCell"
    
    // MARK: - UI
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 0.979, green: 0.982, blue: 0.988, alpha: 1)
        return view
    }()
    
    let spinnerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
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
}

// MARK: - ViewCode

extension LoadingTableViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(spinnerView)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            spinnerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
    
    func additionalConfiguration() {
        contentView.backgroundColor = .white
    }
}
