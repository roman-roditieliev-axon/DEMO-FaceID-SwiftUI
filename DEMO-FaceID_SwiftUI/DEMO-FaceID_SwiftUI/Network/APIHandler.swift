//
//  APIHandler.swift
//  DEMO-FaceID_SwiftUI
//
//  Created by User on 13.07.2021.
//

import Alamofire
import Combine

class APIHandler {

    var statusCode = Int.zero

    func handleResponse<T: Decodable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            return response.value
        case .failure:
            return nil
        }
    }
}
