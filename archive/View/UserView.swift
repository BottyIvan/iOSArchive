//
//  UserView.swift
//  archive
//
//  Created by Ivan Bottigelli on 01/10/22.
//

import SwiftUI

struct UserView: View {
    
    // classi + metodi d'ambiente
    @EnvironmentObject var authenticator: Authenticator

    var body: some View {
        
        VStack(alignment: .leading, content: {
            List{
                Text("Username: N.D.")
                Text("Password: N.D.")
                Button(action: {authenticator.logout()}) {
                    Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                }
                
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
