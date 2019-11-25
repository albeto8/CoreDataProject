//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Mario Alberto Barragán Espinosa on 24/11/19.
//  Copyright © 2019 Mario Alberto Barragán Espinosa. All rights reserved.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    var wrappedLastName: String {
        lastName ?? "Unknown"
    }

}
