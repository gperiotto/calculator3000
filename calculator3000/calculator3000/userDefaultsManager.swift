//
//  userDefaultsManager.swift
//  calculator3000
//
//  Created by Gabriel Periotto on 28/01/2017.
//  Copyright © 2017 Gabriel Periotto. All rights reserved.
//

import Foundation


class userDefaultsManager: NSObject{

    //LOADS user input history from userDefaults
    func loadUserDefaults() -> Array<String>{
        
        let defaults = UserDefaults.standard
        var arrayLoaded = Array<String>();
        
        arrayLoaded = defaults.stringArray(forKey: "savedArray") ?? [String]()
        
        return arrayLoaded;
        //secondScreen = x;
        //print("loaded secondScreen: \(secondScreen)");
        
    }

    
    //SAVES user input to userDefaults
    func saveUserDefaults(currentArray : Array<String>){
        
        let array = currentArray;
        UserDefaults.standard.set(array, forKey: "savedArray")
        print("Saved: \(array)")
        
    }
    
    //Wipes saved data
    func wipeUserDefaults() -> Bool {
        
        let emptyArray  = Array<String>();
        UserDefaults.standard.set(emptyArray, forKey: "savedArray")
        return true;
    }
    
    
}
