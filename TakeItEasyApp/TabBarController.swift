//
//  LoggedInTabBarController.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/20/22.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet weak var navItemUsername: UINavigationItem!
    @IBAction func buttonSignOut(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginScreen = storyboard.instantiateViewController(withIdentifier: "loginNC")
        loginScreen.modalPresentationStyle = .fullScreen
        self.present(loginScreen, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoad_GetCurrentUserInfo()
    }
    
    func viewDidLoad_GetCurrentUserInfo() {
        CurrentUser.user.updateCurrentUserName()
        print("Current user: \(CurrentUser.user.name!)")
        navItemUsername.title = CurrentUser.user.name!
    }
}
