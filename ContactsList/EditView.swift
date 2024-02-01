//
//  AddView.swift
//  ContactsList
//
//  Created by Игорь Верхов on 27.01.2024.
//

import MapKit
import SwiftUI

struct EditView: View {
    
    var contact: Contact
    var contacts: Contacts
    
    @Environment(\.dismiss) var dismiss
    @State private var name: String
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                VStack {
                    Map(initialPosition: MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: contact.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )) {
                        Marker(contact.name, coordinate: contact.coordinate)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    //                .clipShape(.circle)
                    
                    Spacer()
                }
                
                VStack {
                    Image(uiImage: UIImage(data: contact.imageData)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipShape(.circle)
                    
                    Text(name)
                        .padding()
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                }
                .offset(y: 50)
            }
            Spacer()
        }
        .navigationTitle("Details of contact")
        .navigationBarTitleDisplayMode(.inline)
        //        .toolbar {
        //            Button("Save", action: saveItem)
        //        }
    }
    
    init(contact: Contact, contacts: Contacts) {
        self.contact = contact
        self.contacts = contacts
        _name = State(initialValue: contact.name)
    }
    //    func saveItem() {
    //        let newContact = Contact(id: UUID(), name: name, image: <#T##Data#>)
    //        if let index = contacts.items.firstIndex(of: contact) {
    //            contacts.items[index] = newContact
    //            dismiss()
    //        }
    //    }
}

#Preview {
    EditView(contact: .example, contacts: Contacts())
}
