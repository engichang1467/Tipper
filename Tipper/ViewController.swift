//
//  ViewController.swift
//  Tipper
//
//  Created by Michael Chang on 2020-05-06.
//  Copyright © 2020 Michael Chang. All rights reserved.
//

import UIKit

// prototype - an agreement with ur class u have here that you are going to implement certain method here in ur class

// UITextFieldDelegate - prevent user from implementing the wrong datatype (in this case decimal only)

class ViewController: UIViewController, UITextFieldDelegate {
    // drag and drop input UI with control into here
    @IBOutlet weak var totalBillTextField: UITextField!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var tipSplitTextField: UITextField!
    @IBOutlet weak var totalSplitTextField: UITextField!
    
    // total bill - convert string to double
    var totalBill: Double? {
        return Double(totalBillTextField.text!)
    }
    
    var tipPercentage: Double = 0.15  // tip percentage
    var numberOfPeople: Double = 1.0  // Number of people
    private var formatter: NumberFormatter! // only input decimal format
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss the keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        // monitor and varify the info entered in total bill
        totalBillTextField.delegate = self
        
        // init our formatter
        formatter = NumberFormatter()
        // define the numebr must conform to a decimal format
        formatter.numberStyle = NumberFormatter.Style.decimal
        // Set the minimal value is zero
        formatter.minimum = 0
        
    }

    // Drag and drop splider here
    // Desc: update the value on the slider when it is changed
    @IBAction func tipSliderChange(_ sender: UISlider)
    {
        let sliderValue = Int(sender.value)              // Get value from slider
        tipPercentLabel.text = "\(sliderValue)%"         // Update the number
        tipPercentage = Double(Int(sender.value)) * 0.01 // Change value of the tip percentage
        updateInterface()                                // Change interface
    }
    
    // Desc: Update the value on the split stepper when it is changed
    @IBAction func splitStepperChanged(_ sender: UIStepper)
    {
        let stepperValue = Int(sender.value)
        splitLabel.text = "\(stepperValue)"
        numberOfPeople = Double(stepperValue)
        updateInterface()
    }
    
    // Desc: Update the value on the total bill text field when it is changed
    @IBAction func totalBillTextFieldChanged(_ sender: UITextField)
    {
        updateInterface()
    }
    
    // Desc: dismiss the keyboard
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        totalBillTextField.resignFirstResponder()
    }
    
    // Desc: update my whole interface
    func updateInterface()
    {
        if let totalBill = self.totalBill {
            tipTextField.text = String(format: "$%.2f", (totalBill * tipPercentage))
            totalTextField.text = String(format: "$%.2f", (totalBill * tipPercentage) + totalBill)
            tipSplitTextField.text = String(format: "$%.2f", (totalBill * tipPercentage) / numberOfPeople)
            totalSplitTextField.text = String(format: "$%.2f", ((totalBill * tipPercentage) + totalBill) / numberOfPeople)
        }
    }
    
    // Desc: handle the textfield and make sure it show decimals
    func textField(_ textField: UITextField, shouldChangeCharactersInRange: NSRange, string: String) -> Bool {
        return formatter.number(from: "\(textField.text ?? "0.00")\(string)") != nil
    }
}

