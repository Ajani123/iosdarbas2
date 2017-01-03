//
//  SecondViewController.swift
//  BusinessCards
//
//  Created by Ajani on 28/12/2016.
//  Copyright © 2016 Ajani. All rights reserved.
//

import UIKit

class EditViewController1: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
     var textarray = [String]()
   
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView4: UITableView!
    @IBOutlet weak var tableView3: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var NumberField: UITextField!
    @IBOutlet weak var WebAddrField: UITextField!
    @IBOutlet weak var SaveButton: UIButton!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        self.tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        self.tableView3.register(UITableViewCell.self, forCellReuseIdentifier: "cell3")
        self.tableView4.register(UITableViewCell.self, forCellReuseIdentifier: "cell4")
        
        
        tableView1.delegate = self
        tableView1.dataSource = self
        
        tableView2.delegate = self
        tableView2.dataSource = self
        
        tableView3.delegate = self
        tableView3.dataSource = self
        
        tableView4.delegate = self
        tableView4.dataSource = self
        
        NameField.delegate = self
        EmailField.delegate = self
        NumberField.delegate = self
        WebAddrField.delegate = self
        
        tableView1.isHidden = true
        tableView2.isHidden = true

        tableView3.isHidden = true
        tableView4.isHidden = true

        NameField.addTarget(self, action: #selector(nameTextFieldActive), for: UIControlEvents.touchDown)
        EmailField.addTarget(self, action: #selector(emailTextFieldActive), for: UIControlEvents.touchDown)
        NumberField.addTarget(self, action: #selector(numberTextFieldActive), for: UIControlEvents.touchDown)
        WebAddrField.addTarget(self, action: #selector(webAddrTextFieldActive), for: UIControlEvents.touchDown)
    }
    
    @IBAction func onSaveClick(_ sender: Any) {
    }
    @IBAction func onBackClick(_ sender: Any) {
    }

    public func initializeFields(textArray: [String]) {
        self.textarray = textArray
        let arrayCopy = textArray;
        
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

   @IBAction func nameFieldEditingEnd(_ sender: Any) {
        tableView1.isHidden = true
        }
    @IBAction func emailFieldEditingEnd(_ sender: Any) {
        tableView2.isHidden = true
        }
    @IBAction func numberFieldEditingEnd(_ sender: Any) {
        tableView3.isHidden = true
        }
   @IBAction func webAddrEditingEnd(_ sender: Any) {
        tableView4.isHidden = true
        }
    
    // Manage keyboard and tableView visibility
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch:UITouch = touches.first else
        {
            return;
        }
        if touch.view != tableView1
        {
            NameField.endEditing(true)
            tableView1.isHidden = true
        }
        if touch.view != tableView2
        {
            EmailField.endEditing(true)
            tableView2.isHidden = true
        }
        if touch.view != tableView3
        {
            NumberField.endEditing(true)
            tableView3.isHidden = true
        }
        if touch.view != tableView4
        {
            WebAddrField.endEditing(true)
            tableView4.isHidden = true
        }
        
    }
    
    // Toggle the tableView visibility when click on textField
    func nameTextFieldActive() {
        tableView1.isHidden = !tableView1.isHidden
    }
    
    func emailTextFieldActive() {
        tableView2.isHidden = !tableView2.isHidden
    }
    
    func numberTextFieldActive() {
        tableView3.isHidden = !tableView3.isHidden
    }
    
    func webAddrTextFieldActive() {
        tableView4.isHidden = !tableView4.isHidden
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textarray.count;
    }

    func tableView(_ currTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell:UITableViewCell
        
        if (currTableView == tableView1) {
            cell = tableView1.dequeueReusableCell(withIdentifier: "cell1") as UITableViewCell!
        } else if (currTableView == tableView2) {
            cell = tableView2.dequeueReusableCell(withIdentifier: "cell2") as UITableViewCell!
        }else if (currTableView == tableView3) {
            cell = tableView3.dequeueReusableCell(withIdentifier: "cell3") as UITableViewCell!
        } else {
            cell = self.tableView4.dequeueReusableCell(withIdentifier: "cell4") as UITableViewCell!
            }
        
        // Set text from the data model
        cell.textLabel?.text = textarray[indexPath.row]
        cell.textLabel?.font = NameField.font
        return cell
    }
    

    // MARK: UITableViewDelegate
    func tableView(_ currTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
        if (currTableView == tableView1) {
            NameField.text = textarray[indexPath.row]
            tableView1.isHidden = true
            NameField.endEditing(true)
        } else if (currTableView == tableView2) {
            EmailField.text = textarray[indexPath.row]
            tableView2.isHidden = true
            EmailField.endEditing(true)
        }else if (currTableView == tableView3) {
            NumberField.text = textarray[indexPath.row]
            tableView3.isHidden = true
            NumberField.endEditing(true)
        } else {
            WebAddrField.text = textarray[indexPath.row]
            tableView4.isHidden = true
            WebAddrField.endEditing(true)
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

}

