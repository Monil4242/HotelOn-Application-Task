//
//  StartUpTableViewCell.swift
//  HotelOn Application Task
//
//  Created by monil sojitra on 28/08/23.
//

import UIKit
protocol AddListTableViewCellDelegate: AnyObject {
    func editlist(with index: IndexPath)
    func deleteList(with index: IndexPath)
}

class StartUpTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var dotButton: UIButton!
    var indexPath: IndexPath!
    weak var delegate: AddListTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        self.contentView.backgroundColor = .clear
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func dotButtonAction(_ sender: UIButton) {
        let editButton = UIAction(title: "Edit") { _ in
            self.delegate?.editlist(with: self.indexPath)
        }
        
        let deleteButton = UIAction(title: "Delete") { _ in
            self.delegate?.deleteList(with: self.indexPath)
        }
        
        let menu = UIMenu(children: [editButton, deleteButton])
        sender.showsMenuAsPrimaryAction = true
        sender.menu = menu
    }
    
}
