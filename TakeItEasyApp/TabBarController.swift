//
//  TabBarController.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/16/22.
//

import UIKit

// MARK: - Change on Main.storyboard (Update TabBarController custom class)
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoad_TransparentTabBar()
    }
    func viewDidLoad_TransparentTabBar() {
        let appearanceTabBar = UITabBarAppearance()
        appearanceTabBar.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = appearanceTabBar
    }
}
