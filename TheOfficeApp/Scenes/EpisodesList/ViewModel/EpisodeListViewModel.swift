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
    
    var episodesVM = [EpisodeViewModel]()
    var delegate: EpisodeListViewModelDelegate?
    
    init() {
       loadEpisodes()
    }
    
    func loadEpisodes() {
        WebService().fetchEpisodes() { [weak self] result in
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
