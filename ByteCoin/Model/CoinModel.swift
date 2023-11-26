//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Andrei Shpartou on 26/11/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rate: Double
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
