//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrancyRate(_ coinManager: CoinManager, with coinModel: CoinModel)
    func didFailWithError(_ coinManager: CoinManager, _ error: Error)
}

struct CoinManager {
        
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "CEC10593-95DC-4DAC-8B2B-7A0E7A73388E"
    var delegate: CoinManagerDelegate?
    
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
                    delegate?.didFailWithError(self, error!)
                }
                
                if let safeData = data {
                    if let coinModel = parseJSON(safeData) {
                        delegate?.didUpdateCurrancyRate(self, with: coinModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinRateData.self, from: coinData)
            let rate = decodedData.rate
            let asset_id_quote = decodedData.asset_id_quote
            let coinModel = CoinModel(rate: rate, currency: asset_id_quote)
            return coinModel
        } catch {
            delegate?.didFailWithError(self, error)
            return nil
        }
    }
    
}
