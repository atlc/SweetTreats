//
//  DessertDetailsViewModel.swift
//  SweetTreats
//
//  Created by user263110 on 7/29/24.
//

import Foundation

func fetchDessert(id: String) async throws -> DessertDetails {
    let urlBase = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    let mealDbURL = URL(string: urlBase + id)
    let request = URLRequest(url: mealDbURL!)
    
    let (data, _) = try await URLSession.shared.data(for: request)
    
    let response = try JSONDecoder().decode(MealDetailsResponse.self, from: data);
    
    let desserts = response.meals
        
    return desserts.first!
}


class DessertDetailsViewModel: ObservableObject {
    @Published var dessert = DessertDetails()
    @Published var ingredients: [String] = []
    
    @MainActor
    func getDetails(id: String) async {
        do {       
            let dessert = try await fetchDessert(id: id)
            
            self.dessert = dessert
            
            let mirrored = Mirror(reflecting: dessert)
            
            var unfilteredIngredients: [String] = []
            
            for i in 1...20 {
                let keyIngredient = "strIngredient\(i)"
                let keyMeasure = "strMeasure\(i)"
                
                let valIngredient = mirrored.children.first(where: { $0.label == keyIngredient })?.value as? String
                let valMeasure = mirrored.children.first(where: { $0.label == keyMeasure })?.value as? String
                
                var val = valIngredient
        
                if valMeasure != nil { val! += " (\(valMeasure ?? ""))" }
                
                if !valIngredient!.isEmptyOrNilOrWhitespace { unfilteredIngredients.append(val ?? "" ) }
            }
                    
            let filteredIngredients = unfilteredIngredients.filter { ing in !ing.isEmptyOrNilOrWhitespace }
            self.ingredients = filteredIngredients
        } catch {
            print(error)
        }
    }
}
