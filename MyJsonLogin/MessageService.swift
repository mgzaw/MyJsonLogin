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
        
        let action = UIAlertAction(title: "Dismis", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
}


class DeleteService {
    
    func alert(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Delete", style: .destructive, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
}

class LogoutService {
    
    func alert(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "LogOut Ok?", style: .default, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
}
