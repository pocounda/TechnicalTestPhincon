//
//  PokemonListTableViewCell.swift
//  TestPhincon
//
//  Created by Michael Tanakoman on 30/12/21.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var typePokemon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
