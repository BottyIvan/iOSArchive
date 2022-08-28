//
//  MainContentView.swift
//  archive
//
//  Created by Ivan Bottigelli on 13/08/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainContentView: View {
    
    // classi + metodi d'ambiente
    @EnvironmentObject var authenticator: Authenticator
    
    @Environment(\.colorScheme) var colorScheme
    let darkGreyColor = Color(red: 29.0/255.0, green: 27.0/255.0, blue: 30.0/255.0, opacity: 1.0)
    
    static let gradientStart = Color.white.opacity(0)
    static let gradientEnd = Color.black.opacity(0.1)
    
    @State private var searchText = ""
    
    let defaults = UserDefaults.standard
    
    @State var results = [Item]()
    
    var body: some View {
        
        let username = defaults.string(forKey: "username") ?? "null"
        let password = defaults.string(forKey: "password") ?? "null"
        
        ScrollView {
            VStack(spacing: 16) {
                ForEach (filteredNameItem, id: \.id) { item in
                    
                    NavigationLink (destination: ItemView(article: item)) {
                        VStack(alignment: .leading, spacing: 6) {
                            
                            HStack (alignment: .center) {
                                Spacer()
                                WebImage(url: URL(string: "https://www.thomasmaneggia.it/archivio/img"+item.imageItem))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 220)
                                    .frame(maxWidth: UIScreen.main.bounds.width - 80)
                                    .clipped()
                                Spacer()
                            }
                            .overlay(content: {
                                Rectangle()
                                    .fill(LinearGradient(
                                        gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                                        startPoint: .init(x: 0.5, y: 0),
                                        endPoint: .init(x: 0.5, y: 0.6)
                                    ))
                                    .frame(height: 220)
                            })
                            .background(Color.white)
                            .clipped()
                            .cornerRadius(16)
                            
                            VStack(spacing: 6) {
                                HStack {
                                    Text(item.nameItem)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(3)
                                        .font(Font.title2.bold())
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(item.descriptionItem)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(3)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }
                            .frame(height: 110)
                        }
                        .padding(15)
                        .background(colorScheme == .dark ? darkGreyColor : Color.white)
                        .frame(maxWidth: UIScreen.main.bounds.width - 50, alignment: .leading)
                        .contextMenu {
                            Button() { // 👈 This argument
                            } label: {
                                Label("View", systemImage: "eye")
                            }
                            Divider()
                            Button(role: .destructive) { // 👈 This argument
                                // delete something
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .clipped()
                        .cornerRadius(16)
                        .shadow(color: colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                        
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search by name...")
            .onAppear(perform: {
                print("caricata la view principale")
                print(authenticator.needsAuthentication)
                if (!authenticator.needsAuthentication) {
//                    utilFetchData.fetch_data(query: "all")
                    let request = MultipartFormDataRequest(url: URL(string: "https://www.thomasmaneggia.it/webservices/api.php")!)
                    request.addTextField(named: "action", value: "fetch")
                    request.addTextField(named: "all", value: "")
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
                    print("caricati i dati")
                }
            })
            .frame(maxWidth: .infinity)
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button(action: {}) {
                            Label("Aggiungi", systemImage: "plus.circle")
                        }
                        
                        Button(action: {authenticator.logout()}) {
                            Label("Logout", systemImage: "square.and.pencil.circle.fill")
                        }
                    }
                label: {Label("Opzioni", systemImage: "ellipsis.circle")}
                }
            }
        }
    }
    
    var filteredNameItem: [Item] {
        if searchText.isEmpty {
            return results
        } else {
            return results.filter {
                $0.nameItem.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
}

//struct MainContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainContentView()
//            .onAppear()
//            .environmentObject(Authenticator())
//    }
//}
