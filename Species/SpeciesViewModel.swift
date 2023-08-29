//
//  SpeciesViewModel.swift
//  Species
//
//  Created by Francesca MACDONALD on 2023-08-29.
//

import Foundation

@MainActor
class SpeciesViewModel: ObservableObject {
    @Published var speciesArray: [Species] = []
    @Published var urlString = "https://swapi.dev/api/species"
    @Published var count = 0

    struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Species]
    }
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        
        // convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our data structure
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                 return
            }
            self.count = returned.count
            self.urlString = returned.next ?? ""
            self.speciesArray =  returned.results
//            self.speciesArray =  self.speciesArray + returned.results
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
    func loadNextIfNeeded(species: Species) {
        guard let lastSpecies = speciesArray.last else { return}
        if species.id == lastSpecies.id && urlString.hasPrefix("http") {
            Task {
                await getData ()
            }
        }
    }
}
