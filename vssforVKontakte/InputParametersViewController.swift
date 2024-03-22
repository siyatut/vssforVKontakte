//
//  ViewController.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 22/3/2567 BE.
//

import UIKit

class InputParametersViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    let groupSizeTextField = UITextField()
    let infectionFactorTextField = UITextField()
    let recalculationPeriodTextField = UITextField()
    let runSimulationButton = UIButton()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupStackView()
        setupUIcomponents()
    }

    // MARK: - Setup
    private func setupUIcomponents() {
        configureTextField(groupSizeTextField, placeholder: "GroupSize")
        configureTextField(infectionFactorTextField, placeholder: "InfectionFactor")
        configureTextField(recalculationPeriodTextField, placeholder: "Recalculation Period (T)")
        
        runSimulationButton.setTitle("Запустить моделирование", for: .normal)
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

    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
    }
    
   
    // MARK: - Objc func
    @objc private func runSimulationButtonTapped() {
        print("Кнопка запустить симуляцию нажата.")
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
}

