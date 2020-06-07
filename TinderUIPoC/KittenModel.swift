//
//  KittenModel.swift
//  TinderUIPoC
//
//  Created by 板垣智也 on 2020/06/07.
//  Copyright © 2020 板垣智也. All rights reserved.
//

import Foundation

class Kitten: Hashable, CustomStringConvertible {
    var id: Int

    let name: String
    let age: Int
    let mutualFriends: Int
    let imageName: String
    let occupation: String

    var description: String {
        return "\(name), id: \(id)"
    }
    init() {
        // nothing
    }

    static func getKittens() -> [Kitten] {
        return
        [
            Kitten(id: 0, name: "Cindy", age: 1, mutualFriends: 4, imageName: "1", occupation: "Coach"),
            Kitten(id: 1, name: "Mark", age: 1, mutualFriends: 0, imageName: "2", occupation: "Insurance Agent"),
            Kitten(id: 2, name: "Clayton", age: 1, mutualFriends: 1, imageName: "3", occupation: "Food Scientist"),
            Kitten(id: 3, name: "Brittni", age: 1, mutualFriends: 4, imageName: "4", occupation: "Historian"),
            Kitten(id: 4, name: "Archie", age: 1, mutualFriends:18, imageName: "5", occupation: "Substance Abuse Counselor"),
            Kitten(id: 5, name: "James", age: 1, mutualFriends: 3, imageName: "6", occupation: "Marketing Manager"),
            Kitten(id: 6, name: "Danny", age: 1, mutualFriends: 16, imageName: "7", occupation: "Dentist"),
            Kitten(id: 7, name: "Chi", age: 1, mutualFriends: 9, imageName: "8", occupation: "Recreational Therapist"),
            Kitten(id: 8, name: "Josue", age: 1, mutualFriends: 5, imageName: "9", occupation: "HR Specialist"),
            Kitten(id: 9, name: "Debra",age: 1, mutualFriends: 13, imageName: "10", occupation: "Judge")
        ]

    }
}

