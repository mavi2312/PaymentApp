//
//  ResponseObjects.swift
//  PaymentApp
//
//  Created by Consultor on 1/3/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import Foundation

struct PaymentMethod: Codable {
    let id: String?
    let name: String?
    let secure_thumbnail: String?
}

struct CardIssuer: Codable {
    let id: String?
    let name: String?
    let secure_thumbnail: String?
}

struct InstallmentsResponse: Codable {
    let payer_costs: [Installment]?
}

struct Installment: Codable {
    let recommended_message: String?
}
