//
//  User.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 3/17/24.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var color: String
    var size: String
    var imageUrl: String
}
