//
//  ListViewModel.swift
//  TodoList
//
//  Created by Kamil Wójcicki on 18/05/2023.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            /*
             anytime we change items array, function in didSet will run
             */
            saveItems()
        }
    }
    
    
    let itemsKey: String = "items_list"
    init() {
        getItems()
    }
    
    func getItems() {
//        let newItem = [
//            ItemModel(title: "This is the first title", isCompleted: false),
//            ItemModel(title: "This is the second", isCompleted: true),
//            ItemModel(title: "Third", isCompleted: false)
//        ]
        //items.append(contentsOf: newItem)
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        //guard let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) else { return }
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
