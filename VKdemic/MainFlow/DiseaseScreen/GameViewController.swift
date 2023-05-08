//
//  GameViewController.swift
//  VKdemic
//
//  Created by Djinsolobzik on 05.05.2023.
//

import UIKit

protocol GameViewControllerProtocol {
    func startGame()
    func updateTime()
}

final class GameViewController: UIViewController {

    // MARK: - Properties

    var gameSetting: GameSettingModel

    // MARK: - Private Properties
    private let calculateQueue = DispatchQueue.global(qos: .userInitiated)

    private var views: [PersonModel] = []
    private var animator: UIDynamicAnimator!
    private var updateTimer: Timer!

    private lazy var scorePanel: ScorePanel = {
        ScorePanel(numHealthy: gameSetting.numHealthy)
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = contentSize
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.frame.size = contentSize
        return view
    }()

    private var contentSize: CGSize {

        CGSize(width: view.frame.width * 2, height: view.frame.height * 2)
    }

    // MARK: - Init

    init(gameSetting: GameSettingModel) {
        self.gameSetting = gameSetting
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifiCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startGame()
        updateTime()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        calculateQueue.async {
            self.updateTimer.invalidate()
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white
        scorePanel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scorePanel)

        NSLayoutConstraint.activate([
            scorePanel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scorePanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scorePanel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: scorePanel.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
    }

    private func addMoveAnimation() {
        let itemBehavior = UIDynamicItemBehavior(items: views)
        itemBehavior.elasticity = 0.3
        itemBehavior.friction = 0.1
        itemBehavior.resistance = -0.2
        views.forEach { view in
            itemBehavior.addLinearVelocity(CGPoint(x: CGFloat.random(in: -50...50), y: CGFloat.random(in: -50...50)), for: view)
            itemBehavior.addAngularVelocity(50, for: view)
        }
        animator.addBehavior(itemBehavior)
    }


    private func makeAnimator() {
        animator = UIDynamicAnimator(referenceView: self.contentView)
        let collision = UICollisionBehavior(items: views)
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
        collision.collisionMode = .everything
        animator.addBehavior(collision)
    }

    private func createCircleView() {
        for _ in 0..<gameSetting.numHealthy {
            let view = PersonModel(
                frame: CGRect(
                    x: CGFloat.random(in: 1..<UIScreen.main.bounds.width - 10),
                    y: CGFloat.random(in: 60..<UIScreen.main.bounds.height - 80),
                    width: 10,
                    height: 10)
            )
            view.backgroundColor = UIColor.green
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
            view.infectionFactor = (0...gameSetting.infectionFactor).randomElement()!

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            view.addGestureRecognizer(tapGesture)
            views.append(view)
            self.contentView.addSubview(view)
        }
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self.contentView)
        for view in views {
            if view.frame.contains(location) {
                if view.isHealth {
                    view.isHealth = false
                    view.backgroundColor = .red
                }
            }
        }
    }
}

// MARK: - UICollisionBehaviorDelegate

extension GameViewController: UICollisionBehaviorDelegate {

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        guard let view1 = item1 as? PersonModel,
              let view2 = item2 as? PersonModel else {
            return
        }

        if (view1.isHealth && !view2.isHealth) || (!view1.isHealth && view2.isHealth) {

            let illView = view1.isHealth ? view2 : view1
            if illView.infectionFactor > 0 {
                let healthView = view1.isHealth ? view1 : view2 
                healthView.isHealth = false
                illView.infectionFactor -= 1
            }
        }
    }
}

// MARK: - GameViewControllerProtocol

extension GameViewController: GameViewControllerProtocol {
    func startGame() {
        createCircleView()
        makeAnimator()
        addMoveAnimation()
    }

    func updateTime() {
        calculateQueue.async { [weak self] in
            self?.updateTimer = Timer(timeInterval: Double(self?.gameSetting.updateTime ?? 1), repeats: true) { [weak self] _ in
                    var ills = 0
                    self?.views.forEach { person in
                        if !person.isHealth {
                            ills += 1
                            DispatchQueue.main.async {
                                person.backgroundColor = .red
                            }
                        }
                    }
                    print(ills)
                    DispatchQueue.main.async {
                        self?.scorePanel.updateScore(with: ills)
                    }
                }
            let runLoop = RunLoop.current
            runLoop.add((self?.updateTimer)!, forMode: .default)
                runLoop.run()
            }
    }
}
