//
//  Model.swift
//  archive
//
//  Created by Ivan Bottigelli on 13/08/22.
//

import Foundation

struct mUserProfile: Codable  {
    let user_id: String
    let msg: String
    let error: Int
}

struct responseUpdateItem: Codable  {
    let msg: String
    let error: Int
    let mysql_error: Int
}

struct responseAddedItem: Codable  {
    let msg: String
    let error: Int
    let mysql_error: Int
}

struct Items: Codable  {
    let item: [Item]
}

struct Item: Codable {
    let id = UUID()
    let idItem: String
    var nameItem: String
    var descriptionItem: String
    var imageItem: String
    var prizeItem: Double
    var statusItem: String
    var quantityItem: Int
    var positionItem: String? = ""
    var externalCode: String? = ""
    var codeItem: String
    var availableItem: Bool
    var basketItem: String
    var typeItem: String
}
