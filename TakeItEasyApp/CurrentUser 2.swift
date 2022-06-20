//
//  CurrentUser.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/16/22.
//

import Foundation

class CurrentUser {
    private init() {}
    static var user = CurrentUser()
    var name : String?
    func updateCurrentUserName() {
        let userDefaults = UserDefaults.standard
        let currentUserEmail = userDefaults.string(forKey: "lastUser")
        self.name = DBHelperUser.dbHelperUser.readUser(email: currentUserEmail!).name
    }
}
