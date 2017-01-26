//
//  ViewController.swift
//  calculator3000
//
//  Created by Gabriel Periotto on 24/01/2017.
//  Copyright © 2017 Gabriel Periotto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (self.calcEngine == nil) {
            
            self.calcEngine = CalculatorEngine();
        }
    }

    //interface builder
    @IBOutlet weak var labelDisplay: UILabel!
    @IBOutlet weak var decimalPointOutlet: UIButton!
    
    var calcEngine : CalculatorEngine?
    var userTyped:Bool = false;
    var decimalPointButtonPressed:Bool = false;
    
    
    //onClick Listener
    @IBAction func digitPressed(_ sender: UIButton) {
        
        let digit = sender.currentTitle!;
        print("digit pressed was = \(digit)");
        
        if(userTyped){
            labelDisplay.text = labelDisplay.text! + "\(digit)";
        }else{
            labelDisplay.text = digit;
            userTyped = true;
        }
    }
    
    
    var displayValue : Double {
        get{
            return (NumberFormatter().number(from: labelDisplay.text!)?.doubleValue)!
        }
        set(newValue){
            labelDisplay.text = "\(newValue)";
        }
    }
    
    // ENTER KEY - onClick action
    @IBAction func enter() {
        
        userTyped = false;
        
        //Ensures if operandStack[0] is 0.0 to replace this value, else append new value
        if(checkOperandStackDefaultValues()){
            self.calcEngine!.operandStack[0] = (NumberFormatter().number(from: labelDisplay.text!)?.doubleValue)!
            print("replacing operandStack[0]")
        }else{
            self.calcEngine!.operandStack.append(displayValue);
        print("appending to operandStack")
        }
        
        decimalPointButtonPressed = false;
        decimalPointOutlet.isEnabled = true;
        print("Operand stack on engine =\(self.calcEngine!.operandStack)");
    }
    
    
    
    //DECIMAL POINT KEY - onClick Action
    @IBAction func decimalPointClicked(_ sender: UIButton) {

        if(checkOperandStackDefaultValues()){
            labelDisplay.text = "0.";
            userTyped = true;
        }else{
            if(userTyped && (labelDisplay.text?.range(of: ".")) == nil ){
                labelDisplay.text = labelDisplay.text! + ".";
            }else if(!userTyped && (labelDisplay.text?.range(of: ".")) == nil ){
                labelDisplay.text = "0.";
                userTyped = true;
            }
        }
        
    }
    
    
    func checkOperandStackDefaultValues() -> Bool{
        if(self.calcEngine!.operandStack.first == 0.0 && self.calcEngine!.operandStack.count == 1){
            return true;
        }else{
            return false;
        }
    }
    
    
    @IBAction func operation(_ sender: UIButton) {
        
        let operation = sender.currentTitle!;
        
        if(userTyped){
            enter();
        }
        
        self.displayValue = (self.calcEngine?.operate(operation: operation))!;
        
        enter();
    }
    
    
    
    //Data Passing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC: tapeViewController = segue.destination as! tapeViewController;
        let calcHistory = labelDisplay.text;
    
        newVC.msg = calcHistory!;
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
 
