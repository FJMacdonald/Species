//
//  SpeciesDetailView.swift
//  Species
//
//  Created by Francesca MACDONALD on 2023-08-29.
//

import SwiftUI

struct SpeciesDetailView: View {
    @StateObject var speciesDetailVM = SpeciesDetailViewModel()
    
    var species: Species
    
    var body: some View {
        VStack (alignment: .leading, spacing: 3) {
            Text(species.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            
            Group {
                HStack (alignment: .top) {
                    Text("Classification:")
                        .bold()
                    Text( speciesDetailVM.classification)
                }
                HStack (alignment: .top) {
                    Text("Designation:")
                        .bold()
                    Text( speciesDetailVM.designation)
                 }
                .font(.title3)
                HStack (alignment: .top) {
                    Text("Average Height:")
                        .bold()
                    Text( speciesDetailVM.average_height)
                }
                .font(.title3)
                HStack {
                    Text("Average Lifespan:")
                        .bold()
                    Text( speciesDetailVM.average_lifespan)
                }
                .font(.title3)
                HStack (alignment: .top) {
                    Text("Language:")
                        .bold()
                    Text( speciesDetailVM.language)
                }
                .font(.title3)
                HStack (alignment: .top) {
                    Text("Skin Colors:")
                        .bold()
                    Text( speciesDetailVM.skin_colors)
                }
                HStack (alignment: .top) {
                    Text("Hair Colors:")
                        .bold()
                    Text( speciesDetailVM.hair_colors)
                }
                HStack (alignment: .top) {
                    Text("Eye Colors:")
                        .bold()
                    Text( speciesDetailVM.eye_colors)
                }
            }
            .font(.title3)
            
            
            Spacer()
        }
        .padding()
        .task {
            speciesDetailVM.urlString = species.url
            await speciesDetailVM.getData()
        }
    }
}


struct SpeciesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesDetailView(species: Species(name: "Human", classification: "mammal", designation: "sentient", average_height: "180", average_lifespan: "120", language: "Galactic Basic", skin_colors: "caucasian, black, asian, hispanic", hair_colors: "blonde, brown, black, red", eye_colors: "brown, blue, green, hazel, grey, amber", url: "https://swapi.dev/api/species/1/"))
    }
}
