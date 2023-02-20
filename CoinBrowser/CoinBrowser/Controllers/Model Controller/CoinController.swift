//
//  CoinController.swift
//  CoinBrowser
//
//  Created by Karl Pfister on 11/23/21.
//

import Foundation

class CoinController {
    
    static var coins: [Coin] = []
    
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        
        guard let baseURL = URL(string: Keys.baseURLString) else {
            completion(false)
            return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Keys.coinsComponent)
        urlComponents?.path.append(Keys.listComponent)

        guard let finalURL = urlComponents?.url else {return}
        
        print("The final URL is", finalURL)
        
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
                        if let parsedCoin = Coin(dictionary: coinDictionary) {
                            self.coins.append(parsedCoin)
                        }
                    }
                }
                completion(true)
            } catch {
                print("Error in Do/Try/Catch: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }
} // End of Class
