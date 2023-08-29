//
//  SpeciesListView.swift
//  Species
//
//  Created by Francesca MACDONALD on 2023-08-29.
//

import SwiftUI

struct SpeciesListView: View {
    @StateObject var speciesVM = SpeciesViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(speciesVM.speciesArray, id: \.self) { species in
                    NavigationLink {
                        SpeciesDetailView(species: species)                      }  label: {
                            Text(" \(species.name.capitalized)")
                                .font(.title2)
                        }
                }
                
            }
            .onAppear {
                Task {
                    await speciesVM.getData()
                }
            }
           .listStyle(.plain)
            .navigationBarTitle("Species")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}
