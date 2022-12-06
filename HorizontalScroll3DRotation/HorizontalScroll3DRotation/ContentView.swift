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
                ForEach(0 ..< 10) { item in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 30)
                            .fill(LinearGradient(colors: [.black,.pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .rotation3DEffect(
                                Angle(degrees: Double(geometry.frame(in: .global).minX) / -20),
                                axis: (x: 0.0, y: 4.0, z: 0.0))
                    }
                }
                .frame(width: 300, height: 300)
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
