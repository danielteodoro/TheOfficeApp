//
//  CrewMember.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 24/11/20.
//

import Foundation

struct CrewMember: Decodable, Equatable {
    var _id: String
    var name: String
    var role: String
    
    static func ==(lhs: CrewMember, rhs: CrewMember) -> Bool {
        return lhs._id == rhs._id && lhs.name == rhs.name && lhs.role == rhs.role
    }
}
