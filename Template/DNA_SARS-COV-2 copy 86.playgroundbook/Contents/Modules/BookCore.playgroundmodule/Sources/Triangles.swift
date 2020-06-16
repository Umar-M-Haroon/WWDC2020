//
//  Triangles.swift
//  DNAExercise
//
//  Created by Umar Haroon on 5/12/20.
//  Copyright © 2020 Umar Haroon. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}
struct RightTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}

struct BaseATriangle: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            Triangle().foregroundColor(colorBaseA).scaleEffect(x: 1, y: -1, anchor: .leading)
            Triangle().foregroundColor(colorBaseA).scaleEffect(x: -1, y: -1, anchor: .center)
        })
    }
}
struct BaseTTriangle: View {
    var body: some View {

        HStack(alignment: .center, spacing: 0, content: {
            RightTriangle().foregroundColor(colorBaseT)
            RightTriangle().foregroundColor(colorBaseT).scaleEffect(x: -1, y: 1, anchor: .center)
            RightTriangle().foregroundColor(colorBaseT)
            RightTriangle().foregroundColor(colorBaseT).scaleEffect(x: -1, y: 1, anchor: .center)
        })
    }
}
struct BaseGTriangle: View {
    var body: some View {
        Triangle().foregroundColor(colorBaseG).scaleEffect(x: 1, y: 1, anchor: .center)
            .shadow(radius: 20)
    }

}
struct BaseCTriangle: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            RightTriangle().foregroundColor(colorBaseC).scaleEffect(x: 1, y: -1, anchor: .leading)
            RightTriangle().foregroundColor(colorBaseC).scaleEffect(x: -1, y: -1, anchor: .center)
        })
    }
}
struct BaseUTriangle: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            RightTriangle().foregroundColor(colorBaseU).scaleEffect(x: -1, y: 1, anchor: .center)
            RightTriangle().foregroundColor(colorBaseU)
        }.scaleEffect(x: 0.5, y: 1, anchor: .center)
    }
}

struct Triangles_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BaseATriangle()
            BaseTTriangle()
            BaseGTriangle()
            BaseCTriangle()
            BaseUTriangle()
        }
    }
}
