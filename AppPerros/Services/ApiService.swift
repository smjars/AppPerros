//
//  ApiService.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//
import Foundation

class ApiService {
    func fetchAnimals(completion: @escaping ([Animal]) -> Void) {
        guard let url = URL(string: "https://huachitos.cl/api/animales") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let response = try? decoder.decode(AnimalResponse.self, from: data) {
                    DispatchQueue.main.async {
                        completion(response.data)
                    }
                }
            }
        }.resume()
    }
}
