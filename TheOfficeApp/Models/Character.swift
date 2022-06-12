//
//  Character.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 22/12/20.
//

import Foundation

struct Character: Decodable {
    let id: String
    let firstname: String
    let lastname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstname, lastname
    }
}
