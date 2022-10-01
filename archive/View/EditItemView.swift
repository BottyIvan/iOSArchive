//
//  EditItemView.swift
//  archive
//
//  Created by Ivan Bottigelli on 17/08/22.
//

import SwiftUI

struct EditItemView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var article: Item
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        let username = defaults.string(forKey: "username") ?? "null"
        let password = defaults.string(forKey: "password") ?? "null"
        
        NavigationView {
            Form() {
                List() {
                    Section(header: Text("Titolo + Descrizione")) {
                        TextField("Titolo", text: $article.nameItem)
                        TextEditor(text: $article.descriptionItem)
                            .frame(maxHeight: 300)
                    }
                    Section(header: Text("Costo")) {
                        TextField("Costo", value: $article.prizeItem, format: .number)
                    }
//                    Section(header: Text("Posizione")) {
//                        TextField("Posizione", value: $article.positionItem, format: ))
//                    }
                    Section(header: Text("Quantità")) {
                        Picker("Quantità", selection: $article.quantityItem, content: {
                            ForEach(0..<100, id: \.self, content: { number in
                                Text("\(number)")
                            })
                        })
                    }
                    Section(header: Text("Codice")) {
                        TextField("Codice", text: $article.codeItem)
                    }
                    Section(header: Text("Disponibilità")) {
                        Toggle("Disponibilità", isOn: $article.availableItem)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm", action: {
                        let request = MultipartFormDataRequest(url: URL(string: "https://www.thomasmaneggia.it/webservices/api.php")!)
                        request.addTextField(named: "action", value: "update")
                        request.addTextField(named: "username", value: username)
                        request.addTextField(named: "password", value: password)
                        request.addTextField(named: "idItem", value: article.idItem)
                        request.addTextField(named: "nameItem", value: article.nameItem)
                        request.addTextField(named: "descriptionItem", value: article.descriptionItem)
                        request.addTextField(named: "prizeItem", value: String(format: "%f", article.prizeItem))
                        request.addTextField(named: "quantityItem", value: String(article.quantityItem))
                        request.addTextField(named: "codeItem", value: article.codeItem)
                        request.addTextField(named: "availableItem", value: String(article.availableItem))
                        let task = URLSession.shared.dataTask(with: request.asURLRequest()) { data, response, error in
                            if let data = data {
                                print("il server ha restiutio la risposta")
                                if let response = try? JSONDecoder().decode(responseUpdateItem.self, from: data) {
                                    print(response)
                                    if(response.mysql_error == 0) {
                                        dismiss()
                                    }
                                }
                                
                                do {
                                    try JSONDecoder().decode(responseUpdateItem.self, from: data)
                                } catch let error {
                                    print("errore !!!!!!!!!!!!")
                                    print(error)
                                }
                            }
                        }
                        task.resume()
                    })
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: {
                        dismiss()
                    })
                }
            }
            .navigationTitle(article.nameItem)
        }
        .interactiveDismissDisabled(true)
        .navigationBarTitleDisplayMode(.inline)
    }

}

//struct EditItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditItemView()
//    }
//}
