//
//  ConfettiView.swift
//  AnimationMacApp
//
//  Created by Anzer Arkin on 25.02.23.
//
import SwiftUI

struct Leaf: View {
    @State var animate: Bool = false
    @State var xSpeed = Double.random(in: 0.7...2)
    @State var zSpeed = Double.random(in: 1...2)
    @State var anchor = CGFloat.random(in: -10 ... -5).rounded()
    @State var alive = true
    @State var delay = Double.random(in: 0.0 ... 0.2)
    @State var lifetime = Double.random(in: 8...10)
    @State var offset = CGPoint(x: 0, y: 100)
    @State var size: CGSize = CGSize(width: CGFloat.random(in: 5.0 ... 10.0), height: CGFloat.random(in: 5.0 ... 10.0))
    @State var isCircle: Bool = Bool.random()
    @State var moveAnimation: Animation?
    @State var swing: Double = Double.random(in: -35.0 ... 35.0)
    @State var color: Color = .random
    @Binding var pos: CGPoint
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(width: isCircle ? 7.5 : size.width, height: isCircle ? 7.5 : size.height, alignment: .center)
            .cornerRadius(isCircle ? 7.5 : 0.0)
            .onAppear(perform: { animate = true })
            .rotation3DEffect(.degrees(animate ? 360:0), axis: (x: 1, y: 0, z: 0))
            .animation(Animation.linear(duration: alive ? xSpeed : 0.0).repeatForever(autoreverses: false), value: animate)
            .rotation3DEffect(.degrees(animate ? -swing : swing), axis: (x: 0, y: 0, z: 1), anchor: UnitPoint(x: 0, y: anchor))
            .animation(Animation.easeInOut(duration: zSpeed).repeatForever(autoreverses: true), value: animate)
            .opacity(alive ? 1.0 : 0.0)
            .scaleEffect(alive ? 1.0 : 0.0)
            .animation(Animation.linear(duration: lifetime), value: alive)
            .animation(moveAnimation, value: offset)
            .onAppear {
                moveAnimation = Animation.easeOut(duration: 0.5).delay(delay)
                animate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 + delay) {
                    self.alive = false
                }
                offset = CGPoint(x: CGFloat.random(in: -200.0 ... 200.0), y: CGFloat.random(in: -50.0 ... 30.0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 + delay) {
                    self.moveAnimation = .easeIn(duration: lifetime - 0.5)
                    self.offset.y += 300.0
                }
            }
            .onDisappear {
                animate = false
                xSpeed = Double.random(in: 0.7...2)
                zSpeed = Double.random(in: 1...2)
                anchor = CGFloat.random(in: -10 ... -5).rounded()
                alive = true
                lifetime = Double.random(in: 8...10)
                offset = CGPoint(x: 0, y: 100)
                moveAnimation = Animation.easeOut(duration: 0.5).delay(Double.random(in: 0.0...0.4))
                size = CGSize(width: CGFloat.random(in: 5.0 ... 10.0), height: CGFloat.random(in: 5.0 ... 10.0))
                isCircle = Bool.random()
            }
            .offset(x: offset.x, y: offset.y)
            .position(pos)
    }
}

struct ConfettiView: View {
    @State var tapped: Bool = false
    @State var animate: Bool = false
    
    @State private var pos = CGPoint(x: 100, y: 100)
    
    var body: some View {
        ZStack {
            Rectangle()
                .onTapGesture(coordinateSpace: .local) { location in
                    if !tapped {
                        tapped = true
                        pos = location
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            tapped = false
                        }
                    }
                }
                .foregroundColor(Color.gray.opacity(0.1))
            
            if tapped {
                leaves
            }
        }
    }
    
    @ViewBuilder
    var leaves: some View {
        ZStack {
            ForEach(0...20, id: \.self) { _ in
                Leaf(pos: $pos)
            }
        }
    }
}
