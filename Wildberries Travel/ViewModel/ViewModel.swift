//
//  ViewModel.swift
//  Wildberries Travel
//
//  Created by Евгений Житников on 27.08.2023.
//

import Foundation
import UIKit

protocol ViewModelProtocol {
    var onStateDidChange: ((ViewModel.State) -> Void)? { get set }
    func refreshFlights (viewInput: ViewModel.ViewInput)
}

class ViewModel: ViewModelProtocol {
    
    enum State {
        case initial
        case loading
        case loaded(flights: [Flight])
        case error(Error)
    }
    enum ViewInput {
        case startLoad
    }
    
    var onStateDidChange: ((State) -> Void)?

    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    private let networkService: NetworkServiceProtocol

    init(networksService: NetworkServiceProtocol) {
        self.networkService = networksService
    }
    
    func refreshFlights (viewInput: ViewModel.ViewInput){
        switch viewInput {
        case .startLoad:
            state = .loading
            networkService.getFLights(){ [weak self] result in
                switch result {
                case .success(let result):
                    print(result.flights)
                    self?.state = .loaded(flights: result.flights)
                case .failure(let error):
                    self?.state = .error(error)
                }
            }
        }
    }
}
