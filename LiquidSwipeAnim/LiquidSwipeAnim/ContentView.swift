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
    
    /**
     Now we add the liquid swipe animation..
     */
    @State var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, Color("darkpurple"), .red, .green, .accentColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(LiquidSwipe())
                .ignoresSafeArea()
            /**
             adding in the arrow now as an overlay...
             
             .. then we add the drag gesture
             */
                .overlay(
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged({ (value) in
                            
                            let offset = value.translation
                            print(offset)
                            
                        }).onEnded({ (value) in
                            
                            
                            
                        }))
                        .offset(x: 15, y: 45)
                    ,alignment: .topTrailing
                )
                .padding(.trailing) // makes the white barrier next to the gradient
            
        }
    }
}

/**
 Custom shape for liquid animation that we will pass in as a clip shape in our home view!
 */
struct LiquidSwipe: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            let width = rect.width
            
            /**
             Constructing rectangular shape..
             */
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            /**
             Now constructing curve shape to drag liquid animation!
             */
            path.move(to: CGPoint(x: width, y: 80))
            
            let mid: CGFloat = 80 + ((180 - 80) / 2) // sets the curve
            path.addCurve(to: CGPoint(x: width, y: 180), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
        }
    }
    
}
