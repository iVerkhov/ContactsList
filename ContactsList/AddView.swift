//
//  AddView.swift
//  ContactsList
//
//  Created by Игорь Верхов on 27.01.2024.
//
import MapKit
import PhotosUI
import SwiftUI

struct AddView: View {
    
    var contacts: Contacts
    
    let locationFetcher = LocationFetcher()
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedImage: PhotosPickerItem?
    @State private var loadedImage: Image?
    @State private var name = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            PhotosPicker(selection: $selectedImage) {
                if let loadedImage {
                    loadedImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250,height: 250)
                        .clipShape(.circle)
                } else {
                    ContentUnavailableView("Choose the picture", systemImage: "photo.badge.plus", description: Text("Tap to import the picture"))
                }
            }
            
            if loadedImage != nil {
                TextField("Enter the name", text: $name)
                    .padding()
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Button("Save", action: saveNewItem)
                    .padding()
                    .font(.title3)
                    .frame(width: 150)
                    .background(.blue.gradient)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 25))
            }
            
            Spacer()
            
                .onChange(of: selectedImage, loadImage)
        }
        .navigationTitle("Add new contact")
        .onAppear(perform: locationFetcher.start)
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data: imageData) else {return }
            loadedImage = Image(uiImage: uiImage)
        }
    }
    
    func saveNewItem() {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }
            locationFetcher.start()
            let position = locationFetcher.lastKnownLocation
            let latitude = position?.latitude
            let longitude = position?.longitude
            // Fetch latitude and longitude and add to new contact
            let newContact = Contact(id: UUID(), name: name, image: imageData, latitude: latitude, longitude: longitude)
            contacts.items.append(newContact)
            dismiss()
        }
    }
}

#Preview {
    AddView(contacts: Contacts())
}
