//
//  NetworkManager.swift
//  PaymentApp
//
//  Created by Consultor on 1/3/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import Foundation
import Alamofire

public class NetworkAPIManager {
    
    let baseUrl: String = "https://api.mercadopago.com/v1/"
    
    let publicKey: String = "444a9ef5-8a6b-429f-abdf-587639155d88"
    
    init(){
        
    }
    
    func request<T:Codable>(urlString: PaymentAPIUrl, params: [String:Any], completionHandler:@escaping (T?, ErrorTypes?)-> Void) {
        
        Alamofire.request(baseUrl + urlString.rawValue, method: .get, parameters: params, encoding: URLEncoding.default).responseData { response in
            debugPrint("All Response Info: \(response)")
            
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                let listResponse = try? JSONDecoder().decode(T.self, from: data)
                completionHandler(listResponse, nil)
            } else {
                completionHandler(nil, ErrorTypes.networkError)
            }
        }
    }
}

public enum PaymentAPIUrl: String{
    case paymentMethods = "payment_methods"
    case cardIssuers = "payment_methods/card_issuers"
    case installments = "payment_methods/installments"
}

public enum ErrorTypes: Error{
    case networkError
    case emptyListError
    case genericError
    case emptyAmountError
    case invalidAmountError
    case unselectedMethodError
    case unselectedIssuerError
    case unselectedInstallmentsError
    
    var message: String {
        switch self {
        case .networkError:                 return "errors.network.general"
        case .genericError:                 return "errors.general"
        case .emptyListError:               return "errors.noresults"
        case .emptyAmountError:             return "errors.validation.emptyAmount"
        case .invalidAmountError:           return "errors.validation.invalidAmount"
        case .unselectedMethodError:        return "errors.validation.unselectedMethod"
        case .unselectedIssuerError:        return "errors.validation.unselectedIssuer"
        case .unselectedInstallmentsError:  return "errors.validation.unselectedInstallments"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .networkError:                 return "errors.action.reload"
        case .genericError:                 return "errors.action.tryagain"
        case .emptyListError:               return "errors.action.tryagain"
        case .emptyAmountError:             return "errors.action.tryagain"
        case .invalidAmountError:           return "errors.action.tryagain"
        case .unselectedMethodError:        return "errors.action.tryagain"
        case .unselectedIssuerError:        return "errors.action.tryagain"
        case .unselectedInstallmentsError:  return "errors.action.tryagain"
        }
    }
    
    var image: UIImage?{
        switch self {
        case .networkError:                 return UIImage(named: "networkErrorImage")
        case .genericError:                 return UIImage(named: "errorImage")
        case .emptyListError:               return UIImage(named: "searchErrorImage")
        case .emptyAmountError:             return UIImage(named: "errorImage")
        case .invalidAmountError:           return UIImage(named: "errorImage")
        case .unselectedMethodError:        return UIImage(named: "errorImage")
        case .unselectedIssuerError:        return UIImage(named: "errorImage")
        case .unselectedInstallmentsError:  return UIImage(named: "errorImage")
        }
    }
}
