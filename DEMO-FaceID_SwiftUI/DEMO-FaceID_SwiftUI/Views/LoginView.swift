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
        }.simultaneousGesture(TapGesture().onEnded{
            self.loginUser()
        }).padding(.top, 80)

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

    var loginOrBiometricView: some View {
        Group {
            if self.storage.isFirstLaunch {
                VStack(alignment: .leading) {
                    self.titleView
                    self.placeHolderTextView
                    self.passwordTextView
                    self.loginButton
                }.padding(20)
            } else {
                VStack(alignment: .leading) {
                    self.faceIdEmptyView
                }.padding(20)
            }
        }.frame(width: 400, height: 300)
    }

    var body: some View {
        NavigationView {
            NavigationLink(destination: MainView(), isActive: $isActive) {
                LoadingView(isShowing: .constant(viewModel.isLoading)) {
                    loginOrBiometricView
                }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { (_) in
                    print("UIApplication: background")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { (_) in
                    if isActive {
                        authenticateUser()
                    }
                }
            }
        }
    }

    init() {
        authenticateUser()
    }

    private func loginUser() {
        viewModel.login(completion: { _ in

        })
    }

    func authenticateUser() {
        if !storage.isFirstLaunch {
            biometric.authenticateUser { (str) in
                loginUser()
            }
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

