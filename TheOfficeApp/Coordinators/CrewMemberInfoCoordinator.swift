//
//  CrewMemberInfoCoordinator.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 21/12/20.
//

import UIKit

class CrewMemberInfoCoordinator: Coordinator {
    
    private let presenter: Router
    private var crewMemberInfoViewController: CrewMemberInfoViewController?
    private var crewMember: CrewMember
    private var title: String
    
    init(presenter: Router, crewMember: CrewMember, title: String){
        self.presenter = presenter
        self.crewMember = crewMember
        self.title = title
    }
    
    func start() {
        let crewMemberInfoViewController = CrewMemberInfoViewController(crewMember: crewMember, title: title)
        presenter.present(crewMemberInfoViewController, animated: true)
        
        self.crewMemberInfoViewController = crewMemberInfoViewController
    }
}
