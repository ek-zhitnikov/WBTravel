//
//  FlightsController.swift
//  Wildberries Travel
//
//  Created by Евгений Житников on 27.08.2023.
//

import UIKit

class FlightsController: UIViewController {

    private var viewModel: ViewModelProtocol
    private var loadingIndicator: UIActivityIndicatorView!
    private var flights: [Flight] = []
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        bindViewModel()
        viewModel.refreshFlights(viewInput: .startLoad)
    }
    
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else {
                return
            }
            switch state {
            case .initial:
                ()
            case .loading:
                print("loading")
                self.loadingIndicator.startAnimating()
            case let .loaded(flights):
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.flights = flights
                    print(self.flights)
                }
            case .error(_):
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func setupActivityIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = view.center
        loadingIndicator.color = .white
        view.addSubview(loadingIndicator)
    }
}
