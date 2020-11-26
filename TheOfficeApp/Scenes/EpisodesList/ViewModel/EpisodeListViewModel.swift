//
//  EpisodeListViewModel.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import Foundation

protocol EpisodeListViewModelDelegate {
    func didLoadEpisodes()
    func errorOnLoadingEpisodes(error: Error)
}

class EpisodeListViewModel {
    
    var service: WebServicing
    
    var episodesVM = [EpisodeViewModel]()
    var delegate: EpisodeListViewModelDelegate?
    
    init(service: WebServicing = WebService()) {
        self.service = service
       loadEpisodes()
    }
    
    func loadEpisodes() {
        service.fetchEpisodes() { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.episodesVM = episodes.map(EpisodeViewModel.init)
                self?.delegate?.didLoadEpisodes()
            case .failure(let error):
                self?.delegate?.errorOnLoadingEpisodes(error: error)
            }
        }
    }
}
