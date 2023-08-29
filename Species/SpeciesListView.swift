//
//  SpeciesListView.swift
//  Species
//
//  Created by Francesca MACDONALD on 2023-08-29.
//

import SwiftUI

struct SpeciesListView: View {
    var testArray = ["Hutt", "Ewok", "Wookie","Droid", "Human"]
    var body: some View {
        NavigationStack {
            List {
                ForEach(testArray, id: \.self) { item in
                    Text(item)
                        .font(.title)
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
