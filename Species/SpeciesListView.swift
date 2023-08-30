//
//  SpeciesListView.swift
//  Species
//
//  Created by Francesca MACDONALD on 2023-08-29.
//

import SwiftUI
import AVFAudio

struct SpeciesListView: View {
    @StateObject var speciesVM = SpeciesViewModel()
    @State var audioPlayer: AVAudioPlayer!
    
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
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            playSound(soundFile: "\(Int.random(in: 0...8))")
                        } label: {
                            Image("peek")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 25)
                        }
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
    func playSound(soundFile: String) {
        // create a sound file object consisting of a set of one or more files with associated device attributes
        guard let soundFile = NSDataAsset(name: soundFile) else {
            print("Could not read file \(soundFile)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("Could not create audio player: \(error.localizedDescription)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}
