//
//  UserResponseDModel.swift
//  FoodSocialApp
//
//  Created by Mongy on 14/09/2023.
//

import Foundation

// MARK: - Welcome
struct UserResponseDModel: Codable {
    let id: Int?
    let username, email, firstName, lastName: String?
    let gender: String?
    let image: String?
    let token: String?
}
//
//struct ResponseModel<Base>: Codable where Base: Codable {
//    var data: Base
//
//    init(from decoder: Decoder) throws {
//        let container: KeyedDecodingContainer<ResponseModel<Base>.CodingKeys> = try decoder.container(keyedBy: ResponseModel<Base>.CodingKeys.self)
//        self.data = try container.decode(Base.self, forKey: ResponseModel<Base>.CodingKeys.data)
//    }
//}
