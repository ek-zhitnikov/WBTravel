//
//  FlightModel.swift
//  Wildberries Travel
//
//  Created by Евгений Житников on 27.08.2023.
//

import Foundation

struct FlightResponse: Decodable {
    let flights: [Flight]
}

struct Flight: Decodable {
    let startDate: String
    let endDate: String
    let startLocationCode: String
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let serviceClass: String
    let seats: [Seat]
    let price: Int
    let searchToken: String
}

struct Seat: Decodable {
    let passengerType: String
    let count: Int
}
