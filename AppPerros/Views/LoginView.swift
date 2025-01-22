//
//  LoginView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

/*
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginMode: Bool = true
    @State private var errorMessage: String = ""
    @Binding var isUserLoggedIn: Bool
    
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
            // Manejar inicio de sesión exitoso
            isUserLoggedIn = true
        }
    }
    
    private func signUpUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Falló registrarse: \(error.localizedDescription)"
                return
            }
            // Guardar datos del usuario en Firestore
            guard let uid = result?.user.uid else { return }
            let userData = ["email": email]
            Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    errorMessage = "Fallo guardar datos de usuario: \(error.localizedDescription)"
                    return
                }
                // Manejar registro exitoso
                isUserLoggedIn = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isUserLoggedIn: .constant(false))
    }
}
*/

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginMode: Bool = true
    @State private var errorMessage: String = ""
    @Binding var isUserLoggedIn: Bool
    
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
            
            Button(action: {
                handleGoogleSignIn()
            }) {
                HStack {
                    Image(systemName: "globe")
                    Text("Iniciar con Google")
                }
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
            isUserLoggedIn = true
        }
    }
    
    private func signUpUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Falló registrarse: \(error.localizedDescription)"
                return
            }
            guard let uid = result?.user.uid else { return }
            let userData = ["email": email]
            Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    errorMessage = "Fallo guardar datos de usuario: \(error.localizedDescription)"
                    return
                }
                isUserLoggedIn = true
            }
        }
    }
    
    private func handleGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            if let error = error {
                errorMessage = "Falló iniciar sesión con Google: \(error.localizedDescription)"
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else { return }
            let accessToken = user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    errorMessage = "Falló iniciar sesión con Google: \(error.localizedDescription)"
                    return
                }
                
                // Guardar datos del usuario en Firestore
                guard let uid = result?.user.uid else { return }
                let userData = ["email": result?.user.email ?? ""]
                Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                    if let error = error {
                        errorMessage = "Fallo guardar datos de usuario: \(error.localizedDescription)"
                        return
                    }
                    isUserLoggedIn = true
                }
            }
        }
    }
    
    private func getRootViewController() -> UIViewController {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return UIViewController()
        }
        return rootViewController
    }
}
