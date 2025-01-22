//
//  ContentView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isUserLoggedIn = Auth.auth().currentUser != nil
    
    var body: some View {
        if isUserLoggedIn {
            AnimalListView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
