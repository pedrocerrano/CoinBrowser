//
//  CoinController.swift
//  CoinBrowser
//
//  Created by Karl Pfister on 11/23/21.
//

import Foundation

class CoinController {
    
    static let baseURLString = "https://api.coingecko.com/api/v3"
    static let kCoins = "coins"
    static let kList = "list"
    static var coins: [Coin] = []
    
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else {
            completion(false)
            return}
        
        let coinsURL = baseURL.appendingPathComponent(kCoins)
        let coinsListURL = coinsURL.appendingPathComponent(kList)

        URLSession.shared.dataTask(with: coinsListURL) { data, _, error in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
                completion(false)
            }
            
            guard let data = data else {
                completion(false)
                return
            }
            
            do {
                if let coinJSONList = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : String]] {
                    for coinJSON in coinJSONList {
                        if let id = coinJSON["id"],
                           let symbol = coinJSON["symbol"],
                           let name = coinJSON["name"] {
                            let parsedCoin = Coin(id: id, symbol: symbol, name: name)
                            self.coins.append(parsedCoin)
                        }
                    }
                    completion(true)
                }
                
            } catch {
                print("Error in Do/Try/Catch: \(error.localizedDescription)")
            }
        }.resume()
    }
} // End of Class
