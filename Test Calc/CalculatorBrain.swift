//
//  CalculatorBrain.swift
//  Test Calc
//
//  Created by Developer on 11/10/2017.
//  Copyright © 2017 CGI. All rights reserved.
//

import Foundation

func changeSign(number : Double) -> Double {
    return -number
}

struct BrainCalculator {
    
    private var temporary : Double?
    
    private enum Operation {
        case realOperation((Double) -> Double)
        case value(Double)
    }
    
    private var operations : Dictionary<String, Operation> = [
        "π": Operation.value(Double.pi),
        "√": Operation.realOperation(sqrt),
        "±" : Operation.realOperation({ -$0 }),
        "cos" : Operation.realOperation(cos)
    ]
    

    
    mutating func makeOperation (_ symbol : String) {
        if let operation = operations[symbol]{
            switch operation {
            case .value(let value):
                temporary = value
            case .realOperation(let function):
                if temporary != nil {
                    temporary = function(temporary!)
                }
            }
        }
    }
    
    mutating func setOperand (_ operand : Double) {
        temporary = operand
    }
    
    var result : Double? {
        get {
            return temporary
        }
    }
    
    
}
