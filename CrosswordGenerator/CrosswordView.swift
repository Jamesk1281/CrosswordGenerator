//
//  ContentView.swift
//  CrosswordGenerator
//
//  Created by James . on 7/1/25.
//

import SwiftUI
import SwiftData

struct CrosswordView: View {
    @ObservedObject var vm: CrosswordViewModel
    
    var body: some View {
        
    }
    
    struct CrosswordSquareView: View { // ASSIGN THE NUMBERS HERE
        
        var body: some View {
            
        }
    }
}

#Preview {
    CrosswordView(vm: CrosswordViewModel())
}
