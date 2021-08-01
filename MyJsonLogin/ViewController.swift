//
//  ViewController.swift
//  MyJsonLogin
//
//  Created by U Moe Nyo Gyi on 2021/08/01.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let alertService = AlertService()
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func didTapLoginButton(_ sender: Any) {
        
        guard
            let username = usernameTextField.text,
            let password = passwordTextField.text
        else {return}
        
        let logininfo = LoginInfo(Usercode: username, Password: password)
        networkingService.request(endpoint: "Auth/Login", loginObject: logininfo) { [weak self] (result) in
            switch result {
            case.success(let userinfo): self?.performSegue(withIdentifier: "loginSegue", sender: userinfo)
            case.failure(let error):
                guard let alert = self?.alertService.alert(message: error.localizedDescription) else { return }
                self?.present(alert, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let mainAppVC = segue.destination as? MainViewController, let user = sender as? UserInfo {
            
            mainAppVC.user = user
        }
    }
}

