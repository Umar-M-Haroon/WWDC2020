//
//  DNABases.swift
//  DNAExercise
//
//  Created by Umar Haroon on 5/12/20.
//  Copyright © 2020 Umar Haroon. All rights reserved.
//

import SwiftUI

struct BaseG: View {
    @State private var text = ""
    var isFlipped: Bool
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0, content: {
                BaseGTriangle()
                Rectangle().foregroundColor(colorBaseG)
            })
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                Text("G")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding(4)
                    .multilineTextAlignment(.center)
            }
            .scaleEffect(x: 1, y: self.isFlipped ? -1 : 1, anchor: .center)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
        }
    }
}
struct BaseC: View {
    @State private var text = ""
    var isFlipped: Bool
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0, content: {
                BaseCTriangle()
                    .scaleEffect(x: 1, y: -1, anchor: .center)
                Rectangle().foregroundColor(colorBaseC)
            })
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                Text("C")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding(4)
                    .multilineTextAlignment(.center)
            }
            .scaleEffect(x: 1, y: self.isFlipped ? -1 : 1, anchor: .center)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
        }
    }
}
struct BaseA: View {
    var isFlipped: Bool
    @State private var text = ""
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0, content: {
                BaseATriangle()
                    .scaleEffect(x: 1, y: -1, anchor: .center)
                Rectangle().foregroundColor(colorBaseA)
            })
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                Text("A")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding(4)
                    .multilineTextAlignment(.center)
            }
            .scaleEffect(x: 1, y: self.isFlipped ? -1 : 1, anchor: .center)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
        }
    }
}
struct BaseT: View {
    @State private var text = ""
    var isFlipped: Bool
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0, content: {
                BaseTTriangle()
                Rectangle().foregroundColor(colorBaseT)
            })
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                Text("T")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding(4)
                    .multilineTextAlignment(.center)
            }
            .scaleEffect(x: 1, y: self.isFlipped ? -1 : 1, anchor: .center)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
        }
    }
}
struct BaseU: View {
    @State private var text = ""
    var isFlipped: Bool
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0, content: {
                BaseUTriangle().scaleEffect(x: -1, y: 1, anchor: .center)
                Rectangle().foregroundColor(colorBaseU)
            })
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                Text("U")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding(4)
                    .multilineTextAlignment(.center)
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
            .scaleEffect(x: 1, y: self.isFlipped ? -1 : 1, anchor: .center)
        }
    }
}

struct DNABases_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BaseG(isFlipped: false)
            BaseC(isFlipped: false)
            BaseA(isFlipped: false)
            BaseT(isFlipped: false)
            BaseU(isFlipped: false)
        }
    }
}
