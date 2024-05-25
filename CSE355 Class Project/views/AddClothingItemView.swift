//
//  AddClothingItemView.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 4/12/24.
//

import SwiftUI

struct AddClothingItemView: View {
    @EnvironmentObject var viewModel: ClothingListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var type: String = "T-Shirt"  // Default selection
    @State private var color: Color = .black
    @State private var size: String = ""
    @State private var showingCamera = false
    @State private var inputImage: UIImage?
    @State private var weatherType: String = ""

    // List of clothing types for the picker
    let clothingTypes = ["T-Shirt", "Pants", "Shorts", "Jacket", "Sweater", "Dress", "Skirt", "Blouse", "Coat", "Jeans", "Underwear", "Socks", "Other (will not show up in suggestions)"]

    var body: some View {
        Form {
            TextField("Name", text: $name)
            Picker("Type", selection: $type) {
                ForEach(clothingTypes, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(MenuPickerStyle())  // This makes it appear as a dropdown

            TextField("Size", text: $size)

            Picker("Weather Type", selection: $weatherType) {
                Text("Cold").tag("Cold")
                Text("Temperate").tag("Temperate")
                Text("Warm").tag("Warm")
            }.pickerStyle(SegmentedPickerStyle())

            ColorPicker("Pick a color", selection: $color, supportsOpacity: false)
                .padding()

            if let inputImage = inputImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                Button("Retake Picture") {
                    showingCamera = true
                }
            } else {
                Button("Take Picture") {
                    showingCamera = true
                }
            }

            Button("Add Item") {
                if let inputImage = inputImage {
                    let uiColor = color.uiColor()
                    let hexString = uiColor.toHexString()
                    viewModel.addItem(name: name, type: type, color: hexString, size: size, image: inputImage, weatherType: weatherType)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .disabled(name.isEmpty || type.isEmpty || size.isEmpty || inputImage == nil)
        }
        .navigationBarTitle("Add New Item", displayMode: .inline)
        .sheet(isPresented: $showingCamera, onDismiss: loadImage) {
            CameraView(image: $inputImage)
        }
    }

    private func loadImage() {
        // This function can be used to process the image after it's taken
    }
}

