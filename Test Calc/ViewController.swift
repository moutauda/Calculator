//
//  ViewController.swift
//  Test Calc
//
//  Created by Developer on 10/10/2017.
//  Copyright © 2017 CGI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var displayedText: UILabel!
    
    var isTapping = false
    
    var currentValue : Double {
        get {
            return Double(displayedText.text!)!
        }
        
        set {
            displayedText.text! = String(newValue)
        }
    }
    
    private var brain = BrainCalculator()
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if (isTapping == true){
            displayedText.text! = displayedText.text! + sender.currentTitle!
        }else{
            displayedText.text! = sender.currentTitle!
            isTapping = true
        }
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        if isTapping {
            brain.setOperand(currentValue)
            isTapping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.makeOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            currentValue = result
        }
    }
}

