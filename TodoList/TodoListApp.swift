//
//  TodoListApp.swift
//  TodoList
//
//  Created by Kamil Wójcicki on 17/05/2023.
//

import SwiftUI

/*
 MVVM Architekrure
 
 Model - data point
 View - UI
 ViewModel - manages Models for View
 
 */

@main
struct TodoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
