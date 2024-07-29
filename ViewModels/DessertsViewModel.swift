//
//  DessertsViewModel.swift
//  SweetTreats
//
//  Created by user263110 on 7/28/24.
//

import Foundation

func fetchDesserts() async throws -> Desserts {
    let mealDbURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
    let request = URLRequest(url: mealDbURL!)
    
    let (data, _) = try await URLSession.shared.data(for: request)
   
    let response = try JSONDecoder().decode(MealsResponse.self, from: data);
    
    let desserts = response.meals
        
    return desserts
}

class DessertsViewModel: ObservableObject {
    @Published var desserts: [Dessert] = []
    
    @MainActor
    func getAll() async {
        do {
            self.desserts = try await fetchDesserts()
        } catch {
            print(error)
        }
    }
}
