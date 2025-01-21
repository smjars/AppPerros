//
//  ItemDetailView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import SwiftUI

struct AnimalDetailView: View {
    let animal: Animal
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: animal.imagen)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipShape(Rectangle())
                
                Text(animal.nombre)
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                    
                Group {
                    Text("Tipo: \(animal.tipo)")
                        .font(.headline)
                    
                    Text("Edad: \(animal.edad)")
                        .font(.subheadline)
                    
                    Text("Estado: \(animal.estado)")
                        .font(.subheadline)
                    
                    Text("Genero: \(animal.genero)")
                        .font(.subheadline)
                }
                
                Group {
                    Text("Descripción Física:")
                        .font(.headline)
                    Text(animal.desc_fisica)
                        .font(.body)
                    
                    Text("Descripción de Personalidad:")
                        .font(.headline)
                    Text(animal.desc_personalidad)
                        .font(.body)
                    
                    Text("Descripción Adicional:")
                        .font(.headline)
                    Text(animal.desc_adicional)
                        .font(.body)
                }
                
                Spacer()
                
                NavigationLink(destination: AdoptionFormView(animal: animal)) {
                    Text("Solicitar Adopción")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Detalle de Animal")
    }
}

struct AnimalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailView(animal: Animal(
            id: 1,
            nombre: "Ejemplo",
            tipo: "Perro",
            color: "#FFFFFF",
            edad: "2 años",
            estado: "adopcion",
            genero: "macho",
            desc_fisica: "Descripción física de ejemplo",
            desc_personalidad: "Descripción de personalidad de ejemplo",
            desc_adicional: "Descripción adicional de ejemplo",
            esterilizado: 1,
            vacunas: 1,
            imagen: "https://example.com/image.jpg",
            equipo: "Equipo de ejemplo",
            region: "RM",
            comuna: "nose",
            url: "https://example.com"
        ))
    }
}
