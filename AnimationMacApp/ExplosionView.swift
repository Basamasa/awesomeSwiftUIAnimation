//
//  ExlosionView.swift
//  AnimationMacApp
//
//  Created by Anzer Arkin on 19.03.23.
//

import SwiftUI

struct ExplodeParticle: View {
    let angle: Double
    let delay: Double
    let color: Color

    @State private var isAnimating = false

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 10, height: 10)
            .scaleEffect(isAnimating ? 1 : 0)
            .offset(x: isAnimating ? CGFloat(cos(angle) * 100) : 0, y: isAnimating ? CGFloat(sin(angle) * 100) : 0)
            .opacity(isAnimating ? 0 : 1)
            .animation(Animation.easeOut(duration: 1).delay(delay))
            .onAppear {
                withAnimation {
                    isAnimating = true
                }
            }
    }
}

struct ExplosionView: View {
    @State private var explosions: [CGPoint] = []
    
    private let colors: [Color] = [.red, .yellow, .blue, .green, .purple, .orange]
    private let angles = Array(stride(from: 0, to: 360, by: 10))

    var body: some View {
        ZStack {
            ForEach(explosions.indices, id: \.self) { index in
                let position = explosions[index]
                ZStack {
                    ForEach(angles, id: \.self) { angle in
                        ExplodeParticle(angle: Double(angle), delay: Double(angle) / 360, color: colors[index % colors.count])
                            .position(position)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { value in
                    explosions.append(value.startLocation)
                }
        )
    }
}

