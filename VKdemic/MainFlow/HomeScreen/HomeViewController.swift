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
        input.placeholder = "от 1 до 1000"
        return panel
    }()

    private lazy var infectionFactorPanel: InputPanel = {
        let input = UITextField()
        let panel = InputPanel(inputField: input, title: "Фактор инфецирования")
        input.placeholder = "от 0 до 1000"
        return panel
    }()

    private lazy var updateTimePanel: InputPanel = {
        let input = UITextField()
        let panel = InputPanel(inputField: input, title: "Время обновления")
        input.placeholder = "от 1 до 100"
        return panel
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // можно переделать все свойства на UIButtonConfiguration
        button.setTitle("Запустить моделирование", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(toStartGame), for: .touchUpInside)
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

        let mainStackView = UIStackView(arrangedSubviews: [groupSizePanel, infectionFactorPanel, updateTimePanel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 16
        view.addSubviews(mainStackView, startButton) {[

            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            mainStackView.widthAnchor.constraint(equalToConstant: 200),

            startButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 64),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 44)

        ]}
    }

    @objc
    private func toStartGame() {
        guard
            let groupSize = Int(groupSizePanel.inputTextField.text ?? "1"),
            let infectionFactor = Int(infectionFactorPanel.inputTextField.text ?? "1"),
            let updateTime = Int(updateTimePanel.inputTextField.text ?? "1")
        else {
            return
        }

        let setting = GameSettingModel(
            numHealthy: groupSize,
            infectionFactor: infectionFactor,
            updateTime: updateTime
        )
        let gameVC = GameViewController(gameSetting: setting)
        navigationController?.pushViewController(gameVC, animated: false)
    }
}
