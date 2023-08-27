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
    private var collectionView: UICollectionView!
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController  {
            navigationController.navigationBar.barTintColor = UIColor(named: "WBDark")
        }
        setupCollectionView()
        setupActivityIndicator()
        bindViewModel()
        viewModel.refreshFlights(viewInput: .startLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
                self.loadingIndicator.startAnimating()
            case let .loaded(flights):
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.flights = flights
                    self.collectionView.reloadData()
                }
            case .error(let error):
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.showAlert(alert: error.localizedDescription)
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
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 40, height: 160)
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FlightsViewCell.self, forCellWithReuseIdentifier: "FlightCell")
        collectionView.backgroundColor = UIColor(named: "WBDark")
        view.addSubview(collectionView)
    }
}

extension FlightsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flights.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flight = flights[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightCell", for: indexPath) as! FlightsViewCell
        cell.configure(with: flight)
        return cell
    }
}

extension FlightsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFlight = flights[indexPath.item]
        guard let navigationController else { return}
        viewModel.refreshFlights(viewInput: .flightDidSelect(selectedFlight: selectedFlight, navigationController: navigationController))
    }
}
