//
//  Coin.swift
//  CoinBrowser
//
//  Created by Karl Pfister on 11/23/21.
//

import Foundation

class Coin {
    let id: String
    let symbol: String
    let name: String
    
    init(id: String, symbol: String, name: String) {
        self.id = id
        self.symbol = symbol
        self.name = name
    }
}
