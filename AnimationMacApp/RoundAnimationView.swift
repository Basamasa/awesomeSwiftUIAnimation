//
//  RoundAnimationView.swift
//  AnimationMacApp
//
//  Created by Anzer Arkin on 25.02.23.
//

import SwiftUI

struct RoundAnimationView: View {
    
    @State private var height: CGFloat = 30
    @State private var angleX: Double = 0
    @State private var angleY: Double = 0
    
    let numberOfRectangles: Int = 60
    let timeBetweenAnimations: Double = 1.5
    let angleAmount: Double = 10
    
    var width: CGFloat {
        CGFloat(360 / numberOfRectangles) * 0.9
    }
    
    var animation: Animation {
        .easeInOut(duration: timeBetweenAnimations)
    }
    
    var body: some View {
        ZStack {
            Image(systemName: "figure.mind.and.body")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .opacity(0.3)
                .rotation3DEffect(.degrees(angleX), axis: (x: 1, y: 0, z: 0))
                .rotation3DEffect(.degrees(angleY), axis: (x: 0, y: 1, z: 0))
            
            ForEach(0 ..< numberOfRectangles) { i in
                RectangleView(
                    index: i,
                    width: width,
                    numberOfRectangles: numberOfRectangles
                )
            }
        }
        .onAppear {
            withAnimation(animation) {
                angleX = -angleAmount
                angleY = -angleAmount
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + timeBetweenAnimations) {
                withAnimation(animation) {
                    angleX = angleAmount
                    angleY = -angleAmount
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + timeBetweenAnimations) {
                    withAnimation(animation) {
                        angleX = angleAmount
                        angleY = angleAmount
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + timeBetweenAnimations) {
                        withAnimation(animation) {
                            angleX = -angleAmount
                            angleY = angleAmount
                        }
                    }
                }
            }
            
            
        }
    }
}

struct RectangleView: View {
    @State private var height: CGFloat = 10
    @State private var opacity: Double = 0.4
    @State private var color: Color = .gray
    
    var index: Int
    var width: CGFloat
    var numberOfRectangles: Int
    
    var delay: Double {
        print(Double(index) * 0.1)
        return Double(index) * 0.1
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .fill(color)
            .frame(width: width, height: height, alignment: .center)
            .animation(.easeInOut.delay(delay), value: height)
            .opacity(opacity)
            .animation(.spring().delay(delay), value: opacity)
            .offset(y: 100)
            .rotationEffect(.degrees(degrees(for: index)), anchor: .center)
            .onAppear {
                height = 30
                opacity = 0.7
                color = .green
            }
    }
    
    func degrees(for index: Int) -> Double {
        Double((index+1) * (360 / numberOfRectangles))
    }
}

struct RoundAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        RoundAnimationView()
    }
}
