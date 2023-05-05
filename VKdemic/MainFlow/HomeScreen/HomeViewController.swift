//
//  HomeViewController.swift
//  VKdemic
//
//  Created by Djinsolobzik on 04.05.2023.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var groupSizePanel: InputPanel = {
        let input = UITextField()
        input.becomeFirstResponder()
        let panel = InputPanel(inputField: input, title: "Размер группы")
        return panel
    }()

    private lazy var infectionFactorPanel: InputPanel = {
        let panel = InputPanel(inputField: UITextField(), title: "Фактор инфецирования")
        return panel
    }()

    private lazy var renderTimePanel: InputPanel = {
        let panel = InputPanel(inputField: UITextField(), title: "Время обновления")
        return panel
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Старт", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setNavigation()
        hideKeyboardWhenTappedAround()
    }

    private func setNavigation() {
        title = "VKdemic"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 22, weight: .bold)]
        
    }

    private func setupUI() {

        let mainStackView = UIStackView(arrangedSubviews: [groupSizePanel, infectionFactorPanel, renderTimePanel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 16
        view.addSubviews(mainStackView, startButton) {[

            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            mainStackView.widthAnchor.constraint(equalToConstant: 200),

            startButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 64),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 44),
            startButton.widthAnchor.constraint(equalToConstant: 120)

        ]}
    }
}
