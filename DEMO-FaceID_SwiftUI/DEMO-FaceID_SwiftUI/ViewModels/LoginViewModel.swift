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

    @Published var isLoggedIn = false
    @Published var isLoading = false

    @Published var shouldNavigate = false

    private var disposables: Set<AnyCancellable> = []

    var networkManager = NetworkManager()

    @Published var logUrl = ""

    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        networkManager.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    private var isAuthenticatedPublisher: AnyPublisher<String, Never> {
        networkManager.$successResponse
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return ""
                }

                return response.userId ?? ""
        }
        .eraseToAnyPublisher()
    }

    init() {
        isLoadingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &disposables)

        isAuthenticatedPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.logUrl, on: self)
            .store(in: &disposables)
    }

    func login() {
        networkManager.login(email: username, password: password)
    }


}
