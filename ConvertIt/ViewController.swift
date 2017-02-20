//
//  ViewController.swift
//  ConvertIt App
//
//  Created by Jake Mnich on 2/1/17.
//  Copyright © 2017 Jake Mnich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var fromUnitsLabel: UILabel!
    @IBOutlet weak var formulaPicker: UIPickerView!
    @IBOutlet weak var decimalSegment: UISegmentedControl!
    @IBOutlet weak var posNeg: UISegmentedControl!
    
    
    var formulasArray = ["miles to kilometers",
                         "kilometers to miles",
                         "feet to meters",
                         "meters to feet",
                         "yards to meters",
                         "meters to yards",
                         "inches to centimeters",
                         "centimeters to inches",
                         "fahrenheit to celcius",
                         "celcius to fahrenheit",
                         "quarts to liters",
                         "liters to quarts"]
    
    var toUnits = ""
    var fromUnits = ""
    var conversionString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        formulaPicker.dataSource = self
        formulaPicker.delegate = self
        userInput.delegate = self
        
        conversionString = formulasArray[0]
        
        userInput.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Entry Error", message: "Please enter a valid number. Not an empty string, no commas, symbols, or non-numeric characters.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func calculateConversion() {
        
        var inputValue = 0.0
        var outputValue = 0.0
        var outputString = ""
        
        if let inputValue = Double(userInput.text!) {
            
            switch conversionString {
            case "miles to kilometers":
                outputValue = inputValue / 0.62137
            case "kilometers to miles":
                outputValue = inputValue * 0.62137
            case "feet to meters":
                outputValue = inputValue / 3.2808
            case "meters to feet":
                outputValue = inputValue * 3.2808
            case "yards to meters":
                outputValue = inputValue / 1.0936
            case "meters to yards":
                outputValue = inputValue * 1.0936
            case "inches to centimeters":
                outputValue = inputValue / 0.39370
            case "centimeters to inches":
                outputValue = inputValue * 0.39370
            case "fahrenheit to celcius":
                outputValue = (inputValue - 32) * (5/9)
            case "celcius to fahrenheit":
                outputValue = (inputValue * (9/5)) + 32
            case "quarts to liters":
                outputValue = inputValue / 1.05669
            case "liters to quarts":
                outputValue = inputValue * 1.05669
            default:
                showAlert()
            }
            
        } else {
                showAlert()
            }
        
        if decimalSegment.selectedSegmentIndex < 3 {
             outputString = String(format: "%." + String(decimalSegment.selectedSegmentIndex + 1) + "f", outputValue)
        } else {
            outputString = String(outputValue)
        }
        
        resultsLabel.text = "\(userInput.text!) \(fromUnits) = \(outputString) \(toUnits)"
        
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
        
      
        
        conversionString = formulasArray[row]
        let unitsArray = formulasArray[row].components(separatedBy: " to ")
        
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        fromUnitsLabel.text = fromUnits
        // resultsLabel.text = toUnits
        
    }
    
    
    // MARK:- IBActions
    
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
            
            calculateConversion()
        
        }
    
    @IBAction func decimalSelected(_ sender: UISegmentedControl) {
        calculateConversion()
        
    }
    
    @IBAction func posNegPressed(_ sender: UISegmentedControl) {
    }
    
    
    
}
