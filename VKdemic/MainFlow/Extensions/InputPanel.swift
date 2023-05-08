//
//  InputPanel.swift
//  VKdemic
//
//  Created by Djinsolobzik on 04.05.2023.
//

import UIKit

class InputPanel: UIView {

    let inputTextField: UITextField
    let title: String

    private lazy var nameInput: UILabel = {
        let label = UILabel(name: title, font: .systemFont(ofSize: 18, weight: .bold))
        return label
    }()

    init(inputField: UITextField, title: String) {

        self.inputTextField = inputField
        self.title = title
        super.init(frame: .zero)
        setLayout()
        setInputTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubviews(nameInput, inputTextField) {[

            nameInput.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameInput.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            inputTextField.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 8),
            inputTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 44)
        ]}
    }

    private func setInputTextField() {
        inputTextField.backgroundColor = .systemMint
        inputTextField.font = .systemFont(ofSize: 18, weight: .medium)
        inputTextField.layer.cornerRadius = 10
        inputTextField.textAlignment = .center
        inputTextField.keyboardType = .numberPad
    }
}
