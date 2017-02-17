//
//  ViewController.swift
//  ConvertIt App
//
//  Created by Jake Mnich on 2/1/17.
//  Copyright © 2017 Jake Mnich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var fromUnitsLabel: UILabel!
    @IBOutlet weak var formulaPicker: UIPickerView!
    
    var formulasArray = ["miles to kilometers",
                         "kilometers to miles",
                         "feet to meters",
                         "meters to feet",
                         "yards to meters",
                         "meters to yards"]
    
    var toUnits = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        formulaPicker.dataSource = self
        formulaPicker.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // MARK:- Delegates & DataSources, Required Methods for UIPickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formulasArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formulasArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let unitsArray = formulasArray[row].components(separatedBy: " to ")
        fromUnitsLabel.text = unitsArray[0]
        toUnits = unitsArray[1]
        resultsLabel.text = toUnits
        
    }
    
    
    // MARK:- IBActions
    
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        
        if let miles = Double(userInput.text!) {
            let km = miles * 1.6
            resultsLabel.text = "\(miles) miles = \(km) kilometers"
        } else {
            resultsLabel.text = ""
            
            let alertController = UIAlertController(title: "Entry Error", message: "Please enter a valid number. Not an empty string, no commas, symbols, or non-numeric characters.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    
}
