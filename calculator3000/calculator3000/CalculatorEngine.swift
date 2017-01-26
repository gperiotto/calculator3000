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
    var myPi = M_PI;
    
    func updateStackWithValue(value:Double){
        self.operandStack.append(value);
    }
    
    
    func operate(operation: String) -> Double{
        
        
        switch operation{
           
        //multiplication
        case "×":
            if (operandStack.count >= 2){
                return self.operandStack.removeLast() * self.operandStack.removeLast()
            }
            
        //division
        case "÷":
            
            if (operandStack.count >= 2){
                return self.operandStack.removeFirst() / self.operandStack.removeLast()
            }
            
        //addition
        case "+":
            if (operandStack.count >= 2){
                return self.operandStack.removeLast() + self.operandStack.removeLast()
            }
            
        //subtraction
        case "−":
            if (operandStack.count >= 2){
                return self.operandStack.removeFirst() - self.operandStack.removeLast()
            }
            
        //square root
        case "√":
            return self.operandStack.removeLast().squareRoot();
            
        //number squared
        case "x²":
            let square:Double = self.operandStack.last! * self.operandStack.last!;
            self.operandStack.removeLast();
            return square;
            
        //reciprocal
        case "x⁻¹":
            return 1.0 / self.operandStack.removeLast();
            
        //sign inversion
        case "+/-":
            return self.operandStack.removeLast() * -1;
        
        //log base 10
        case "log₁₀":
            return log10(self.operandStack.removeLast());
            
        //PI
        case "π":
            return ((self.operandStack.removeLast() * myPi) * 100000000).rounded() / 100000000;
            
        //clear last
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
        
        //clear all
        case "AC":
            self.operandStack.removeAll();
            return 0;
            
        case "Sin":
            print("sin");
            return 0;
        case "ArcSin":
            print("arc sin");
            return 0;
        
        default:break
            
        }
    
        return 0.0
        
        
    }
}
