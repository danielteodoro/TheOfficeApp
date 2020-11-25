//
//  EpisodeViewModel.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import Foundation

class EpisodeViewModel {
    
    var episode: Episode
    
    var title: String {
        return self.episode.title
    }
    
    var description: String {
        return self.episode.description
    }
    
    var airDate: String {
        return DateFormatterHelper().formatDate(from: self.episode.airDate)
    }
    
    var director: String {
        return self.episode.director.name
    }
    
    
    init(episode: Episode) {
        self.episode = episode
    }
    
}
