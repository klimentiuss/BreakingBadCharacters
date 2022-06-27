//
//  QuotesViewController.swift
//  BreakingBadCharacters
//
//  Created by Daniil Klimenko on 24.06.2022.
//

import UIKit

class QuotesViewController: UIViewController {
    
    var character: [Character]?
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupNavigationBar()
    }
    
    
    @IBAction func fetchButton(_ sender: Any) {
        fetchData()
    }
    
    
    func fetchData() {
        
        NetworkManager.shared.fetchCharacter(from: breakingURLS.characterURL.rawValue) { character in
            self.character = character
     //       guard let imageData = ImageManager.shared.fetchImage(from: self.character?.first?.img) else { return }
            
            DispatchQueue.main.async {
                self.nameLabel.text = self.character?.first?.name
        //        self.imageLabel.image = UIImage(data: imageData)
            }
        }
    }
    
    // Setup navigation bar
    private func setupNavigationBar() {
        
        title = "BreakingBad"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Navigation bar appearance
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .black
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
    }
    
}
