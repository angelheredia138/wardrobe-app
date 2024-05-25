//
//  ClothingListViewModel.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 3/17/24.
//


import SwiftUI
import CoreData

class ClothingListViewModel: ObservableObject {
    @Published var items: [ClothingItem] = []

    private var managedObjectContext: NSManagedObjectContext

    // Context must be passed during initialization
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        fetchItems()
    }

    func addItem(name: String, type: String, color: String, size: String, image: UIImage, weatherType: String) {
        let newItem = ClothingItem(context: managedObjectContext)
        newItem.name = name
        newItem.type = type
        newItem.color = color
        newItem.size = size
        newItem.weatherType = weatherType
        
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            newItem.imageData = imageData
        }

        do {
            try managedObjectContext.save()
            items.append(newItem)
        } catch {
            print("Failed to save context: \(error)")
        }
    }


    private func saveImageToFileSystem(_ image: UIImage) -> String {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Failed to get JPEG representation of UIImage")
            return ""
        }
        let fileManager = FileManager.default
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageUrl = path.appendingPathComponent("\(UUID().uuidString).jpg")

        do {
            try imageData.write(to: imageUrl)
            print("Image saved successfully at \(imageUrl.path)")
            return imageUrl.path // Return the path as a string
        } catch {
            print("Failed to save image: \(error)")
            return ""
        }
    }
    
    func deleteItem(item: ClothingItem) {
            managedObjectContext.delete(item)
            fetchItems()  // Refetch items to update the view
        }

        // Method to save changes to the context
        func saveContext() {
            do {
                try managedObjectContext.save()
            } catch {
                print("Failed to save context after deletion: \(error)")
            }
        }

    func fetchItems() {
        let fetchRequest: NSFetchRequest<ClothingItem> = ClothingItem.fetchRequest()
        do {
            items = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
}








