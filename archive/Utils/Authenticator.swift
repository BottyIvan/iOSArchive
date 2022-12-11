//
//  Authenticator.swift
//  archive
//
//  Created by Ivan Bottigelli on 15/08/22.
//

import Foundation

class Authenticator: ObservableObject {
    
    @Published var needsAuthentication: Bool
    @Published var isAuthenticating: Bool
    @Published var erroLogin: Bool
    @Published var errorLoginMsg: String = ""
    
    let defaults = UserDefaults.standard
    
    init() {
        if(defaults.bool(forKey: "needsAuthentication") == false && defaults.string(forKey: "username") != nil){
            self.needsAuthentication = false
        } else {
            self.needsAuthentication = true
        }
        
        //        self.needsAuthentication = defaults.bool(forKey: "needsAuthentication") ?? true
        self.isAuthenticating = false
        self.erroLogin = true
    }
    
    func login(username: String, password: String) {
        self.isAuthenticating = true
        let str_url = "https://www.thomasmaneggia.it/webservices/api.php?username=\(username)&password=\(password)"
        guard let url = URL(string: str_url)
        else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "username=\(username)&password=\(password)";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(mUserProfile.self, from: data) {
                    DispatchQueue.main.async {
                        let msg = response
                        if(msg.error == 0) {
                            // salvo le credenziali + il successo del login
                            UserDefaults.standard.set(username, forKey: "username")
                            UserDefaults.standard.set(password, forKey: "password")
                            
                            UserDefaults.standard.set(msg.user_id, forKey: "user_id")
                            
                            self.isAuthenticating = false
                            self.needsAuthentication = false
                            self.erroLogin = false
                            self.errorLoginMsg = ""
                            
                            UserDefaults.standard.set(false, forKey: "needsAuthentication")
                            
                        } else {
                            self.isAuthenticating = true
                            self.needsAuthentication = true
                            self.erroLogin = true
                            self.errorLoginMsg = msg.msg
                        }
                        //                    print(msg.error)
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func isLogged() {
        if(defaults.bool(forKey: "needsAuthentication") == false && defaults.string(forKey: "username") != nil){
            self.needsAuthentication = false
        } else {
            self.needsAuthentication = true
        }
    }
    
    func logout() {
        self.needsAuthentication = true
        // rimuovo i dati utente + il successo del login
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "needsAuthentication")
    }
}
