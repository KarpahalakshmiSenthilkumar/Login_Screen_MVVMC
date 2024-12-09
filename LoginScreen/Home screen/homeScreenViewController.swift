//
//  homeScreenViewController.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var viewModel: HomeScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultStates()
    }
}

extension HomeScreenViewController {
    func setDefaultStates() {
        self.usernameLabel.text = self.viewModel.outputs.emailValue.value
        self.passwordLabel.text = self.viewModel.outputs.passwordValue.value
    }
}
