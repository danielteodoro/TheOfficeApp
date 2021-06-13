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
    
    var directorName: String {
        return self.episode.director.name
    }
    
    var directorNameLabelText: String {
        return "Director: " + self.episode.director.name
    }
    
    var writerName: String {
        return self.episode.writer.name
    }
    
    func getDirector() -> CrewMember {
        return episode.director
    }
    
    func getWriter() -> CrewMember {
        return episode.writer
    }
    
    init(episode: Episode) {
        self.episode = episode
    }
}
