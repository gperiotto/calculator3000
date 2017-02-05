//
//  tapeViewController.swift
//  calculator3000
//
//  Created by Gabriel Periotto on 25/01/2017.
//  Copyright © 2017 Gabriel Periotto. All rights reserved.
//

import UIKit

class tapeViewController: UIViewController{

    @IBOutlet weak var textViewTape: UITextView!
    @IBOutlet weak var swipeToMainView: UILabel!
    
    let uiAlertTitle = "Clear saved data?"
    let uiAlertMessage = "This will clear all previously saved data";
    var savedDataToRestore = Array<String>();
    var dataStore : userDefaultsManager?;

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.dataStore == nil){
            self.dataStore = userDefaultsManager();
        }
        
        savedDataToRestore = (self.dataStore?.loadUserDefaults())!;
        
        populateTextView();
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(tapeViewController.swipeToGoBack(sender:)));
        leftSwipe.direction = .left;
        swipeToMainView.addGestureRecognizer(leftSwipe);
        
    }
    
   
    //lanches tapeViewController on tapeSwipeLabel swipe right
    func swipeToGoBack(sender:UISwipeGestureRecognizer) {
        
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "mainView") as! ViewController;
        present(controller, animated: true, completion: nil);
        
    }
    
    
    //Clear saved data button - Launches UIAlert
    @IBAction func clearSavedData(_ sender: UIButton) {
        
        let alert = UIAlertController(title: uiAlertTitle, message: uiAlertMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
            
            if(self.dataStore?.wipeUserDefaults())!{
                self.textViewTape.text = "..."
            }
            print("userDefaults cleared");
            
        }));
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil));
        
        // display alert
        self.present(alert, animated: true, completion: nil);
        
    }

    
    func populateTextView (){
        
        let stringSplitter = savedDataToRestore;
        var printMe = "";
        for i in stringSplitter{
            printMe.append("\(i)");
        }
        
        textViewTape.text = printMe;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
