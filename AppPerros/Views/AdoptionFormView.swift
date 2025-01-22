//
//  AdoptionFormView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//
/*
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AdoptionFormView: View {
    let animal: Animal
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var reason: String = ""
    @State private var userId: String? = Auth.auth().currentUser?.uid
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Section(header: Text("Información del Animal")) {
                Text("Nombre: \(animal.nombre)")
                    .font(.headline)
                Text("Tipo: \(animal.tipo)")
                    .font(.subheadline)
                Text("Edad: \(animal.edad)")
                    .font(.subheadline)
                Text("Descripción Física: \(animal.desc_fisica)")
                    .font(.subheadline)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
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
                    saveFormData()
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
        }
        .navigationTitle("Formulario de Adopción")
        .padding()
        .onAppear(perform: loadFormData)
    }
    
    private func saveFormData() {
        guard let userId = userId else { return }
        
        let formData: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "address": address,
            "reason": reason,
            "animal": [
                "nombre": animal.nombre,
                "tipo": animal.tipo,
                "edad": animal.edad,
                "desc_fisica": animal.desc_fisica
            ]
        ]
        
        Firestore.firestore().collection("adoptionForms").document(userId).setData(formData) { error in
            if let error = error {
                print("Error guardando datos: \(error.localizedDescription)")
                return
            }
            print("Datos guardados exitosamente")
        }
    }
    
    private func loadFormData() {
        guard let userId = userId else { return }
        
        Firestore.firestore().collection("adoptionForms").document(userId).getDocument { document, error in
            if let error = error {
                print("Error cargando datos: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                name = data?["name"] as? String ?? ""
                email = data?["email"] as? String ?? ""
                phone = data?["phone"] as? String ?? ""
                address = data?["address"] as? String ?? ""
                reason = data?["reason"] as? String ?? ""
            }
        }
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
*/
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AdoptionFormView: View {
    let animal: Animal
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var reason: String = ""
    @State private var userId: String? = Auth.auth().currentUser?.uid
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Section(header: Text("Información del Animal")) {
                Text("Nombre: \(animal.nombre)")
                    .font(.headline)
                Text("Tipo: \(animal.tipo)")
                    .font(.subheadline)
                Text("Edad: \(animal.edad)")
                    .font(.subheadline)
                Text("Descripción Física: \(animal.desc_fisica)")
                    .font(.subheadline)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
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
                    saveFormData()
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Solicitud Enviada"), message: Text("Los datos se guardaron exitosamente."), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Formulario de Adopción")
        .padding()
        .onAppear(perform: loadFormData)
    }
    
    private func saveFormData() {
        guard let userId = userId else { return }
        
        let formData: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "address": address,
            "reason": reason,
            "animal": [
                "nombre": animal.nombre,
                "tipo": animal.tipo,
                "edad": animal.edad,
                "desc_fisica": animal.desc_fisica
            ]
        ]
        
        Firestore.firestore().collection("adoptionForms").document(userId).setData(formData) { error in
            if let error = error {
                print("Error guardando datos: \(error.localizedDescription)")
                return
            }
            print("Datos guardados exitosamente")
            showAlert = true
        }
    }
    
    private func loadFormData() {
        guard let userId = userId else { return }
        
        Firestore.firestore().collection("adoptionForms").document(userId).getDocument { document, error in
            if let error = error {
                print("Error cargando datos: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                name = data?["name"] as? String ?? ""
                email = data?["email"] as? String ?? ""
                phone = data?["phone"] as? String ?? ""
                address = data?["address"] as? String ?? ""
                reason = data?["reason"] as? String ?? ""
            }
        }
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
