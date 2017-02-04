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
        
        if (self.calcEngine == nil) {
            self.calcEngine = CalculatorEngine();
        }
        
        if(self.dataStore == nil){
            self.dataStore = userDefaultsManager();
        }
        
        secondScreen = (self.dataStore?.loadUserDefaults())!;
    }

    //interface builder
    @IBOutlet weak var labelSecondScreenDisplay: UILabel!
    @IBOutlet weak var labelDisplay: UILabel!
    @IBOutlet weak var decimalPointOutlet: UIButton!
    @IBOutlet weak var tanBtnOutlet: UIButton!
    @IBOutlet weak var cosBtnOutlet: UIButton!
    @IBOutlet weak var sinBtnOutlet: UIButton!
    
   
   
    var secondScreen = Array<String>();
    var calcEngine : CalculatorEngine?
    var dataStore : userDefaultsManager?
    var userTyped:Bool = false;
    var decimalPointButtonPressed:Bool = false;
    
    
    //onClick Listener
    @IBAction func digitPressed(_ sender: UIButton) {
        
        let digit = sender.currentTitle!;
        //print("digit pressed was = \(digit)");
        
        if(userTyped){
            labelDisplay.text = labelDisplay.text! + "\(digit)";
        }else{
            labelDisplay.text = digit;
            userTyped = true;
        }
    }
    
    //secondScreen and userDefaults recoder and labelSecondScreenDisplay populator - user inputs
    @IBAction func secondScreenPopulator(_ sender: UIButton) {
        
        let btnPressed = sender.currentTitle!;
        
        // stops DEL btn from being pressed unnecessarily
        if((btnPressed == "DEL" || btnPressed == "↵") && labelDisplay.text == "0"){
            return;
        }
        
        secondScreen.append(btnPressed + " ");
        
        if(btnPressed == "+" || btnPressed == "-" || btnPressed == "×" || btnPressed == "÷" || btnPressed == "√" || btnPressed == "x²" || btnPressed == "x⁻¹" || btnPressed == "log₁₀" || btnPressed == "logₑ" || btnPressed == "π"){
            secondScreen.append(" = " + labelDisplay.text!);
            secondScreen.append("\n");
        }
        else if(btnPressed == "Sin" || btnPressed == "Sin⁻¹" || btnPressed == "Cos" || btnPressed == "Cos⁻¹" || btnPressed == "Tan" || btnPressed == "Tan⁻¹"){
            if(self.calcEngine?.degRadState == 0){
                secondScreen.append(" = (Rad)" + labelDisplay.text!);
                secondScreen.append("\n");
            }else{
                secondScreen.append(" = (Deg)" + labelDisplay.text!);
                secondScreen.append("\n");
            }
        }else if(btnPressed == "DEL"){
            deleteEnteredDigit();
        }
        
        
        //Passes secondScreen:Array<String> values to join:String
        var join:String = "";
        for i in secondScreen{
            join = join + "\(i)";
        }
        
        //This function saves input history to userDefaults
        dataStore?.saveUserDefaults(currentArray: secondScreen);
        
        
        //Splits join:String back to arraySplit the sorts array by last 3(plus \n) values and stores it into arrayLast3Items
        let arraySplit = join.components(separatedBy: "\n");
        let arrayLast3Items = arraySplit.suffix(4);
        
        
        //Sets labelSecondScreenDisplay new value
        var printMe:String = "";
        for i in arrayLast3Items{
            printMe.append(i + "\n");
        }
        labelSecondScreenDisplay.text = "\(printMe) " ;
        
        
        //Appends calcEngine.operandStack after labelSecondSreenDisplay new value
        printMe = "";
        for i in (calcEngine?.operandStack)!{
            printMe.append("\(i) ");
        }
        labelSecondScreenDisplay.text = labelSecondScreenDisplay.text! + "[\(printMe)]";
        
        
    }
    
    
    
    //displayValue Getter and Setter from labelDisplay
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
        
        if(labelDisplay.text == "0" || labelDisplay.text == "0.0" || labelDisplay.text == ".0"){
            print("nothing to add");
            return;
        }
        
        //error message handler
        if(labelDisplayErrorFix()){
            return;
        }

        userTyped = false;
        
        //Ensures if operandStack[0] is 0.0 to replace this value, else append new value
        if(checkOperandStackDefaultValues()){
            self.calcEngine!.operandStack[0] = (NumberFormatter().number(from: labelDisplay.text!)?.doubleValue)!
           
        }else{
            self.calcEngine!.operandStack.append(displayValue);
      
        }
        
        decimalPointButtonPressed = false;
        print("Operand stack on engine =\(self.calcEngine!.operandStack)");
    }
    
    
    // Resets labelDisplay to 0 if contains "ERROR" message - returns boolean
    func labelDisplayErrorFix() -> Bool{
        
        if(labelDisplay.text == "ERROR"){
            labelDisplay.text = "0";
            print("error gone")
            return true;
        }
        
        return false;
        
    }
    
    
    // DEL KEY - onClick action
    func deleteEnteredDigit() {
        
        
        
        if(labelDisplayErrorFix()){
            return;
        }
        
        let delDigit: String = labelDisplay.text!;
        let endIndex = delDigit.index(delDigit.endIndex, offsetBy: -1);
        let truncated = delDigit.substring(to: endIndex);
        labelDisplay.text = truncated;
        
        if(labelDisplay.text == ""){
            labelDisplay.text = "0";
        }
        
    }

    
    //DECIMAL POINT KEY - onClick Action
    @IBAction func decimalPointClicked(_ sender: UIButton) {

        if(userTyped == false && checkOperandStackDefaultValues()){
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
    

    
    // SinCosTan SegmentedControl - onClick State Listener
    @IBAction func SinCosTan_Arc_SegmentedControl(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0){
            sinBtnOutlet.setTitle("Sin", for: .normal);
            cosBtnOutlet.setTitle("Cos", for: .normal);
            tanBtnOutlet.setTitle("Tan", for: .normal);
        }else{
            sinBtnOutlet.setTitle("Sin⁻¹", for: .normal);
            cosBtnOutlet.setTitle("Cos⁻¹", for: .normal);
            tanBtnOutlet.setTitle("Tan⁻¹", for: .normal);
        }
    }
    
    // RadianDegree SWITCH - State listener
    @IBAction func degRadSwitch(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0){
            self.calcEngine?.degRadState = 0;
        }else{
            self.calcEngine?.degRadState = 1;
        }
    }
    
    
    //Check if OPERANDSTACK has default val of 0.0
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
        
        if (preOperationChecker(op:operation)){
            
            self.displayValue = (self.calcEngine?.operate(operation: operation))!;
            enter();
        }else{
            self.labelDisplay.text = "ERROR";
        }
        
        
    }
    
    //Operation error handling
    func preOperationChecker (op:String)-> Bool{
        let lastStack = self.calcEngine?.operandStack.last;
    
        if(lastStack == nil){
            return false;
        }
        else if((op == "x⁻¹" || op == "logₑ" || op == "log₁₀" || op == "÷") && lastStack == 0){
            return false;
        }
        else if(( op == "logₑ" || op == "log₁₀" || op == "√") && lastStack! < Double(0)){
            return false;
        }
        else if( op == "Cos⁻¹" || op == "Sin⁻¹"){
            if(lastStack! > 1 ){
                return false;
            }
            else if(lastStack! < -1){
                return false;
            }
        }
        
        return true;
    }
    
    
    //Data Passing between windows
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC: tapeViewController = segue.destination as! tapeViewController;
        
        //Array<String>
        let calcHistory = secondScreen;
    
        newVC.msg = calcHistory;
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
 
