//
//  Endpoints.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import Foundation


enum Endpoints: String {
    case episodes = "episodes/"
    case randomQuote = "quotes/random"
    
    var baseURL: String { "https://officeapi.dev/api/" }
    
    var url: URL? {
        URL(string: baseURL + self.rawValue)
    }
}
