//
//  MakingWatchTheBirdieApp.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.07.2023.
//

import SwiftUI

@main
struct MakingWatchTheBirdieApp: App {
    
    @State var accessLevel: AccessLevel = .kids
    
    var body: some Scene {
        WindowGroup {
            ContentView(accessLevel: $accessLevel)
        }
    }
}
