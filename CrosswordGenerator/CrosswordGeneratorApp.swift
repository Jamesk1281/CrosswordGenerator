//
//  CrosswordGeneratorApp.swift
//  CrosswordGenerator
//
//  Created by James . on 7/1/25.
//

import SwiftUI

@main
struct CrosswordGeneratorApp: App {
    @StateObject var vm = CrosswordViewModel()
    
    var body: some Scene {
        WindowGroup {
            CrosswordView(vm: vm)
        }
    }
}
