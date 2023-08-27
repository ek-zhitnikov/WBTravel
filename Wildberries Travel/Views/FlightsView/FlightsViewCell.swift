//
//  FlightsViewCell.swift
//  Wildberries Travel
//
//  Created by Евгений Житников on 27.08.2023.
//

import UIKit

class FlightsViewCell: UICollectionViewCell {
    
    var flight: Flight!
    private var isLiked: Bool = false

    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 22)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var departureLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var departureDateLabel1: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.text = "Туда:"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var departureDateLabel2: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var returnDateLabel1: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.text = "Обратно:"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var returnDateLabel2: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        view.setImage(heartImage, for: .normal)
        view.tintColor = UIColor(named: "WBLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(priceLabel)
        addSubview(departureLabel)
        addSubview(departureDateLabel1)
        addSubview(departureDateLabel2)
        addSubview(returnDateLabel1)
        addSubview(returnDateLabel2)
        addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            departureLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            departureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            departureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            departureDateLabel1.topAnchor.constraint(equalTo: departureLabel.bottomAnchor, constant: 15),
            departureDateLabel1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            departureDateLabel2.topAnchor.constraint(equalTo: departureLabel.bottomAnchor, constant: 15),
            departureDateLabel2.leadingAnchor.constraint(equalTo: departureDateLabel1.trailingAnchor, constant: 5),
            
            returnDateLabel1.topAnchor.constraint(equalTo: departureDateLabel1.bottomAnchor, constant: 5),
            returnDateLabel1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            returnDateLabel2.topAnchor.constraint(equalTo: departureDateLabel1.bottomAnchor, constant: 5),
            returnDateLabel2.leadingAnchor.constraint(equalTo: returnDateLabel1.trailingAnchor, constant: 5),
            
            likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

        ])
    }
    
    @objc private func likeButtonTapped() {
        isLiked.toggle()
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        UserDefaults.standard.saveLikeState(isLiked, for: flight.searchToken)
    }
    
    func configure(with flight: Flight) {
        self.flight = flight
        
        departureLabel.text = "\(flight.startCity) ➔ \(flight.endCity)"
        departureDateLabel2.text = "\(convertDateFormat(flight.startDate) ?? "Uncorrect Date")"
        returnDateLabel2.text = "\(convertDateFormat(flight.endDate) ?? "Uncorrect Date")"
        priceLabel.text = "\(flight.price) ₽"
        
        updateLikeButtonState()
    }
    
    private func updateLikeButtonState() {
        let isLiked = UserDefaults.standard.getLikeState(for: flight.searchToken)
        self.isLiked = isLiked
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
