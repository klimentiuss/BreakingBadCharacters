//
//  TableViewCell.swift
//  BreakingBadCharacters
//
//  Created by Daniil Klimenko on 24.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    var someImage: UIImage?
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nickNameLAbel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFill
            characterImageView.clipsToBounds = true
        }
    }
    
    
    func configure(with character: Character?) {
        nameLabel.text = character?.name
        nickNameLAbel.text = "Nickname: \(character?.nickname ?? "Error")"
        statusLabel.text = "Status: \(character?.status ?? "Error")"
        
        if character?.status == "Alive" {
            statusImage.tintColor = .green
        } else {
            statusImage.tintColor = .red
        }
        
        DispatchQueue.global().async {
            ImageManager.shared.fetchImage(from: character?.img, with: { image in
                self.someImage = image
            })
            
            DispatchQueue.main.async {
                self.characterImageView.image = self.someImage
            }
        }
    }
}




