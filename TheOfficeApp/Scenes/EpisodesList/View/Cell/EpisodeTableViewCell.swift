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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func presentData(episodeVM: EpisodeViewModel) {
        self.titleLabel.text = episodeVM.title
        self.directorLabel.text = episodeVM.directorName
        self.dateLabel.text = episodeVM.airDate
    }

}
