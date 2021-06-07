//
//  Endpoints.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import Foundation


class Endpoints {
    
    func baseURLString() -> String! {
        return "https://officeapi.dev/api/"
    }
    
    public func episodes() -> URL {
        return URL.init(string: self.baseURLString()+"episodes/")!
    }
    public func randomQuote() -> URL {
        return URL.init(string: self.baseURLString()+"quotes/random1/")!
    }
}
