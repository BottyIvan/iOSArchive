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
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        let username = defaults.string(forKey: "username") ?? "null"
        
        VStack(alignment: .leading, content: {
            List{
                VStack(content: {
                    HStack{
                        Spacer()
                        Image("userNoPhoto")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .cornerRadius(100)
                        Spacer()
                    }
                    
                    Text("@\(username)")
                        .font(.title2.bold())
                })
                .listRowBackground(Color.clear)
                
                Section("SETTING APP", content: {
                    Text("Edit credentials")
                    
                    Button(action: {authenticator.logout()}) {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                    }
                })
            }
        })
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
