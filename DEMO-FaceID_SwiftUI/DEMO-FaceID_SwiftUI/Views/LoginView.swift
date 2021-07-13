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
    private let biometric = BiometricAuthManager()
    private var storage = Storage()

    var loginButton: some View {
        NavigationLink(destination: MainView()) {
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

    var faceIconImageView: some View {
        Image(uiImage: UIImage(named: "faceId")!).resizable().frame(width: 150, height: 150)
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
                    self.faceIconImageView
                }.padding(20)
            }
        }
        .frame(width: 400, height: 300)
    }

    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                loginOrBiometricView
            }
        }

    }

    private func loginUser() {
        viewModel.login()
    }

    func showAlert() {

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

