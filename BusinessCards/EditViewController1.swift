//
//  SecondViewController.swift
//  BusinessCards
//
//  Created by Ajani on 28/12/2016.
//  Copyright © 2016 Ajani. All rights reserved.
//

import UIKit

class EditViewController1: UIViewController {
   
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var NumberField: UITextField!
    @IBOutlet weak var WebAddrField: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onSaveClick(_ sender: Any) {
    }
    @IBAction func onBackClick(_ sender: Any) {
    }
    
    public func initializeFields(textArray: [String]) {
        
        NameField.text = textArray[0]
        EmailField.text = textArray[1]
        NumberField.text = textArray[2]
        WebAddrField.text = textArray[3]

    }
    

}

