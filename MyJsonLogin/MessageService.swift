//
//  AlertService.swift
//  MyJsonLogin
//
//  Created by U Moe Nyo Gyi on 2021/08/01.
//

import UIKit

class AlertService {
    
    func alert(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
}


