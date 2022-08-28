//
//  UtilFetchData.swift
//  archive
//
//  Created by Ivan Bottigelli on 15/08/22.
//

import Foundation

class UtilFetchData: ObservableObject {
    
    let defaults = UserDefaults.standard
    
    @Published var results = [Item]()
    
    func fetch_data(query: String = "") {
        
        self.results = [Item]()
        
        let username = defaults.string(forKey: "username") ?? "null"
        let password = defaults.string(forKey: "password") ?? "null"
        
        //        let str_url = "https://jsonplaceholder.typicode.com/todos";
        let str_url = "https://www.thomasmaneggia.it/webservices/api.php"
        print(str_url)
        guard let url = URL(string: str_url)
        else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "username=\(username)&password=\(password)&\(query)";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                let decoder = JSONDecoder()
                
                if let jsonPetitions = try? decoder.decode(Items.self, from: data) {
//                    print(jsonPetitions)
                    DispatchQueue.main.async {
                        self.results = jsonPetitions.item
                    }
                }
                
//                do {
//                    try decoder.decode(Items.self, from: data)
//                } catch let error {
//                    print("errore !!!!!!!!!!!!")
//                    print(error)
//                }
                
                if let error = error {
                    print(error)
                }
            }
        }
        
        task.resume()
        
    }
    
}
