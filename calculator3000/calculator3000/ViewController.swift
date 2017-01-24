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
    
    var calcEngine : CalculatorEngine?
    var userTyped:Bool = false;
    
    
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
    
    
    
    
    @IBAction func enter() {
        
        userTyped = false;
        
        //self.calcEngine!.operandStack.append("\(displayValue)";//1:27
        
    }
    
    
    
    
    
    @IBAction func operation(_ sender: UIButton) {
        
        let operation = sender.currentTitle!;
        
        var displayValue : Double {
        
            
            get{
                return (NumberFormatter().number(from: labelDisplay.text!)?.doubleValue)!
            }
            set(newValue){
                labelDisplay.text = "\(newValue)";
            }
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
 
