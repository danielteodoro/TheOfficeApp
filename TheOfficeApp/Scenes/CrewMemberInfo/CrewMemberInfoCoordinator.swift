//
//  CrewMemberInfoCoordinator.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 21/12/20.
//

import UIKit

class CrewMemberInfoCoordinator: Coordinator {
    
    private let presenter: Router
    private var crewMember: CrewMember
    private var title: String
    
    private var viewModel: CrewMemberInfoViewModel?
    private var view: CrewMemberInfoViewController?
    
    init(presenter: Router, crewMember: CrewMember, title: String){
        self.presenter = presenter
        self.crewMember = crewMember
        self.title = title
    }
    
    func start() {
        let viewModel = CrewMemberInfoViewModel(crewMember: crewMember, title: title)
        let crewMemberInfoViewController = CrewMemberInfoViewController(viewModel: viewModel)
        presenter.present(crewMemberInfoViewController, animated: true)
        
        self.viewModel = viewModel
        self.view = crewMemberInfoViewController
    }
    
    func stop() {
        
    }
}
