//
//  LoginResponse.swift
//  DEMO-FaceID_SwiftUI
//
//  Created by User on 13.07.2021.
//

struct LoginResponse: Decodable {

    var accessToken: String?
    var userId: String
    var clientSecret: String
    var createdAt: String
    var expiredAt: String

    enum CodingKeys: String, CodingKey {
        case accessToken, userId, clientSecret, createdAt, expiredAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        accessToken = try container.decode(String.self, forKey: .accessToken)
        userId = try container.decode(String.self, forKey: .userId)
        clientSecret = try container.decode(String.self, forKey: .clientSecret)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        expiredAt = try container.decode(String.self, forKey: .expiredAt)
    }
}
