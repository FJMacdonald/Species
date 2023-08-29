//
//  SpeciesDetailViewModel.swift
//  Species
//
//  Created by Francesca MACDONALD on 2023-08-29.
//

import Foundation

@MainActor
class SpeciesDetailViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var name: String?
        var classification: String?
        var designation: String?
        var average_height: String?
        var average_lifespan: String?
        var language: String?
        var skin_colors: String?
        var hair_colors: String?
        var eye_colors: String?
   }
    @Published var name = ""
    @Published var urlString = ""
    @Published var classification = ""
    @Published var designation = ""
    @Published var average_height = ""
    @Published var average_lifespan = ""
    @Published var language = ""
    @Published var skin_colors = ""
    @Published var hair_colors = ""
    @Published var eye_colors = ""

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
                print("😡 JSON ERROR: Could not deccode returned JSON data")
                return
            }
            self.name = returned.name ?? ""
            self.classification = returned.classification ?? ""
            self.designation = returned.designation ?? ""
            self.average_height = returned.average_height ?? ""
            self.average_lifespan = returned.average_lifespan ?? ""
            self.language = returned.language ?? ""
            self.skin_colors = returned.skin_colors ?? ""
            self.hair_colors = returned.hair_colors ?? ""
            self.eye_colors = returned.eye_colors ?? ""

       } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
    
}
