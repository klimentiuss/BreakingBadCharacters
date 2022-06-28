//
//  QuotesViewController.swift
//  BreakingBadCharacters
//
//  Created by Daniil Klimenko on 24.06.2022.
//

import UIKit

class QuotesViewController: UIViewController {
    
    var characterList: [Character]?
    var charactar: Character?
    var quotesList: [Quote]?
    var quote: Quote?
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        fetchQuote(from: breakingURLS.quoteURL.rawValue)
    }
    
    
    @IBAction func fetchButton(_ sender: Any) {
        fetchQuote(from: breakingURLS.quoteURL.rawValue)
    }
    
    
    func fetchQuote(from url: String?) {
//        NetworkManager.shared.fetchCharacter(from: breakingURLS.characterURL.rawValue) { character in
//            self.characterList = character
//            guard let charArray = self.characterList else { print("no"); return}
//
//
//            DispatchQueue.main.async {
//                for i in charArray {
//                    if i.name == self.quote?.author {
//                        print("hello")
//                        print(i.name)
//                        print(i.img ?? "error")
//                    }
//                }
//            }
//
//        }
        
        NetworkManager.shared.fetchQuote(from: url) { quote in
            self.quotesList = quote
            guard let characterQuote = self.quotesList?.randomElement() else { return }
            self.quote = characterQuote
            
            DispatchQueue.main.async {
                self.quoteLabel.text =
                """
                "\(self.quote?.quote ?? "error")"
                © \(self.quote?.author ?? "error")
                """
            }
        }
        
        
    }
}


extension QuotesViewController {
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
