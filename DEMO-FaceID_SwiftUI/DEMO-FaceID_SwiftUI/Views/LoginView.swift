//
//  LoginView.swift
//  DEMO-FaceID_SwiftUI
//
//  Created by User on 09.07.2021.
//

import SwiftUI

protocol LoginViewModelDelegate: View {
    func showAlert()
}

struct LoginView: View, LoginViewModelDelegate {

    @ObservedObject var viewModel = LoginViewModel()
    @State var isActive = false
    @State var stopBacground = false

    private let biometric = BiometricAuthManager()
    private var storage = Storage()

    var loginButton: some View {
        NavigationLink(destination: MainView(), isActive: $isActive) {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Login").foregroundColor(.white).fontWeight(.bold)
                    Spacer()
                }
                Spacer()
            }.frame(minHeight: 55, maxHeight: 55)
            .background(Color.blue)
            .cornerRadius(5)
        }.simultaneousGesture(TapGesture().onEnded {
            self.authenticateUser()
        }).padding(.top, 80).disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
    }

    var placeHolderTextView: some View {
        PlaceholderTextField(placeholder: Text("Username"), text: $viewModel.username)
            .padding(.top, 50)
    }

    var passwordTextView: some View {
        SecurePlaceholderTextField(placeholder: Text("Password"), text: $viewModel.password)
            .padding(.top, 30)
    }

    var titleView: some View {
        VStack(alignment: .leading) {
            Text("Welcome to")
                .tracking(1)
            Text("FaceID DEMO App").fontWeight(.bold)
        }.padding(EdgeInsets(top: 60, leading: .zero, bottom: .zero, trailing: .zero))
    }

    var faceIdEmptyView: some View {
        EmptyView()
    }

    var body: some View {
        NavigationView {
//            NavigationLink(destination: MainView(), isActive: $isActive) {
                LoadingView(isShowing: .constant(viewModel.isLoading)) {
                    VStack(alignment: .leading) {
                        self.titleView
                        self.placeHolderTextView
                        self.passwordTextView
                        self.loginButton
                    }.padding(20)
                }
//            }
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { (_) in
            viewModel.goToBackground(background: true)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { (_) in
            if storage.isInBackground {
                viewModel.goToBackground(background: false)
                authenticateUser()
            }
        }
    }

    init() {
        if !storage.isFirstLaunch {
            authenticateUser()
        }
    }

    private func loginUser() {
        viewModel.login(completion: { _ in
            self.isActive = true
        })
    }

    func authenticateUser() {
        biometric.authenticateUser { (str) in
            loginUser()
        }
    }

    func showAlert() {

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

