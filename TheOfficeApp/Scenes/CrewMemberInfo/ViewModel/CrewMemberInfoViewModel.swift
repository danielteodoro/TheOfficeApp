//
//  CrewMemberInfoViewModel.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 21/12/20.
//

import Foundation

class CrewMemberInfoViewModel {
    
    private var crewMember: CrewMember
    
    var title: String
    
    var name: String {
        return crewMember.name
    }
    
    var roles: String {
        return crewMember.role
    }
    
    init(crewMember: CrewMember, title: String) {
        self.crewMember = crewMember
        self.title = title
    }
}
