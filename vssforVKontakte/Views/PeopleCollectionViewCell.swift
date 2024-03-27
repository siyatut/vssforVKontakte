//
//  PeopleCollectionViewCell.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 26/3/2567 BE.
//

import UIKit

final class PeopleCollectionCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    // MARK: - Public methods
    
    func setupCell(isInfected: Bool) {
        configureApperance()
        configureLayout()
        reloadCell(isInfected: isInfected)
    }

    
    // MARK: - Private methods
    
    private func reloadCell(isInfected: Bool) {
        imageView.tintColor = isInfected ? .red : .black
    }
}

extension PeopleCollectionCell {
    
    func configureApperance() {
        self.backgroundColor = .clear
        addViews(imageView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
