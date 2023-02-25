//
//  ContentView.swift
//  AnimationMacApp
//
//  Created by Anzer Arkin on 08.12.22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            TextChangeView()
        }
        .ignoresSafeArea()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
