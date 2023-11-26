//
//  CoinRateData.swift
//  ByteCoin
//
//  Created by Andrei Shpartou on 26/11/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinRateData: Codable {
    let rate: Double
    let asset_id_quote: String
}
