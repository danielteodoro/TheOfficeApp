//
//  EpisodeListViewModel.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import Foundation

protocol EpisodeListViewDelegate {
    func didLoadEpisodes()
    func errorOnLoadingEpisodes(error: Error)
    func showLoading(_ show: Bool)
}

class EpisodeListViewModel {
    
    var service: WebServicing
    
    var episodesVM = [EpisodeViewModel]()
    var viewDelegate: EpisodeListViewDelegate?
    
    init(service: WebServicing = WebService()) {
        self.service = service
    }
    
    func loadEpisodes() {
        self.viewDelegate?.showLoading(true)
        service.fetchEpisodes() { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.episodesVM = episodes.map(EpisodeViewModel.init)
                self?.viewDelegate?.didLoadEpisodes()
                self?.viewDelegate?.showLoading(false)
            case .failure(let error):
                self?.viewDelegate?.errorOnLoadingEpisodes(error: error)
                self?.viewDelegate?.showLoading(false)
            }
        }
    }
}
