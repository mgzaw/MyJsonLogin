//
//  MainViewController.swift
//  MyJsonLogin
//
//  Created by U Moe Nyo Gyi on 2021/08/01.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var user: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = user?.Username {
            label.text = "Welcome, \(name.capitalized)"
        }
    }

}
