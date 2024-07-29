//
//  Desserts.swift
//  SweetTreats
//
//  Created by user263110 on 7/28/24.
//

import Foundation
import SwiftUI


struct DessertsView: View {
    @StateObject private var dessertsViewModel = DessertsViewModel()
    @State private var searchedDesserts: [Dessert] = []
    @State private var searchString: String = ""
    
    func filterDesserts() {
        if self.searchString.isEmpty {
            self.searchedDesserts = dessertsViewModel.desserts
        } else {
            self.searchedDesserts = dessertsViewModel.desserts.filter { dessert in dessert.strMeal.lowercased().contains(self.searchString.lowercased())}
        }
    }
        
    var body: some View {
        NavigationView {
            VStack {
                Text("SweetTreats Recipe Search").padding(.top, 15)

                
                TextField("Search for a recipe!", text: $searchString)
                    .border(.blue)
                    .padding(.horizontal, 40)
                    .padding(.top, 15)
                    .onChange(of: searchString, filterDesserts)
                
                List(searchedDesserts, id: \.idMeal) { dessert in
                    NavigationLink(
                        destination: DessertDetailsView(id: dessert.idMeal),
                        label: {
                            Text(dessert.strMeal)
                        }
                    )
                    
                    AsyncImage(url: URL(string: dessert.strMealThumb)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
        .onAppear{
            Task {
                await dessertsViewModel.getAll()
                self.searchedDesserts = dessertsViewModel.desserts
            }
        }
    }
}


// Establishing a generic eventListener
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-run-some-code-when-state-changes-using-onchange
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
