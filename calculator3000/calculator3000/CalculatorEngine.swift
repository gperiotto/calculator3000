//
//  CalculatorEngine.swift
//  calculator3000
//
//  Created by Gabriel Periotto on 24/01/2017.
//  Copyright © 2017 Gabriel Periotto. All rights reserved.
//

import Foundation
import UIKit

class CalculatorEngine:NSObject{

    var operandStack = Array<Double>();
    
    func updateStackWithValue(value:Double){
        self.operandStack.append(value);
    }
    
    
    func operate(operation: String) -> Double{
        
        switch operation{
            
        case "×":
            if (operandStack.count >= 2){
                return self.operandStack.removeLast() * self.operandStack.removeLast()
            }
        case "÷":
            
            if (operandStack.count >= 2){
                return self.operandStack.removeFirst() / self.operandStack.removeLast()
            }
        case "+":
            if (operandStack.count >= 2){
                return self.operandStack.removeLast() + self.operandStack.removeLast()
            }
        case "−":
            if (operandStack.count >= 2){
                return self.operandStack.removeFirst() - self.operandStack.removeLast()
            }
            
        default:break
            
        }
        return 0.0
    }
}
