//
//  ItemListView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import SwiftUI
import FirebaseAuth

struct AnimalListView: View {
    @State private var animals: [Animal] = []
    private let apiService = ApiService()
    @Binding var isUserLoggedIn: Bool
    @State private var userEmail: String = ""

    var body: some View {
        NavigationView {
            VStack {
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Cerrar Sesión") {
                            logout()
                        }
                    }
                }
                .padding(.top, -70)
                Text("Correo: \(userEmail)")
                    .padding()
            }
        }
        .onAppear {
            apiService.fetchAnimals { animals in
                self.animals = animals
            }
            if let user = Auth.auth().currentUser {
                userEmail = user.email ?? "Sin correo"
            }
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false
        } catch let signOutError as NSError {
            print("Error al cerrar sesión: %@", signOutError)
        }
    }
}

struct AnimalListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalListView( isUserLoggedIn: .constant(true))
    }
}
