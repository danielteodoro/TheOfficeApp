//
//  EpisodeListViewModel.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import Foundation

protocol EpisodeListViewModelDelegate: AnyObject {
    var episodesCount: Int { get }
    func episode(for indexPath: IndexPath) -> EpisodeViewModel
    func loadEpisodes()
    func didSelectEpisode(at indexPath: IndexPath)
    func openRandomQuote()
}

final class EpisodeListViewModel {
    
    var service: WebServicing
    weak var viewDelegate: EpisodeListViewDelegate?
    weak var coordinatorDelegate: EpisodeListCoordinatorDelegate?
    
    private var episodesVM = [EpisodeViewModel]()
    
    init(coordinatorDelegate: EpisodeListCoordinatorDelegate, service: WebServicing = WebService()) {
        self.coordinatorDelegate = coordinatorDelegate
        self.service = service
    }
    
    func loadEpisodes() {
        self.viewDelegate?.showLoading(true)
        service.fetch(from: Endpoints.episodes, with: EpisodeResponse.self, completion: { [weak self] result in
            switch result {
            case .success(let episode):
                self?.episodesVM = episode.data.map(EpisodeViewModel.init)
                self?.viewDelegate?.didLoadEpisodes()
                self?.viewDelegate?.showLoading(false)
            case .failure(let error):
                self?.viewDelegate?.errorOnLoadingEpisodes(error: error)
                self?.viewDelegate?.showLoading(false)
            }
        })
    }
}

extension EpisodeListViewModel: EpisodeListViewModelDelegate {
    var episodesCount: Int {
        get {
            return self.episodesVM.count
        }
    }
    
    func episode(for indexPath: IndexPath) -> EpisodeViewModel {
        return episodesVM[indexPath.row]
    }
    
    func didSelectEpisode(at indexPath: IndexPath) {
        coordinatorDelegate?.perform(.openEpisode(episode(for: indexPath)))
    }
    
    func openRandomQuote() {
        coordinatorDelegate?.perform(.randomQuote)
    }
}
