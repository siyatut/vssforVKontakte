//
//  ResultStatisticsView.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 26/3/2567 BE.
//

import UIKit

class ResultStatisticsView: UIView {
    
    // MARK: - Properties
    
    private var startValue: Double = 0
    
    // MARK: - Views for describing statistics
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let valuePeople: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let percentValuePeople: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 8)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(label: String) {
        self.init()
        headerLabel.text = label
    }
    
    // MARK: - Methods
    
    func reloadViews(_ newValue: Int) {
        valuePeople.text = "\(newValue)"
        let percentValue: Double
        if startValue == 0 {
            percentValue = 0
        } else {
            percentValue = (Double(newValue) / startValue) * 100
        }
        percentValuePeople.text = "\(Int(percentValue))%"
    }
    
    func setValue(_ value: Int) {
        startValue = Double(value)
    }
}

extension ResultStatisticsView {
    
    func configureViews() {
        addViews([backgroundView, headerLabel, valuePeople, percentValuePeople])
        NSLayoutConstraint.activate([
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            valuePeople.centerXAnchor.constraint(equalTo: centerXAnchor),
            valuePeople.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            percentValuePeople.centerXAnchor.constraint(equalTo: centerXAnchor),
            percentValuePeople.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13)
        ])
    }
}
