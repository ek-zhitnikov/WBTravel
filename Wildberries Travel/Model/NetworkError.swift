//
//  NetworkError.swift
//  Wildberries Travel
//
//  Created by Евгений Житников on 27.08.2023.
//

import Foundation

enum NetworkError: Error {
    case requestFailed
    case invalidResponse
    case dataNotReceived
    case dataParsingFailed
}
