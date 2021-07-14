//
//  LoginViewModel.swift
//  DEMO-FaceID_SwiftUI
//
//  Created by User on 12.07.2021.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject, Identifiable {

    @Published var username = ""
    @Published var password = ""

    // @Published var username = "a_podcast_admin@axon.dev"
    //@Published var password = "Qwerty1234567"

    @Published var isLoggedIn = false
    @Published var isLoading = false

    private var networkManager = NetworkManager()
    private var storage = Storage()

    init() {

    }

    func goToBackground(background: Bool) {
        self.storage.isInBackground = background
    }

    func login(completion: @escaping(Bool) -> Void) {
        networkManager.login(email: username, password: password, completion: { response in
            self.storage.isFirstLaunch = false

            completion(true)
        })
    }

}
