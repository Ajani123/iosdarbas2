//
//  FirstViewController.swift
//  BusinessCards
//
//  Created by Ajani on 28/12/2016.
//  Copyright © 2016 Ajani. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func EditClick(_ sender: Any) {
        
    }
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Number: UILabel!
    @IBOutlet weak var WenAddr: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       /* if let items = self.tabbarcontroller.tabBar.items as? [UITabBarItem]{
            if items.count > 0{
                
            }
        }*/
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

