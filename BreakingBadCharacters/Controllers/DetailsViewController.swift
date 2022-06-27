//
//  DetailsViewController.swift
//  BreakingBadCharacters
//
//  Created by Daniil Klimenko on 24.06.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    
    var character: Character?
    var charImage: UIImage?
    
    @IBOutlet weak var charactarImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = character?.description
        fetchImage(from: character?.img)
        
    }
    
    
        func fetchImage(from url: String?) {
            guard let stringURL = url else { return  }
            guard let url = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.charactarImage.image = UIImage(data: imageData)
            }
            
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
