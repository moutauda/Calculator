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
    
    mutating func addUnaryOperation(named symbol: String, _ operation: @escaping (Double) -> Double){
        operations[symbol] = Operation.unaryOperation(operation)
    }
    
    private var temporary : Double?
    
    private enum Operation {
        case unaryOperation((Double) -> Double)
        case binaryOprations((Double, Double) -> Double)
        case value(Double)
        case equals
    }
    
    private var operations : Dictionary<String, Operation> = [
        "π": Operation.value(Double.pi),
        "√": Operation.unaryOperation(sqrt),
        "±" : Operation.unaryOperation({ -$0 }),
        "cos" : Operation.unaryOperation(cos),
        "x" : Operation.binaryOprations({$0 * $1}),
        "+" : Operation.binaryOprations({$0 + $1}),
        "/" : Operation.binaryOprations({$0 / $1}),
        "-" : Operation.binaryOprations({$0 - $1}),
        "=" : Operation.equals
    ]
    
    
    
    mutating func makeOperation (_ symbol : String) {
        if let operation = operations[symbol]{
            switch operation {
            case .value(let value):
                temporary = value
            case .unaryOperation(let function):
                if temporary != nil {
                    temporary = function(temporary!)
                }
            case .binaryOprations(let function):
                if temporary != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: temporary!)
                    temporary = nil
                }
            case .equals:
                performBinaryOperation()
            }
        }
    }
    
    private mutating func performBinaryOperation() {
        if pendingBinaryOperation != nil && temporary != nil {
            temporary = pendingBinaryOperation!.perform(with: temporary!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function : (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
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
