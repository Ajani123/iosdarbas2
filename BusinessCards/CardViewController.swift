//
//  CardViewController.swift
//  BusinessCards
//
//  Created by Ajani on 04/01/2017.
//  Copyright © 2017 Ajani. All rights reserved.
//

import UIKit
import CoreData

class CardViewController: UIViewController {

    var onLoadBool = true
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var webAddr: UILabel!
    var selectedCard : Card!
    @IBAction func onEditClick(_ sender: Any) {
    }
    
    
    @IBAction func onDeleteClick(_ sender: Any){
        delete()
        self.tabBarController?.selectedIndex = 3
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        if onLoadBool{
            onLoadBool = false
            self.tabBarController?.selectedIndex = 1
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delete(){
        let card = selectedCard as NSManagedObject
        card.managedObjectContext?.delete(card)
        
        do {
            try card.managedObjectContext?.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    public func initCardView(card : Card){
        selectedCard = card;
        name.text = card.name
        email.text = card.email
        number.text = card.number
        webAddr.text = card.webaddr
        
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
