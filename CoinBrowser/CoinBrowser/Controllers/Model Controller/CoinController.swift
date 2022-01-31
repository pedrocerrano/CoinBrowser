//
//  CoinController.swift
//  CoinBrowser
//
//  Created by Karl Pfister on 11/23/21.
//

import Foundation

class CoinController {
    
    private static let baseURLString = "https://api.coingecko.com/api/v3"
    private static let kCoins = "coins"
    private static let kList = "list"
    
    static var coins: [Coin] = []
    
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else {
            completion(false)
            return}
        
        let coinsURL = baseURL.appendingPathComponent(kCoins)
        let finalURL = coinsURL.appendingPathComponent(kList)
        
    
        URLSession.shared.dataTask(with: finalURL) { coinData, _, error in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
                completion(false)
            }
            
            guard let data = coinData else {
                completion(false)
                return
            }
            
            do {
                if let topLevelArrayOfCoinDictionaries = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String : String]] {
                    for coinDictionary in topLevelArrayOfCoinDictionaries {
                        if let id = coinDictionary["id"],
                           let symbol = coinDictionary["symbol"],
                           let name = coinDictionary["name"] {
                            let parsedCoin = Coin(id: id, symbol: symbol, name: name)
                            self.coins.append(parsedCoin)
                        }
                    }
                    completion(true)
                }
                
            } catch {
                print("Error in Do/Try/Catch: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }
} // End of Class
