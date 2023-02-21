//
//  Coin.swift
//  CoinBrowser
//
//  Created by iMac Pro on 2/20/23.
//

import Foundation

class Coin {
    
    let id: String
    let symbol: String
    let name: String
    
    enum Keys: String {
        case id
        case symbol
        case name
    }
    
    init?(dictionary: [String : Any]) {
        guard let id = dictionary[Keys.id.rawValue] as? String,
              let symbol = dictionary[Keys.symbol.rawValue] as? String,
              let name = dictionary[Keys.name.rawValue] as? String else { return nil }
        
        self.id = id
        self.symbol = symbol
        self.name = name
    }
    
} //: CLASS
