//
//  ItemView.swift
//  archive
//
//  Created by Ivan Bottigelli on 15/08/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    let whitesmokeColor = Color(red: 96.0/255.0, green: 96.0/255.0, blue: 95.0/255.0, opacity: 1.0)
    let darkGreyColor = Color(red: 29.0/255.0, green: 27.0/255.0, blue: 30.0/255.0, opacity: 1.0)
    
    let defaults = UserDefaults.standard
    
    @State var results = [Item]()
    
    var article: Item
    
    @State private var showingEditViewSheet = false
    
    static let gradientStart = Color.white.opacity(0)
    static let gradientEnd = Color.black.opacity(0.1)
    
    @State var opacity: Double = 0
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        let username = defaults.string(forKey: "username") ?? "null"
        let password = defaults.string(forKey: "password") ?? "null"
        
        ScrollView(.vertical, showsIndicators: true, content: {
            //        List(content: {
            
            VStack(alignment: .leading, spacing: 0, content: {
                VStack(content: {
                    GeometryReader { geometry in
                        
                        if geometry.frame(in: .global).minY <= 0 {
                            
                            WebImage(url: URL(string: "https://www.thomasmaneggia.it/archivio/img"+article.imageItem))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(y: geometry.frame(in: .global).minY/9)
                                .clipped()
                            
                        } else {
                            
                            WebImage(url: URL(string: "https://www.thomasmaneggia.it/archivio/img"+article.imageItem))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                                .clipped()
                                .offset(y: -geometry.frame(in: .global).minY)
                        }
                        
                    }
                    .frame(height: 400)
                    
                })
                .overlay(content: {
                                    
                    ZStack {
                        Text(article.nameItem)
                            .font(Font.title2.bold())
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .position(x: 208, y: 375)
//                            .foregroundColor(.white)
                    }
                    
                    Rectangle()
                        .fill(LinearGradient(
                            gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                            startPoint: .init(x: 0.5, y: 0),
                            endPoint: .init(x: 0.5, y: 0.6)
                        ))
                        .frame(height: 400)
                })
                //                .opacity(self.opacity)
            })
            
            VStack(alignment: .leading, spacing: 16, content: {
                
                Text(article.descriptionItem)
                Text("Costo: \(article.prizeItem)")
                Text("Posizione: \(article.positionItem ?? "")")
                Text("Quantità: \(article.quantityItem)")
                Text("Codice: \(article.codeItem)")
                Text("Disponibile: "+(article.availableItem ? "Sì" : "No"))
                
            })
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            
            VStack (alignment: .leading, spacing: 0, content: {
                Text("Altri prodotti in \(article.typeItem)")
                    .fontWeight(.bold)
                    .padding()
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(alignment: .center, spacing: 16, content: {
                        ForEach (results, id: \.id) { itemList in
                            NavigationLink(destination: ItemView(article: itemList), label: {
                                VStack(alignment: .leading, spacing: 10, content: {
                                    WebImage(url: URL(string: "https://www.thomasmaneggia.it/archivio/img"+itemList.imageItem))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .clipped()
                                        .cornerRadius(10)
                                    
                                    Text(itemList.nameItem)
                                        .foregroundColor(.black)
                                    
                                })
                                .frame(width: 150, height: 200)
                                .clipped()
                                
                            })
                        }
                    })
                })
                .onAppear(perform: {
                    let request = MultipartFormDataRequest(url: URL(string: "https://www.thomasmaneggia.it/webservices/api.php")!)
                    request.addTextField(named: "action", value: "fetch")
                    request.addTextField(named: "all", value: "")
                    request.addTextField(named: "type", value: article.typeItem)
                    request.addTextField(named: "username", value: username)
                    request.addTextField(named: "password", value: password)
                    let task = URLSession.shared.dataTask(with: request.asURLRequest()) { data, response, error in
                        if let data = data {
                            //                            print("il server ha restiutio la risposta")
                            if let response = try? JSONDecoder().decode(Items.self, from: data) {
                                //                                print(response)
                                DispatchQueue.main.async {
                                    self.results = response.item
                                }
                            }
                            
                            //                            do {
                            //                                try JSONDecoder().decode(Items.self, from: data)
                            //                            } catch let error {
                            //                                print("errore !!!!!!!!!!!!")
                            //                                print(error)
                            //                            }
                        }
                    }
                    task.resume()
                })
                .frame(height: 200)
            })
            .background(colorScheme == .dark ? darkGreyColor : lightGreyColor)
        })
        .safeAreaInset(edge: .bottom, content: {
            Rectangle()
                .fill(.regularMaterial)
                .frame(height: 25)
        })
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            Button(action: {showingEditViewSheet.toggle()}) {
                Label("Edit", systemImage: "square.and.pencil")
            }
            .sheet(isPresented: $showingEditViewSheet) {
                EditItemView(article: article)
            }
        }
    }
    
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView(article: results)
//    }
//}
