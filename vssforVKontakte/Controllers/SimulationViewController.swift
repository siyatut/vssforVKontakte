//
//  SimulationViewController.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 26/3/2567 BE.
//

import UIKit

final class SimulationViewController: UIViewController {
    
    // MARK: - Properties
    
    private var parameters: SimulationParameters!
    
    private var currentTime: Int = 0
    
    private var timer: Timer = Timer()
    
    
    // MARK: Views
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setImage(UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 19, weight: .bold)), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        return button
    }()
    
    private let counterContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemMint
        return view
    }()
    
    private let counterLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    private let totalInfectedStatisticView = ResultStatisticsView(label: "Infected")
    private let totalUninfectedStatisticView = ResultStatisticsView(label: "Healthy")
    
    private let stackTotalStatsViews: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    private let peopleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    private let peopleCollectionView = PeopleCollectionView()
    
    
    // MARK: - Init
    
    convenience init(parameters: SimulationParameters) {
        self.init()
        self.parameters = parameters
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SimulationController.shared.startCalculation(with: parameters, delegate: self)
        configureApperance()
    }
    
    
    // MARK: - Private methods
    
    @objc private func backButtonTapped() {
        SimulationController.shared.stopCalculation()
        timer.invalidate()
        navigationController?.popViewController(animated: true)
    }
    
    private func timerLabelReload() {
        if currentTime <= parameters.t && currentTime > 1 {
            currentTime -= 1
        }
        else {
            currentTime = parameters.t
        }
        counterLabel.text = "\(currentTime)"
    }
}

extension SimulationViewController: SimulationDelegate {
    
    func reloadPeopleViews(for indexes: [Int]) {
        
        let currentInfected = SimulationController.shared.getInfectedCount()
        let currentGroupSize = parameters.groupSize - currentInfected
        
        totalInfectedStatisticView.reloadView(currentInfected)
        totalUninfectedStatisticView.reloadView(currentGroupSize)
        
        peopleCollectionView.reloadCells(at: indexes)
    }
}

private extension SimulationViewController {
    
    func configureApperance() {
        
        view.addViews([backButton, counterContainerView, stackTotalStatsViews, peopleContainerView])
        counterContainerView.addViews(counterLabel)
        peopleContainerView.addViews(peopleCollectionView)
        stackTotalStatsViews.addArrangedSubview(totalInfectedStatisticView)
        stackTotalStatsViews.addArrangedSubview(totalUninfectedStatisticView)
        
        totalInfectedStatisticView.setValue(parameters.groupSize)
        totalUninfectedStatisticView.setValue(parameters.groupSize)
        totalInfectedStatisticView.reloadView(0)
        totalUninfectedStatisticView.reloadView(parameters.groupSize)
        
        counterLabel.text = "\(parameters.t)"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.timerLabelReload()
        })
        timer.tolerance = 0.2
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        configureLayout()
    }
    
    func configureLayout() {
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor),
            
            counterContainerView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            counterContainerView.trailingAnchor.constraint(equalTo: backButton.trailingAnchor),
            counterContainerView.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
            counterContainerView.heightAnchor.constraint(equalTo: backButton.heightAnchor),
            
            counterLabel.centerXAnchor.constraint(equalTo: counterContainerView.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: counterContainerView.centerYAnchor),
            
            stackTotalStatsViews.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),
            stackTotalStatsViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackTotalStatsViews.topAnchor.constraint(equalTo: backButton.topAnchor),
            stackTotalStatsViews.bottomAnchor.constraint(equalTo: counterContainerView.bottomAnchor),
            
            peopleContainerView.topAnchor.constraint(equalTo: counterContainerView.bottomAnchor, constant: 25),
            peopleContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            peopleContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            peopleContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            peopleCollectionView.topAnchor.constraint(equalTo: peopleContainerView.topAnchor),
            peopleCollectionView.bottomAnchor.constraint(equalTo: peopleContainerView.bottomAnchor),
            peopleCollectionView.trailingAnchor.constraint(equalTo: peopleContainerView.trailingAnchor, constant: -10),
            peopleCollectionView.leadingAnchor.constraint(equalTo: peopleContainerView.leadingAnchor, constant: 10)
        ])
    }
}
