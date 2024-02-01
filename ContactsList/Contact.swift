//
//  Contact.swift
//  ContactsList
//
//  Created by Игорь Верхов on 27.01.2024.
//
import MapKit
import Foundation

struct Contact: Codable, Comparable, Hashable, Identifiable {
    
    enum CodingKeys: CodingKey{
        case id
        case name
        case image
        case latitude
        case longitude
    }
    
    var id: UUID
    var name: String
    var imageData: Data
    var latitude: Double?
    var longitude: Double?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }
    
    init(id: UUID, name: String, image: Data, latitude: Double?, longitude: Double?) {
        self.id = id
        self.name = name
        self.imageData = image
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageData = try container.decode(Data.self, forKey: .image)
        self.latitude = try container.decode(Double?.self, forKey: .latitude)
        self.longitude = try container.decode(Double?.self, forKey: .longitude)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.imageData, forKey: .image)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
    }
    
    static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.name < rhs.name
    }
    
    static func createExample() -> Data {
        guard let imageUrl = Bundle.main.url(forResource: "example", withExtension: "jpg") else {
            fatalError("Failed to locate example image in bundle.")
        }
        guard let imageData = try? Data(contentsOf: imageUrl) else {
            fatalError("Failed to download example image from bundle.")
        }
        return imageData
    }
    
    static let example = Contact(id: UUID(), name: "Example name", image: Self.createExample(), latitude: 48.8566, longitude: 2.3522)
}
