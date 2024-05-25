//
//  WardrobeView.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 3/17/24.
//


import SwiftUI

struct WardrobeView: View {
    @EnvironmentObject var viewModel: ClothingListViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items, id: \.self) { item in
                    NavigationLink(destination: ClothingItemView(item: item)) {
                        HStack {
                            ItemThumbnailView(imageData: item.imageData)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .shadow(radius: 3)
                                .padding(.trailing, 5)
                            
                            Text(item.name ?? "Unknown Item")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("My Wardrobe")
                        .navigationBarItems(trailing: NavigationLink(destination: AddClothingItemView()) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.appSecondary)
                        })
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        offsets.forEach { index in
            let item = viewModel.items[index]
            viewModel.deleteItem(item: item)
        }
        viewModel.saveContext()
    }
}

struct ItemThumbnailView: View {
    let imageData: Data?
    
    var body: some View {
        if let data = imageData, let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            Image("placeholder")
                .resizable()
                .scaledToFill()
        }
    }
}













