//
//  Contacts.swift
//  ContactsList
//
//  Created by Игорь Верхов on 27.01.2024.
//

import Foundation

@Observable
class Contacts: Codable {
    
    private static let savedPath = URL.documentsDirectory.appending(path: "SavedContacts")
    
    var items: [Contact] {
        didSet {
            do {
                let data = try JSONEncoder().encode(items)
                try data.write(to: Self.savedPath)
            } catch {
                print("Unable to save data")
            }
        }
    }
    
    init() {
        do {
            let data = try Data(contentsOf: Self.savedPath)
            self.items = try JSONDecoder().decode([Contact].self, from: data)
        } catch {
            print("Unable to load data from documents directory")
            items = []
        }
    }
}
