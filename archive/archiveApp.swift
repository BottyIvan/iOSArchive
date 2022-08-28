//
//  archiveApp.swift
//  archive
//
//  Created by Ivan Bottigelli on 13/08/22.
//
// THIS PROJECT WAS CREATED WITH THIS HELP
//
// Build Your Own Blog App With SwiftUI : https://medium.com/p/3ee8196ecb84
// Drop shadows : https://morioh.com/p/973148290ab8
// The Complete Guide to NavigationView in SwiftUI : https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
// Styling List Views : https://peterfriese.dev/posts/swiftui-listview-part3/
// How to add bar items to a navigation view : https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-bar-items-to-a-navigation-view
// How to present a Bottom Sheet in iOS 15 with UISheetPresentationController : https://sarunw.com/posts/bottom-sheet-in-ios-15-with-uisheetpresentationcontroller/
// Building a login screen using modal views in SwiftUI : https://medium.com/geekculture/building-a-login-screen-using-modal-views-in-swiftui-f85915bbfb09
// Working with UserDefaults in Swift : https://www.appypie.com/userdefaults-swift-setting-getting-data-how-to
// Advanced Error Handling in Swift 5 : https://levelup.gitconnected.com/advanced-error-handling-in-swift-5-38795c30b7c
// Parsing JSON using the Codable protocol : https://www.hackingwithswift.com/read/7/3/parsing-json-using-the-codable-protocol
// How to respond to view lifecycle events: onAppear() and onDisappear() : https://www.hackingwithswift.com/quick-start/swiftui/how-to-respond-to-view-lifecycle-events-onappear-and-ondisappear
// SwiftUI 5.5 API Data to List View : https://paulallies.medium.com/swiftui-5-5-api-data-to-list-view-776c69a456d3
// How to Fetch data from APIs in SwiftUI : https://medium.com/swlh/fetch-data-from-apis-in-swiftui-74b4b50f20e9
// HTTP Post Requests in Swift for beginners : https://developer.apple.com/forums/thread/666662
// NavigationLink View in .toolbar(...): unwanted nested child views on model change : https://www.hackingwithswift.com/forums/swiftui/navigationlink-view-in-toolbar-unwanted-nested-child-views-on-model-change/9844
// Quick guide on toolbars in SwiftUI : https://tanaschita.com/20220509-quick-quide-on-toolbars-in-swiftui/
// SOLVED: Swift Error - No exact matches in call to instance method 'appendInterpolation' : https://www.hackingwithswift.com/forums/swiftui/swift-error-no-exact-matches-in-call-to-instance-method-appendinterpolation/10472
// How to format a TextField for numbers : https://www.hackingwithswift.com/quick-start/swiftui/how-to-format-a-textfield-for-numbers
// How to create a toggle switch : https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-toggle-switch
// Stretchy Header And Parallax Scrolling In SwiftUI : https://blckbirds.com/post/stretchy-header-and-parallax-scrolling-in-swiftui/
// Adding settings to your iOS app : https://abhimuralidharan.medium.com/adding-settings-to-your-ios-app-cecef8c5497
//

import SwiftUI

@main
struct archiveApp: App {
    
    @StateObject var authenticator = Authenticator()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authenticator)
        }
    }
}
