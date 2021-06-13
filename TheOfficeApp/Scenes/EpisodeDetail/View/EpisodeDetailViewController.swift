//
//  EpisodeDetailViewController.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 08/12/20.
//

import UIKit

protocol EpisodeDetailViewControllerDelegate {
    func openCrewMemberInfo(_ crewMember: CrewMember, title: String)
}

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var airDateLabel: UILabel!
    @IBOutlet weak var directorsButton: UIButton!
    @IBOutlet weak var writtersButton: UIButton!
    
    public var delegate: EpisodeDetailViewControllerDelegate?
    
    private var vm: EpisodeViewModel
    
    init(viewModel: EpisodeViewModel) {
        self.vm = viewModel
        super.init(nibName: EpisodeDetailViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setEpisodeInfo()
    }
    
    func setEpisodeInfo() {
        title = vm.title
        
        self.descriptionLabel.text = vm.description
        self.airDateLabel.text = vm.airDate
        
        directorsButton.setTitle(vm.directorName, for: .normal)
        writtersButton.setTitle(vm.writerName, for: .normal)
    }
    
    @IBAction func openDirectorsInfo(_ sender: Any) {
        self.delegate?.openCrewMemberInfo(vm.getDirector(), title: "Director")
    }
    
    @IBAction func openWritersInfo(_ sender: Any) {
        self.delegate?.openCrewMemberInfo(vm.getWriter(), title: "Writer")
    }
}
