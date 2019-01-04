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
    
    //let baseUrlImages: String = "https://image.tmdb.org/t/p/w500"
    
    init(){
        
    }
    
    func request<T:Codable>(urlString: PaymentAPIUrl, params: [String:Any], completionHandler:@escaping (T?, ErrorTypes?)-> Void) {
        
        Alamofire.request(baseUrl + urlString.rawValue, method: .get, parameters: params, encoding: URLEncoding.default).responseData { response in
            debugPrint("All Response Info: \(response)")
            
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                let moviesResponse = try? JSONDecoder().decode(T.self, from: data)
                completionHandler(moviesResponse, nil)
            } else {
                completionHandler(nil,ErrorTypes.networkError)
            }
        }
    }
}

public enum PaymentAPIUrl: String{
    case paymentMethods = "payment_methods"
    case cardIssuers = "payment_methods/card_issuers"
    case installments = "payment_methods/installments"
}

enum ErrorTypes: Error{
    case networkError
    case savingError
    case removingError
    case emptyFavoritesError
    case emptyListError
    case genericError
    
    var message: String {
        switch self {
        case .networkError:         return "errors.network.general"
        case .savingError:          return "errors.favorites.save"
        case .removingError:        return "errors.favorites.remove"
        case .genericError:         return "errors.network.movies"
        case .emptyFavoritesError:  return "errors.favorites.empty"
        case .emptyListError:       return "errors.search.noresults"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .networkError:         return "errors.action.reload"
        case .savingError:          return "errors.action.tryagain"
        case .removingError:        return "errors.action.tryagain"
        case .genericError:         return "errors.action.tryagain"
        case .emptyFavoritesError:  return "errors.action.gohome"
        case .emptyListError:       return "errors.action.tryagain"
        }
    }
    
    var image: UIImage?{
        switch self {
        case .networkError:         return UIImage(named: "networkErrorImage")
        case .savingError:          return UIImage(named: "favoriteErrorImage")
        case .removingError:        return UIImage(named: "favoriteErrorImage")
        case .genericError:         return UIImage(named: "errorImage")
        case .emptyFavoritesError:  return UIImage(named: "favoriteErrorImage")
        case .emptyListError:       return UIImage(named: "searchErrorImage")
        }
    }
}
