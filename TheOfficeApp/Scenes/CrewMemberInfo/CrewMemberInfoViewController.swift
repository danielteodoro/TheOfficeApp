//
//  CrewMemberInfoViewController.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 21/12/20.
//

import UIKit

class CrewMemberInfoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!
    
    private var vm: CrewMemberInfoViewModel
    
    init(crewMember: CrewMember, title: String) {
        self.vm = CrewMemberInfoViewModel(crewMember: crewMember, title: title)
        
        super.init(nibName: "CrewMemberInfoViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLabels()
    }
    
    func setLabels() {
        self.titleLabel.text = vm.title
        self.nameLabel.text = vm.name
        self.rolesLabel.text = vm.roles
    }
    
}
