//
//  RootView.swift
//  archive
//
//  Created by Ivan Bottigelli on 15/08/22.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var authenticator: Authenticator
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        let username = defaults.string(forKey: "username") ?? "null"
        
        TabView {
            NavigationView {
                HStack() {
                    if (authenticator.needsAuthentication == false) {
                        MainContentView(toQuery: "home")
                    }
                }.sheet(isPresented: $authenticator.needsAuthentication) {
                    LoginView()
                        .environmentObject(authenticator) // see note
                }
            }
            .statusBarStyle(material: .regularMaterial)
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            NavigationView {
                HStack() {
                    if (authenticator.needsAuthentication == false) {
                        MainContentView(toQuery: "basket")
                    }
                }.sheet(isPresented: $authenticator.needsAuthentication) {
                    LoginView()
                        .environmentObject(authenticator) // see note
                }
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "basket")
                Text("Basket")
            }
            NavigationView {
                HStack() {
                    if (authenticator.needsAuthentication == false) {
                        AddProductView()
                    }
                }.sheet(isPresented: $authenticator.needsAuthentication) {
                    LoginView()
                        .environmentObject(authenticator) // see note
                }
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "plus.circle.fill")
                Text("Add to")
            }
            NavigationView {
                HStack() {
                    if (authenticator.needsAuthentication == false) {
                        UserView()
                    }
                }.sheet(isPresented: $authenticator.needsAuthentication) {
                    LoginView()
                        .environmentObject(authenticator) // see note
                }
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("@\(username)")
            }
        }
    }
}

//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//            .environmentObject(Authenticator())
//            .environmentObject(UtilFetchData())
//        
//    }
//}
