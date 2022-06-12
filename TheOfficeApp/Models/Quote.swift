//
//  Quote.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 22/12/20.
//

import Foundation

struct QuoteResponse: Decodable {
    var data: Quote
}

struct Quote: Decodable {
    let id: String
    let content: String
    let character: Character
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, character
    }
}
