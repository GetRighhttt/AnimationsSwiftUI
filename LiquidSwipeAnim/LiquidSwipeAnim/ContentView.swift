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

/**
 View for Home.
 */
struct HomeView: View {
    
    /**
     Now we add the liquid swipe animation..
     */
    @State var offset: CGSize = .zero
    
    @State var showHome = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, Color("darkpurple"), .red, .green, .accentColor], startPoint: .topLeading, endPoint: .bottomTrailing)
            /**
             we set our content before the animation so it doesn't carry over into the next view.
             */
                .overlay(
                    /**
                     Content...
                     */
                    VStack {
                        Image(systemName: "moonphase.waxing.crescent")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .foregroundColor(.white)
                            .offset(x: -25)
                        
                        Text("Start!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                            .offset(x: -25)
                    }
                    
                )
                .clipShape(LiquidSwipe(offset: offset))
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
                            
                            
                            /**
                             Here is where we add in the withAnimation affect
                             */
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                offset = value.translation
                            }
                            
                        }).onEnded({ (value) in
                            
                            
                            let screen = UIScreen.main.bounds
                            withAnimation(.spring()) {
                                /**
                                 validating to move to new screen
                                 */
                                if -offset.width > screen.width / 2 {
                                    /**
                                     removing the view if so
                                     */
                                    offset.width = -screen.height
                                    showHome.toggle()
                                }
                                else {
                                    offset = .zero
                                }
                            }
                            
                        }))
                        .offset(x: 15, y: 45)
                    /**
                     hiding while dragging starts..
                     */
                        .opacity(offset == .zero ? 1: 0)
                    ,alignment: .topTrailing
                )
                .padding(.trailing) // makes the white barrier next to the gradient
            
            if showHome{
                VStack {
                    Image(systemName: "moonphase.waning.crescent")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .foregroundColor(.white)
                        .offset(x: -25)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                offset = .zero
                                showHome.toggle()
                            }
                        }
                    
                    Text("Finish!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                        .offset(x: -25)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                offset = .zero
                                showHome.toggle()
                            }
                        }
                }
            }
            
        }
    }
}

/**
 Custom shape for liquid animation that we will pass in as a clip shape in our home view!
 */
struct LiquidSwipe: Shape {
    /**
     getting offset
     */
    var offset: CGSize
    
    /**
     animating the path now..
     */
    var animatableData: CGSize.AnimatableData{
        get{ return offset.animatableData }
        set{ offset.animatableData = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            /**
             when the user moves left, we need to increase the size in the top and bottom to create
             the liquid drag effect...
             */
            let width = rect.width + (-offset.width > 0 ? offset.width: 0)
            
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
            
            /**
             from and to
             */
            let from = 80 + (offset.width)
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            
            /**
             add in more height
             */
            var to = 180 + (offset.height) + (-offset.width)
            to = to < 180 ? 180 : to
            
            /**
             the mid index
             */
            let mid: CGFloat = 80 + ((to - 80) / 2) // sets the curve
            
            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
        }
    }
    
}
