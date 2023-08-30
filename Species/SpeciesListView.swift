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
            ZStack {
                List{
                    ForEach(speciesVM.speciesArray, id: \.self) { species in
                        LazyVStack {
                            NavigationLink {
                                SpeciesDetailView(species: species)
                            }  label: {
                                Text(" \(species.name.capitalized)")
                                    .font(.title2)
                            }
                        }
                        .onAppear {
                            speciesVM.loadNextIfNeeded(species: species)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitle("Species")
                
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await speciesVM.loadAll()
                            }
                        }
                        .bold()
                    }
                    ToolbarItem(placement: .status) {
                        Text("\(speciesVM.speciesArray.count) Species Returned")
                    }
                }
                if speciesVM.isLoading {
                    ProgressView()
                        .tint(.green)
                        .scaleEffect(4)
                }
            }
            .onAppear {
                Task {
                    await speciesVM.getData()
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}
