//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

}

// MARK: - VC extension. Adopt UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.coinManager.currencyArray.count
    }
}

// MARK: - VC extension. Adopt UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = self.coinManager.currencyArray[row]
        self.coinManager.getCoinPrice(for: selectedCurrency)
    }
}

// MARK: - VC extension. Adopt CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateCurrancyRate(_ coinManager: CoinManager, with coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.bitCoinLabel.text = coinModel.rateString
            self.currencyLabel.text = coinModel.currency
        }
    }
    
    func didFailWithError(_ coinManager: CoinManager, _ error: Error) {
        print(error)
    }
}
