//
//  FirstViewController.swift
//  BusinessCards
//
//  Created by Ajani on 28/12/2016.
//  Copyright © 2016 Ajani. All rights reserved.
//

import UIKit
import CoreData


class FirstViewController: UIViewController {
    var theCard :Card!
    
    @IBAction func EditClick(_ sender: Any) {
        self.tabBarController?.selectedIndex = 4
        
        if theCard == nil{
            let editViewController1 = self.tabBarController?.viewControllers?[4] as! EditViewController1
            editViewController1.createMyCard()
        } else {
            let editViewController1 = self.tabBarController?.viewControllers?[4] as! EditViewController1
            editViewController1.initMyCard(card: theCard)
        }
        //  let editViewController1 =  self.storyboard?.instantiateViewController(withIdentifier: "EditViewController1") as! EditViewController1
        
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
    override func viewDidAppear(_ animated: Bool) {
        var cardsList = getData()
        for i in 0...cardsList.count-1 {
            if cardsList[i].isMyCard{
                theCard=cardsList[i]
                break
            }
        }
        if theCard != nil {
         Name.text = theCard.name
            Email.text=theCard.email
            Number.text=theCard.number
            WenAddr.text=theCard.webaddr
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() -> [Card]{
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        
        var cards = [Card]()
        
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            cards = results as! [Card]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return cards
    }


}

