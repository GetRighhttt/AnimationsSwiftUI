//
//  ContentView.swift
//  LiquidSwipeAnim
//
//  Created by Stefan Bayne on 12/6/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 View for Home.
 */
struct HomeView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("darkpurple"), Color("lightpurple")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
        }
    }
}
