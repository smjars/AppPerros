//
//  LoginView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginMode: Bool = true
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            Picker(selection: $isLoginMode, label: Text("Login Mode")) {
                Text("Login").tag(true)
                Text("Sign Up").tag(false)
            }.pickerStyle(SegmentedPickerStyle())
                .padding()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()

            SecureField("Password", text: $password)
                .padding()

            Button(action: {
                handleAction()
            }) {
                Text(isLoginMode ? "Login" : "Sign Up")
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
                errorMessage = "Failed to login: \(error.localizedDescription)"
                return
            }
            // Handle successful login
        }
    }

    private func signUpUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Failed to sign up: \(error.localizedDescription)"
                return
            }
            // Save user data to Firestore
            guard let uid = result?.user.uid else { return }
            let userData = ["email": email]
            Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    errorMessage = "Failed to save user data: \(error.localizedDescription)"
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
