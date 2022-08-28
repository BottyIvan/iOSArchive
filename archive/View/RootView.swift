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
        NavigationView {
            HStack() {
                if (authenticator.needsAuthentication == false) {
                    MainContentView()
                }
            }.sheet(isPresented: $authenticator.needsAuthentication) {
                LoginView()
                    .environmentObject(authenticator) // see note
            }
        }.navigationViewStyle(.stack)
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
