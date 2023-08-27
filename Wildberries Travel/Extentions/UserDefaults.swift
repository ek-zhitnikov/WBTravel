//
//  UserDefaults.swift
//  Wildberries Travel
//
//  Created by Евгений Житников on 27.08.2023.
//

import Foundation

extension UserDefaults {
    func saveLikeState(_ isLiked: Bool, for searchToken: String) {
        set(isLiked, forKey: searchToken)
    }
    
    func getLikeState(for searchToken: String) -> Bool {
        return bool(forKey: searchToken)
    }
}
