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
    let _id: String
    let content: String
    let character: Character
}
