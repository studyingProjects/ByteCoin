//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "CEC10593-95DC-4DAC-8B2B-7A0E7A73388E"
    //"https://rest.coinapi.io/v1/exchangerate/BTC/USD?ApiKey=CEC10593-95DC-4DAC-8B2B-7A0E7A73388E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?ApiKey=CEC10593-95DC-4DAC-8B2B-7A0E7A73388E"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    //
                }
                
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8))
                }
            }
            task.resume()
        }
    }
    
}
