//
//  UIViewController.swift
//  Wildberries Travel
//
//  Created by Евгений Житников on 27.08.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
     func showAlert(alert: String) {
        let alert = UIAlertController(title: "Ошибка", message: alert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func convertDateFormat(_ inputDateString: String) -> String? {
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
    
     func convertDateFormat2(_ inputDateString: String) -> String? {
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
