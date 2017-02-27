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
    var degRadState = 0;
    
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
                
                let devide2 = self.operandStack.removeLast();
                let devide1 = self.operandStack.removeLast();
                
                return devide1 / devide2;
            }
            
        //addition
        case "+":
            if (operandStack.count >= 2){
                let add2 = self.operandStack.removeLast();
                let add1 = self.operandStack.removeLast();
                
                return add1 + add2;
                
            }
            
        //subtraction
        case "-":
            if (operandStack.count >= 2){
                
                let subtract2 = self.operandStack.removeLast();
                let subtract1 = self.operandStack.removeLast();
                
                return subtract1 - subtract2;

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
            return (1.0 / self.operandStack.removeLast());
            
        //sign inversion
        case "+/-":
            return self.operandStack.removeLast() * -1;
        
        //log base 10
        case "log₁₀":
            return (log10(self.operandStack.removeLast()));
        
        //Log Base e
        case "logₑ":
            return (log(self.operandStack.removeLast()));
            
        //PI- NOT IN USE
        case "π":
            //return (myPi * 100000000).rounded() / 100000000;
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
            return trigonometryCalculator(state: "sin");
            
        case "Sin⁻¹":
            return trigonometryCalculator(state: "asin");
            
        case "Cos":
            return trigonometryCalculator(state: "cos");
            
        case "Cos⁻¹":
            return trigonometryCalculator(state: "acos");
            
        case "Tan":
            return trigonometryCalculator(state: "tan");
            
        case "Tan⁻¹":
            return trigonometryCalculator(state: "atan");
        
            
            
        default:break
            
        }
    
        return 0.0
        
        
    }
    
    func trigonometryCalculator (state:String) -> Double{
        
        var result: Double = 0;
        
        
        if(degRadState==1){
            
            if(state == "sin"){
                result = sin(self.operandStack.removeLast() * myPi / 180);
            }else if(state == "asin"){
                result = asin(self.operandStack.removeLast()) * (180 / myPi);
            }
            
            if (state == "cos"){
                result = cos(self.operandStack.removeLast() * myPi / 180);
            }else if(state == "acos"){
                result = acos(self.operandStack.removeLast()) * (180 / myPi);
            }
            
            if (state == "tan"){
                result = tan(self.operandStack.removeLast() * myPi / 180);
            }else if(state == "atan"){
                result = atan(self.operandStack.removeLast()) * (180 / myPi);
            }
            
        }else{
            
            if(state == "sin"){
                result = sin(self.operandStack.removeLast());
            }else if(state == "asin"){
                result = asin(self.operandStack.removeLast());
            }
            
            if (state == "cos"){
                result = cos(self.operandStack.removeLast());
            }else if(state == "acos"){
                result = acos(self.operandStack.removeLast());
            }
            
            if (state == "tan"){
                result = tan(self.operandStack.removeLast());
            }else if(state == "atan"){
                result = atan(self.operandStack.removeLast());
            }
            
        }
        
        
        //return (result * 100000000).rounded() / 100000000;
        return result;
    }
    
    
    
}
