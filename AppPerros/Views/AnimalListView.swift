//
//  ItemListView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import SwiftUI

struct AnimalListView: View {
    @State private var animals: [Animal] = []
    private let apiService = ApiService()
    
    var body: some View {
        NavigationView {
            List(animals) { animal in
                NavigationLink(destination: AnimalDetailView(animal: animal)) {
                    HStack {
                        AsyncImage(url: URL(string: animal.imagen)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 120, height: 120)
                        .clipShape(Rectangle())
                        
                        VStack(alignment: .leading) {
                            Text(animal.nombre)
                                .font(.headline)
                            Text(animal.tipo)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Animales en Adopción")
        }
        .onAppear {
            apiService.fetchAnimals { animals in
                self.animals = animals
            }
        }
    }
}

struct AnimalListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalListView()
    }
}
