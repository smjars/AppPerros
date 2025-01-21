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
                        AsyncImage(url: URL(string: animal.imagen))
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(animal.nombre)
                                .font(.headline)
                            Text(animal.tipo)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Animales")
        }
        .onAppear {
            apiService.fetchAnimals { animals in
                self.animals = animals
            }
        }
    }
}

#Preview {
    AnimalListView()
}
