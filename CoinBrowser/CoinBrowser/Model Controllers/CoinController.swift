//
//  CoinController.swift
//  CoinBrowser
//
//  Created by iMac Pro on 2/20/23.
//

import Foundation

class CoinController {
    
    //MARK: - PROPERTIES
    static var coins: [Coin] = []
    
    
    //MARK: - FUNCTIONS
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        guard let baseURL = URL(string: Constants.CoinGecko.baseURL) else { return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.CoinGecko.coinPath)
        
        guard let finalURL = urlComponents?.url else { return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { coinData, response, error in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
                completion(false)
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response Status Code: \(response.statusCode)")
            }
            
            guard let data = coinData else { return }
            do {
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String : Any]] {
                    for coinDictionary in topLevel {
                        guard let parcedCoin = Coin(dictionary: coinDictionary) else { return }
                        coins.append(parcedCoin)
                    }
                    completion(true)
                }
            } catch {
                print("Error in Do/Try/Catch: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }
    
} //: CLASS
