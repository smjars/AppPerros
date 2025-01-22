//
//  LoginView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginMode: Bool = true
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            Picker(selection: $isLoginMode, label: Text("Modo Registro")) {
                Text("Iniciar Sesión").tag(true)
                Text("Registrarse").tag(false)
            }.pickerStyle(SegmentedPickerStyle())
                .padding()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()

            SecureField("Contraseña", text: $password)
                .padding()

            Button(action: {
                handleAction()
            }) {
                Text(isLoginMode ? "Iniciar Sesión" : "Registrarse")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
        }
        .padding()
    }

    private func handleAction() {
        if isLoginMode {
            loginUser()
        } else {
            signUpUser()
        }
    }

    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Falló iniciar sesión: \(error.localizedDescription)"
                return
            }
            // Handle successful login
        }
    }

    private func signUpUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Falló iniciar registrarse: \(error.localizedDescription)"
                return
            }
            // Save user data to Firestore
            guard let uid = result?.user.uid else { return }
            let userData = ["email": email]
            Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    errorMessage = "Fallo guardar datos de usuario: \(error.localizedDescription)"
                    return
                }
                // Handle successful sign up
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
