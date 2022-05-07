//
//  ViewCode.swift
//  digai
//
//  Created by Jacqueline Alves on 07/05/22.
//

import Foundation

protocol ViewCode {
    func buildViewHierarchy()
    func applyConstraints()
    func additionalConfiguration()
    func setupView()
}

extension ViewCode {
    func additionalConfiguration() {}
    func setupView() {
        buildViewHierarchy()
        applyConstraints()
        additionalConfiguration()
    }
}
