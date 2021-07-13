//
//  NetworkManager.swift
//  DEMO-FaceID_SwiftUI
//
//  Created by User on 13.07.2021.
//

import Combine
import Alamofire

class NetworkManager: APIHandler {

    @Published var successResponse: LoginResponse?
    @Published var isLoading = false

    func login(email: String, password: String) {
        isLoading = true

        let url = "http://18.192.5.103:8080/api/tokens/credentials"
        let params : Parameters = ["email" : email, "password" : password, "clientSecret" : "3fa85f64-5717-4562-b3fc-2c963f66afa6"]

        AF.request(url, method: .post, parameters: params).responseDecodable { [weak self] (response: DataResponse<LoginResponse, AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? LoginResponse else {
                weakSelf.isLoading = false
                return
            }

            weakSelf.isLoading = false
            weakSelf.successResponse = response
        }
    }

}
