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
            
        case "√":
            return self.operandStack.removeLast().squareRoot();
            
        case "x²":
            let square:Double = self.operandStack.last! * self.operandStack.last!;
            self.operandStack.removeLast();
            return square;
            
        case "x⁻¹":
            return 1.0 / self.operandStack.removeLast();
            
        case "+/-":
            return self.operandStack.removeLast() * -1;
            
        case "C":
            if(self.operandStack.count < 2){
                self.operandStack.removeAll();
                return 0;
            }else{
                self.operandStack.removeLast();
                let returnME = self.operandStack.last;
                self.operandStack.removeLast();
                return returnME!;
            }
            
        case "AC":
            self.operandStack.removeAll();
            return 0;
            
        default:break
            
        }
    
        return 0.0
        
        
    }
}
