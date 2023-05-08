//
//  ScorePanel.swift
//  VKdemic
//
//  Created by Djinsolobzik on 07.05.2023.
//

import UIKit

final class ScorePanel: UIView {
    var numHealthy: Int
    var numIlls = 0

    private lazy var healzyLabel: UILabel = {
        let label = UILabel(name: "😃 = \(numHealthy)", font: .systemFont(ofSize: 24))
        label.textColor = .black
        return label
    }()

    private lazy var illLabel: UILabel = {
        let label = UILabel(name: "😰 = \(numIlls)", font: .systemFont(ofSize: 24))
        label.textColor = .black
        return label
    }()

    init(numHealthy: Int) {
        self.numHealthy = numHealthy
        super.init(frame: .zero)
        setLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateScore(with ills: Int) {

        illLabel.text = "😰 = \(ills)"
        healzyLabel.text = "😃 = \(numHealthy - ills)"
    }

    private func setLayout() {
        let hStack = UIStackView(arrangedSubviews: [healzyLabel, illLabel])
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }
}
