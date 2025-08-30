//
//  UserSessionManager.swift
//  SwiftGPT
//
//  Created by Owais on 7/31/25.
//

import SwiftUI

class UserSessionManager: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
}
