//
//  EpisodeListCoordinator.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 08/12/20.
//

import UIKit

class EpisodeListCoordinator: Coordinator {
  private let presenter: Router
  private var episodeListViewController: EpisodeListViewController?
  
  init(presenter: Router) {
    self.presenter = presenter
  }
  
  func start() {
    let episodeListViewController = EpisodeListViewController(nibName: EpisodeListViewController.className, bundle: nil)
    episodeListViewController.delegate = self
    episodeListViewController.title = "Episodes List"
    presenter.push(episodeListViewController, animated: true, completion:nil)
    
    self.episodeListViewController = episodeListViewController
  }
    
    func stop() {
        
    }
}

extension EpisodeListCoordinator: EpisodeListViewControllerDelegate {
    
    func didSelectEpisode(episodeVM: EpisodeViewModel) {
        let episodeDetailCoordinator = EpisodeDetailCoordinator(presenter: self.presenter, episodeVM: episodeVM)
        episodeDetailCoordinator.start()
    }
    
    func openRandomQuote() {
        let randomQuoteCoordinator = RandomQuoteCoordinator(presenter: self.presenter)
        randomQuoteCoordinator.start()
    }
    
}
