//
//  LoginView.swift
//  DEMO-FaceID_SwiftUI
//
//  Created by User on 09.07.2021.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()

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
                .padding(.top, 100)

        }.simultaneousGesture(TapGesture().onEnded{
            self.loginUser()
        })
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

    var body: some View {
        NavigationView {
            //isShowing: viewModel.isLoading
            LoadingView(isShowing: .constant(false)) {
                VStack(alignment: .leading) {
                    self.titleView
                    self.placeHolderTextView
                    self.passwordTextView
                    self.loginButton
                    Spacer()
                    Spacer()
                }.padding(20)
            }
        }

    }

    private func loginUser() {

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

