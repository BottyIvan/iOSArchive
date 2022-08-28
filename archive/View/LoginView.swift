//
//  ContentView.swift
//  archive
//
//  Created by Ivan Bottigelli on 13/08/22.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var termsAccepted = false
        
    @State var username: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var authenticator: Authenticator
    
    var body: some View {
        VStack {
            Text("Archive")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("by thaG33k")
                .font(.footnote)
                .fontWeight(.light)
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Text(authenticator.errorLoginMsg)
            HStack{
                Spacer()
                Button(authenticator.isAuthenticating ? "Please wait..." : "Log in") {
                          authenticator.login(username: username, password: password)
                }
//                .disabled(isLoginDisabled)
            }
        }
        .padding()
        .interactiveDismissDisabled(!termsAccepted)

    }
    
    private var isLoginDisabled: Bool {
      authenticator.isAuthenticating || username.isEmpty || password.isEmpty
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(Authenticator())
    }
}
