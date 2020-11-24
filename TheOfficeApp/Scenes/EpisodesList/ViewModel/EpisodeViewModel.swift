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
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: self.episode.airDate) {
            return dateFormatterPrint.string(from: date)
        } else {
            return("Unknow Date")
        }
    }
    
    
    init(episode: Episode) {
        self.episode = episode
    }
    
}
