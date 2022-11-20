//
//  UserView.swift
//  archive
//
//  Created by Ivan Bottigelli on 01/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserView: View {
    
    // classi + metodi d'ambiente
    @EnvironmentObject var authenticator: Authenticator

    let lightGreyColor = Color(red: 238.0/255.0, green: 237.0/255.0, blue: 240.0/255.0, opacity: 1.0)
    let whitesmokeColor = Color(red: 96.0/255.0, green: 96.0/255.0, blue: 95.0/255.0, opacity: 1.0)
    let darkGreyColor = Color(red: 29.0/255.0, green: 27.0/255.0, blue: 30.0/255.0, opacity: 1.0)
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack(alignment: .leading, content: {
            List{
                HStack{
                    Spacer()
                    Image("userNoPhoto")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .cornerRadius(100)
                    Spacer()
                }
                .listRowBackground(colorScheme == .dark ? darkGreyColor : lightGreyColor)
                Section("USER INFO", content: {
                    Text("Username: N.D.")
                    Text("Password: N.D.")
                })
                Section("SETTING APP", content: {
                    Button(action: {authenticator.logout()}) {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                    }
                })
            }
        })
        .navigationTitle("Settings")
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
