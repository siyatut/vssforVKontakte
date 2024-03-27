//
//  PeopleCollectionView.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 26/3/2567 BE.
//

import UIKit

final class PeopleCollectionView: UIView {
    
    // MARK: - Properties
    private let rowCount: CGFloat = 7
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
        return layout
    }()
    
    // MARK: - View
    private var collectionView: UICollectionView!
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PeopleCollectionCell.self, forCellWithReuseIdentifier: "PeopleCollectionCell")
    }
    
    
    // MARK: - Public methods
    func reloadCells(at indexes: [Int]) {
        let indexPaths = indexes.map( { IndexPath(item: $0, section: 0)})
        DispatchQueue.main.async {
            self.collectionView.reconfigureItems(at: indexPaths)
        }
    }
}

// MARK: - Configure appearance and layout
extension PeopleCollectionView {
    
    func configureAppearance() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        addViews(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        configureLayout()
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension PeopleCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SimulationController.shared.getPeopleSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCollectionCell", for: indexPath) as? PeopleCollectionCell else { return UICollectionViewCell() }
        
        cell.setupCell(isInfected: SimulationController.shared.getPeopleAtIndex(indexPath.row).checkInfection())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !SimulationController.shared.getPeopleAtIndex(indexPath.row).checkInfection() {
            feedbackGenerator.impactOccurred()
        }
        SimulationController.shared.didTapPerson(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PeopleCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = rowCount
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: 100)
    }
}


