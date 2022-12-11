//
//  AddProductView.swift
//  archive
//
//  Created by Ivan Bottigelli on 09/12/22.
//

import SwiftUI

struct AddProductView: View {

    @State var nameItem: String = ""
    @State var descriptionItem: String = ""
    @State var typeItem: String = ""
    @State var prizeItem: Int = 0
    @State var quantityItem: Int = 0
    @State var codeItem: String = ""
    @State var availableItem: Bool = true
    
    let defaults = UserDefaults.standard
    
    @State private var showingAlert = false
    @State var refresh: Bool = false

    var body: some View {
        
        let username = defaults.string(forKey: "username") ?? "null"
        let password = defaults.string(forKey: "password") ?? "null"
        let user_id = defaults.string(forKey: "user_id") ?? "null"
        
        NavigationView {
            Form() {
                List() {
                    Section(header: Text("Titolo + Descrizione")) {
                        TextField("Titolo", text: $nameItem)
                        TextEditor(text: $descriptionItem)
                            .frame(maxHeight: 300)
                    }
                    Section(header: Text("Type")) {
                        TextField("Tipo", text: $typeItem)
                    }
                    Section(header: Text("Costo")) {
                        TextField("Costo", value: $prizeItem, format: .number)
                    }
                    //                    Section(header: Text("Posizione")) {
                    //                        TextField("Posizione", value: $article.positionItem, format: ))
                    //                    }
                    Section(header: Text("Quantità")) {
                        Picker("Quantità", selection: $quantityItem, content: {
                            ForEach(0..<100, id: \.self, content: { number in
                                Text("\(number)")
                            })
                        })
                    }
                    Section(header: Text("Codice")) {
                        TextField("Codice", text: $codeItem)
                    }
                    Section(header: Text("Disponibilità")) {
                        Toggle("Disponibilità", isOn: $availableItem)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm", action: {
                        let request = MultipartFormDataRequest(url: URL(string: "https://www.thomasmaneggia.it/webservices/api.php")!)
                        request.addTextField(named: "action", value: "insert")
                        request.addTextField(named: "username", value: username)
                        request.addTextField(named: "password", value: password)
                        request.addTextField(named: "user_id", value: user_id)
                        request.addTextField(named: "nameItem", value: nameItem)
                        request.addTextField(named: "descriptionItem", value: descriptionItem)
                        request.addTextField(named: "typeItem", value: typeItem)
                        request.addTextField(named: "prizeItem", value: String(format: "%f", prizeItem))
                        request.addTextField(named: "quantityItem", value: String(quantityItem))
                        request.addTextField(named: "codeItem", value: codeItem)
                        request.addTextField(named: "availableItem", value: String(availableItem))
                        let task = URLSession.shared.dataTask(with: request.asURLRequest()) { data, response, error in
                            if let data = data {
                                print("il server ha restiutio la risposta")
                                if let response = try? JSONDecoder().decode(responseAddedItem.self, from: data) {
                                    print(response)
                                    if(response.mysql_error == 0) {
                                        showingAlert = true
                                    }
                                }
                                
                                do {
                                    try JSONDecoder().decode(responseAddedItem.self, from: data)
                                } catch let error {
                                    print("errore !!!!!!!!!!!!")
                                    print(error)
                                }
                            }
                        }
                        task.resume()
                    })
                    .alert("Added successfully", isPresented: $showingAlert) {Button("OK", role: .cancel) {update()}}
                }
            }
            .navigationTitle("Add to @\(username) archive")
        }
        .interactiveDismissDisabled(true)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func update() {
       refresh.toggle()
    }
}

//struct AddProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddProductView()
//    }
//}
