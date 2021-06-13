//
//  EpisodeTableViewCell.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 24/11/20.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func presentData(episodeVM: EpisodeViewModel) {
        self.titleLabel.text = episodeVM.title
        self.directorLabel.text = episodeVM.directorNameLabelText
        self.dateLabel.text = episodeVM.airDate
    }

}
