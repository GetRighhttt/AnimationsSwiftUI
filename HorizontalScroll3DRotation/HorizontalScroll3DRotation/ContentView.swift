//
//  ContentView.swift
//  HorizontalScroll3DRotation
//
//  Created by Stefan Bayne on 12/6/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0 ..< 20) { item in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 30)
                            .fill(LinearGradient(colors: [randomColor(),randomColor()], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .rotation3DEffect(
                                Angle(degrees: Double(geometry.frame(in: .global).minX) / -20),
                                axis: (x: 0.0, y: 4.0, z: 0.0))
                    }
                }
                .frame(width: 300, height: 300)
            }
        }.padding()
    }
    
    private func randomColor() -> Color {
            let colors: [Color] = [.red, .yellow, .green, .blue, .purple, .orange]
            let index = Int.random(in: 0...5)
            
            return colors[index]
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
