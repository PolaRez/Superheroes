//
//  SearchResultTableViewCell.swift
//  Superheroes
//
//  Created by Polina Reznik on 04/08/2021.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var superheroImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var identifier: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
