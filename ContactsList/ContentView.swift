//
//  ContentView.swift
//  ContactsList
//
//  Created by Игорь Верхов on 27.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var contacts = Contacts()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts.items.sorted()) { contact in
                    NavigationLink(value: contact) {
                        HStack {
                            Image(uiImage: UIImage(data: contact.imageData)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(.circle)
                            Text(contact.name)
                            Spacer()
                        }
                    }
                }
                .onDelete(perform: deleteContacts)
            }
            .navigationTitle("Contact list")
            .navigationDestination(for: Contact.self) { contact in
                EditView( contact: contact, contacts: contacts)
            }
            .sheet(isPresented: $showingAddView) {
                AddView(contacts: contacts)
            }
            .toolbar {
                Button("Add contact", systemImage: "plus") {
                    showingAddView = true
                }
            }
        }
    }
    
    func deleteContacts( at offset: IndexSet) {
        contacts.items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
