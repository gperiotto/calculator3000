//
//  tapeViewController.swift
//  calculator3000
//
//  Created by Gabriel Periotto on 25/01/2017.
//  Copyright © 2017 Gabriel Periotto. All rights reserved.
//

import UIKit

class tapeViewController: UIViewController {

    @IBOutlet var labelTape: UILabel!
    
    var msg = String();
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTape.text = msg;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
