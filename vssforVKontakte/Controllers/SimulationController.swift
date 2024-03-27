//
//  SimulationController.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 26/3/2567 BE.
//

import UIKit

protocol SimulationDelegate: AnyObject {
    func reloadPeopleViews(for indexes: [Int])
}

final class SimulationController {
    
    static let shared = SimulationController()
    private init() {}
    
    // MARK: - Properties
    private var parameters: SimulationParameters!
    private var people: [People] = []
    private var indexesForReload: [Int] = []
    private var indexesOfInfectedPeople: [Int] = []
    
    private weak var timer: Timer?
    private weak var simulationDelegate: SimulationDelegate?
    
    private let queue = DispatchQueue.global(qos: .userInitiated)
    
    
    // MARK: - Public methods
    func startCalculation(with parameters: SimulationParameters, delegate: SimulationDelegate) {
        self.parameters = parameters
        self.simulationDelegate = delegate
        createTemplatePeople()
        startTimer()
    }
    
    func didTapPerson(at index: Int) {
        guard index <= people.count else { return }
        
        if people[index].tryInfect() {
            indexesOfInfectedPeople.append(index)
            simulationDelegate?.reloadPeopleViews(for: [index])
        }
    }
    
    func getPeopleSize() -> Int {
        return people.count
    }
    
    func getPeopleAtIndex(_ i: Int) -> People {
        guard i < people.count else { return People()}
        return people[i]
    }
    
    func stopCalculation() {
        timer?.invalidate()
        indexesOfInfectedPeople = []
        people = []
    }
    
    func getInfectedCount() -> Int {
        return indexesOfInfectedPeople.count
    }
    
    
    // MARK: - Private methods
    private func createTemplatePeople() {
        people = [People](repeating: People(), count: parameters.groupSize)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: parameters.tInterval, target: self, selector: #selector(calculateInfection), userInfo: nil, repeats: true)
        timer?.tolerance = parameters.tInterval * 0.2
    }
    
    @objc private func calculateInfection(){
        guard indexesOfInfectedPeople.count != people.count else { return }
        
        queue.async {
            for h in self.indexesOfInfectedPeople {
                self.infectNearPeople(for: h, times: self.parameters.infectionFactor)
            }

            DispatchQueue.main.async {
                self.simulationDelegate?.reloadPeopleViews(for: self.indexesForReload.map { $0 } )
            }
        }

        self.indexesForReload = []
    }
    
    private func infectNearPeople(for index: Int, times: Int) {
        guard times > 0 else { return }
        
        let NearPeopleIndexes = getNearIndexes(for: index)
        
        let n = NearPeopleIndexes[Int.random(in: 0..<NearPeopleIndexes.count)]
        if n >= 0 && n < people.count {
            if people[n].tryInfect() {
                indexesOfInfectedPeople.append(n)
                indexesForReload.append(n)
            }
            if Bool.random() {
                infectNearPeople(for: n, times: times - 1)
            }
        }
    }
    
    private func getNearIndexes(for index: Int) -> [Int] {
        var indexes = [index+7, index-7]
        
        if index % 7 == 0 {
            indexes.append(index+1)
        }
        else if index % 7 == 6 {
            indexes.append(index-1)
        }
        else {
            indexes.append(index-1)
            indexes.append(index+1)
        }
        return indexes
    }
}
