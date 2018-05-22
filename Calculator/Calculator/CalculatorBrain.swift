//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Robert Rochford on 12/27/17.
//  Copyright © 2017 Robert Rochford. All rights reserved.
//

import Foundation

func changeSign(operand: Double) -> Double {
    return -operand
}

// moved this to an inline function in the operations dictionary 
func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

struct  CalculatorBrain {
    
    
    // optional because we haven't set it upon launch
    private var accumulator: Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> =
        [
            "π" : Operation.constant(Double.pi),
            "e" : Operation.constant(M_E),
            "√" :  Operation.unaryOperation(sqrt),
            "cos" : Operation.unaryOperation(cos),
            "±" : Operation.unaryOperation(changeSign),
            "x" : Operation.binaryOperation({ $0 * $1 }),
            "÷" : Operation.binaryOperation({ $0 / $1 }),
            "+" : Operation.binaryOperation({ $0 + $1 }),
            "-" : Operation.binaryOperation({ $0 - $1 }),
            "=" : Operation.equals,
            ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation =  operations[symbol]{
            switch operation{
            case .constant(let value):
                accumulator = value
                break
            case .unaryOperation (let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
                break
            }
            //accumulator = constant
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
        
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    //        switch symbol {
    //        case "π":
    //            accumulator = Double.pi
    //        case "√":
    //            if let operand = accumulator{
    //                accumulator = sqrt(operand)
    //            }
    //
    //        default:
    //            break
    //        }
    
    
    
    mutating func setOperand (_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get{
            return accumulator
        }
    }
    
    
}
