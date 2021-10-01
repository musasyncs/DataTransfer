//
//  StateManager.swift
//  DataTransfer
//
//  Created by Ewen on 2021/9/28.
//

import UIKit
import Foundation

class StateManager {
    private(set) var contacts: [Contact] = [
        Contact(
            photo: UIImage(imageLiteralResourceName: "Madison"),
            name: "Madison Thompson",
            position: "Sales, Gale Foods",
            email: "madison@galefoods.com",
            phone: "4-(968) 705-1370"
        ),
        Contact(
            photo: UIImage(imageLiteralResourceName: "Tyler"),
            name: "Tyler Porter",
            position: "Software developer, Prophecy",
            email: "tyles@propehcy.com",
            phone: "2-(513) 832-7517"
        ),
        Contact(
            photo: UIImage(imageLiteralResourceName: "Katherine"),
            name: "Katherine Price",
            position: "Marketing, Golden Roads",
            email: "katherine@goldenroads.com",
            phone: "1-(722) 844-1495"
        ),
        Contact(
            photo: UIImage(imageLiteralResourceName: "Gary"),
            name: "Gary Edwards",
            position: "Web Developer, Bluewares",
            email: "gary@bluewares.com",
            phone: "9-(687) 559-3525"
        ),
        Contact(
            photo: UIImage(imageLiteralResourceName: "Rebecca"),
            name: "Rebecca Rogers",
            position: "HR, Globaviations",
            email: "rebecca@globaviations.com",
            phone: "3-(710) 249-5471"
        )
    ]
    
    var favorites: [Contact] = []
    
    func update(_ newContact: Contact) {
        for (index, contact) in contacts.enumerated() {
            if contact.name == newContact.name {
                contacts[index] = newContact
                break
            }
        }
    }
    
}
