//
//  ViewController.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 22/3/2567 BE.
//

import UIKit

final class InputParametersViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    let nameMainScreen = UILabel()
    let groupSizeTextField = UITextField()
    let infectionFactorTextField = UITextField()
    let recalculationPeriodTextField = UITextField()
    let runSimulationButton = UIButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupStackView()
        setupUIcomponents()
        setupNameMainScreen()
    }
    
    // MARK: - Setup Views
    
    private func setupUIcomponents() {
        
        configureTextField(groupSizeTextField, placeholder: "GroupSize")
        configureTextField(infectionFactorTextField, placeholder: "InfectionFactor")
        configureTextField(recalculationPeriodTextField, placeholder: "Recalculation Period (T)")
        
        runSimulationButton.setTitle("Start simulation", for: .normal)
        runSimulationButton.setTitleColor(.black, for: .normal)
        runSimulationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        runSimulationButton.addTarget(self, action: #selector(runSimulationButtonTapped), for: .touchUpInside)
        runSimulationButton.backgroundColor = .systemMint
        runSimulationButton.layer.cornerRadius = 5
        runSimulationButton.layer.masksToBounds = true
        
        let fields = [groupSizeTextField, infectionFactorTextField, recalculationPeriodTextField]
        for field in fields {
            field.delegate = self
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        backgroundTapped()
    }
    
    private func setupStackView() {
        
        let stackView = UIStackView(arrangedSubviews: [groupSizeTextField, infectionFactorTextField, recalculationPeriodTextField, runSimulationButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNameMainScreen() {
        
        nameMainScreen.text = "Virus spread simulator"
        nameMainScreen.font = .boldSystemFont(ofSize: 20)
        nameMainScreen.textColor = .black
        nameMainScreen.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameMainScreen)
        
        NSLayoutConstraint.activate([
            nameMainScreen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameMainScreen.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func configureTextField(_ textField: UITextField, placeholder: String) {
        
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
    }
    
    @objc private func backgroundTapped(_ sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
    
    // MARK: - Private methods
    
    private func getParameters() -> SimulationParameters {
        
        guard let groupSizeText = groupSizeTextField.text, let groupSize = Int(groupSizeText) else {
            return SimulationParameters()
        }
        guard let infectionFactorText = infectionFactorTextField.text, let infectionFactor = Int(infectionFactorText) else {
            return SimulationParameters()
        }
        guard let recalculationPeriodText = recalculationPeriodTextField.text, let t = Int(recalculationPeriodText) else {
            return SimulationParameters()
        }
        return SimulationParameters(groupSize: groupSize, infectionFactor: infectionFactor, t: t)
    }
    
    @objc private func runSimulationButtonTapped() {
        
        let parameters = getParameters()
        let simulationViewController = SimulationViewController(parameters: parameters)
        navigationController?.pushViewController(simulationViewController, animated: true)
    }
}
