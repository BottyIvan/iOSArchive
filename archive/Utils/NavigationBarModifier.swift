//
//  NavigationBarModifier.swift
//  archive
//
//  Created by Ivan Bottigelli on 11/12/22.
//

import Foundation
import SwiftUI

struct NavigationBarModifier: ViewModifier {
    let color: Color
    let material: Material
    let hidden: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            // View inserted behind the status bar
            VStack {
                GeometryReader { geo in
                    color
                        .background(material) // SwiftUI 3+ only
                        .frame(height: geo.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
            
            content
        }
        .statusBar(hidden: hidden) // visibility
    }
}

extension View {
    func statusBarStyle(color: Color = .clear,
                        material: Material = .bar,
                        hidden: Bool = false) -> some View {
        self.modifier(NavigationBarModifier(color: color,
                                             material: material,
                                             hidden: hidden))
    }
}
