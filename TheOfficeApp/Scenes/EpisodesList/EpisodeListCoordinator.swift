//
//  EpisodeListCoordinator.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 08/12/20.
//

import UIKit

enum EpisodeListCoordinatorAction {
    case openEpisode(EpisodeViewModel)
    case randomQuote
}

protocol EpisodeListCoordinatorDelegate: AnyObject {
    func perform(_ action: EpisodeListCoordinatorAction)
}

class EpisodeListCoordinator: Coordinator {
  private let presenter: Router
  private var episodeListViewController: EpisodeListViewController?
  
  init(presenter: Router) {
    self.presenter = presenter
  }
  
    func start() {
        let viewModel = EpisodeListViewModel(coordinatorDelegate: self)
        let episodeListViewController = EpisodeListViewController(viewModel: viewModel)
        viewModel.viewDelegate = episodeListViewController
        presenter.push(episodeListViewController, animated: true, completion:nil)
        
        self.episodeListViewController = episodeListViewController
    }
    
    func stop() {
        
    }
}

extension EpisodeListCoordinator: EpisodeListCoordinatorDelegate {
    func perform(_ action: EpisodeListCoordinatorAction) {
        switch action {
        case .openEpisode(let episodeViewModel):
            let episodeDetailCoordinator = EpisodeDetailCoordinator(presenter: self.presenter, episodeVM: episodeViewModel)
            episodeDetailCoordinator.start()
        case .randomQuote:
            let randomQuoteCoordinator = RandomQuoteCoordinator(presenter: self.presenter)
            randomQuoteCoordinator.start()
        }
    }
}
