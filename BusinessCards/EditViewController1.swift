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
        var arrayCopy = textArray;
        
        
            for j in 0...arrayCopy.count-1{
                
                if (textArray[j].components(separatedBy:" ").count==2){
                    NameField.text = textArray[j]
                }
                if (isValidEmail(testStr: textArray[j])){
                    EmailField.text = textArray[j]
                }
                if (validate(value: textArray[j])){
                    NumberField.text = textArray[j]
                }
                if (verifyUrl(urlString: textArray[j])){
                    WebAddrField.text = textArray[j]
                }
            }


    }
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    func isValidEmail(testStr:String) -> Bool {
    print("validate emilId: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: testStr)
    return result
    }
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }


}

