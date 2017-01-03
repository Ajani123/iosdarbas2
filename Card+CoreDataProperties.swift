//
//  Card+CoreDataProperties.swift
//  BusinessCards
//
//  Created by Ajani on 03/01/2017.
//  Copyright © 2017 Ajani. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Card {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card");
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var webaddr: String?
    @NSManaged public var number: String?
    @NSManaged public var isMyCard: Bool

}
