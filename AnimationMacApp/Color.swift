//
//  Color.swift
//  AnimationMacApp
//
//  Created by Anzer Arkin on 08.12.22.
//

import SwiftUI

internal extension Color {
  
  static var random: Color {
    switch(Int.random(in: 0...5)) {
    case 0: return Color.red
    case 1: return Color.orange
    case 2: return Color.yellow
    case 3: return Color.green
    case 4: return Color.blue
    case 5: return Color.purple
    default: return .black
    }
  }
}
