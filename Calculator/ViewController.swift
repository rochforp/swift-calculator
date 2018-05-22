//
//  ViewController.swift
//  Calculator
//
//  Created by Robert Rochford on 12/27/17.
//  Copyright © 2017 Robert Rochford. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var UserIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if UserIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            UserIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if UserIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            UserIsInTheMiddleOfTyping = false
        }
        UserIsInTheMiddleOfTyping = false
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(mathmaticalSymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
    }
    
}

