//
//  AdoptionFormView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import SwiftUI

struct AdoptionFormView: View {
    let animal: Animal
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var reason: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Información Personal")) {
                TextField("Nombre", text: $name)
                TextField("Email", text: $email)
                TextField("Teléfono", text: $phone)
                TextField("Dirección", text: $address)
            }
            
            Section(header: Text("Motivo de Adopción")) {
                TextEditor(text: $reason)
                    .frame(height: 100)
            }
            
            Button(action: {
                // Acción para enviar el formulario
            }) {
                Text("Enviar Solicitud")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Formulario de Adopción")
        .padding()
    }
}

struct AdoptionFormView_Previews: PreviewProvider {
    static var previews: some View {
        AdoptionFormView(animal: Animal(
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
            comuna: "Santiago",
            url: "https://example.com"
        ))
    }
}

