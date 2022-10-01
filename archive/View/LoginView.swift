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
    
    @Environment(\.colorScheme) var colorScheme
    
    static let gradientStart = Color.white.opacity(0)
    static let gradientEnd = Color.black.opacity(0.1)
    
    @EnvironmentObject var authenticator: Authenticator
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                Image("logoApp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(16)
                    .shadow(color: colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                Spacer()
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                Text(authenticator.errorLoginMsg)
            }
            HStack{
                Spacer()
                Button(authenticator.isAuthenticating ? "Please wait..." : "Log in") {
                          authenticator.login(username: username, password: password)
                }
//                .disabled(isLoginDisabled)
            }
            Spacer()
            Text("created with ❤️ in milan.")
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
