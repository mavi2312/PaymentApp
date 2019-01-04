//
//  RequestObjects.swift
//  PaymentApp
//
//  Created by Consultor on 1/3/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

struct PaymentMethodRequestModel: Codable {
    let public_key: String
}

struct CardIssuerRequestModel: Codable {
    let public_key: String
    let payment_method_id: String
}

struct InstallmentsRequestModel: Codable {
    let public_key: String
    let payment_method_id: String
    let amount: String
    let issuer_id: String
}
