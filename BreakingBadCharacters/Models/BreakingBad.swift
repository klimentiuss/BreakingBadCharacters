//
//  Character.swift
//  BreakingBadCharacters
//
//  Created by Daniil Klimenko on 24.06.2022.
//


struct Character: Codable  {
    
    let char_id: Int?
    let name: String
    let occupation: [String?]
    let img: String?
    let status: String?
    let nickname: String?
    let appearance: [Int?]
    let portrayed: String?
    let category: String?
    
    var description: String {
        """
        Name: \(name)
        Nickname: \(nickname ?? "Error")
        Occupation: \(occupation.compactMap{$0}.joined(separator: ", "))
        Status: \(status ?? "Error")
        Appearance: \(appearance.count) seasons
        Portrayed: \(portrayed ?? "Error")
        \(category ?? "Error")
        """
    }
}


struct Quote: Codable {
    let quote: String?
    let author: String?
    let series: String?
}


enum breakingURLS: String {
    case characterURL = "https://breakingbadapi.com/api/characters"
    case quoteURL = "https://breakingbadapi.com/api/quotes"
}


