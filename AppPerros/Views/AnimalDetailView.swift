//
//  ItemDetailView.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.title)
                .font(.largeTitle)
                .padding(.bottom, 10)
            
            Text(item.description)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detail")
    }
}

#Preview {
    ItemDetailView()
}
