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
        let episodeDetailViewController = EpisodeDetailViewController(nibName: "EpisodeDetailViewController", bundle: nil)
        episodeDetailViewController.title = episodeVM.title
        presenter.push(episodeDetailViewController, animated: true, completion:nil)
        
        self.episodeDetailViewController = episodeDetailViewController
    }
    

}
