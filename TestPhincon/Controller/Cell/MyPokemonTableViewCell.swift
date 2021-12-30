//
//  MyPokemonTableViewCell.swift
//  TestPhincon
//
//  Created by Michael Tanakoman on 30/12/21.
//

import UIKit

class MyPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var typePokemon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
