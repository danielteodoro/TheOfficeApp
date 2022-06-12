//
//  EpisodeDetailCoordinator.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 13/12/20.
//

import UIKit

class EpisodeDetailCoordinator: Coordinator {
    
    private let presenter: Router
    private var episodeDetailViewController: EpisodeDetailViewController?
    private var episodeVM: EpisodeViewModel
    
    init(presenter: Router, episodeVM: EpisodeViewModel){
        self.presenter = presenter
        self.episodeVM = episodeVM
    }
    
    func start() {
        let episodeDetailViewController = EpisodeDetailViewController.init(viewModel: episodeVM)
        episodeDetailViewController.delegate = self
        presenter.push(episodeDetailViewController, animated: true, completion:nil)
        
        self.episodeDetailViewController = episodeDetailViewController
    }
    
    func stop() {
        
    }
    
}

extension EpisodeDetailCoordinator: EpisodeDetailViewControllerDelegate {
    
    func openCrewMemberInfo(_ crewMember: CrewMember, title: String) {
        let crewMemberInfoCoordinator = CrewMemberInfoCoordinator(presenter: self.presenter, crewMember: crewMember, title: title)
        crewMemberInfoCoordinator.start()
    }
}
