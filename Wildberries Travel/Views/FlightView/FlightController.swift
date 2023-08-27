//
//  FlightController.swift
//  Wildberries Travel
//
//  Created by Евгений Житников on 27.08.2023.
//

import UIKit

class FlightController: UIViewController {
    
    private var flight: Flight!
    private var isLiked: Bool = false
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        view.setImage(heartImage, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 28)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var departureLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var departureDateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var returnLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var returnDateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    convenience init(flight: Flight) {
        self.init()
        self.flight = flight
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundView()
        setupSubViews()
        configureFlightDetails()
    }

    private func setupView() {
        view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 5),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5),
        ])
    }

    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    private func setupSubViews() {
        backgroundView.addSubview(likeButton)
        backgroundView.addSubview(priceLabel)
        backgroundView.addSubview(departureLabel)
        backgroundView.addSubview(departureDateLabel)
        backgroundView.addSubview(returnLabel)
        backgroundView.addSubview(returnDateLabel)

        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 30),
            
            likeButton.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30),
            
            departureLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            departureLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            departureLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            departureLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),

            departureDateLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            departureDateLabel.topAnchor.constraint(equalTo: departureLabel.bottomAnchor, constant: 5),
            departureDateLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            departureDateLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            
            returnLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            returnLabel.topAnchor.constraint(equalTo: departureDateLabel.bottomAnchor, constant: 30),
            returnLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            returnLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),

            returnDateLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            returnDateLabel.topAnchor.constraint(equalTo: returnLabel.bottomAnchor, constant: 5),
            returnDateLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            returnDateLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20)
        ])
    }
    
    @objc private func likeButtonTapped() {
        isLiked.toggle()
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func configureFlightDetails() {
        priceLabel.text = "\(flight.price) ₽"
        
        departureLabel.text = "\(flight.startCity) ➔ \(flight.endCity)"
        departureDateLabel.text = "Вылет: \(convertDateFormat(flight.startDate) ?? "Uncorrect Date") в \(convertDateFormat2(flight.startDate) ?? "Uncorrect Time")"
        
        returnLabel.text = "\(flight.endCity) ➔ \(flight.startCity)"
        returnDateLabel.text = "Вылет: \(convertDateFormat(flight.endDate) ?? "Uncorrect Date") в \(convertDateFormat2(flight.endDate) ?? "Uncorrect Time")"
        
        updateLikeButtonState()
    }

    private func updateLikeButtonState() {
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func convertDateFormat(_ inputDateString: String) -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ 'UTC'"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd MMMM yyyy"
        
        if let date = inputDateFormatter.date(from: inputDateString) {
            let outputDateString = outputDateFormatter.string(from: date)
            return outputDateString
        } else {
            return nil
        }
    }
    
    private func convertDateFormat2(_ inputDateString: String) -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ 'UTC'"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "HH:mm"
        
        if let date = inputDateFormatter.date(from: inputDateString) {
            let outputDateString = outputDateFormatter.string(from: date)
            return outputDateString
        } else {
            return nil
        }
    }
}
