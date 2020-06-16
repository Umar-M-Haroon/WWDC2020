//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Instantiates a live view and passes it to the PlaygroundSupport framework.
//
//
import PlaygroundSupport
import SwiftUI
import BookCore
PlaygroundPage.current.setLiveView(ContentView(bases: [Bases(baseType: .T), Bases(baseType: .T), Bases(baseType: .C), Bases(baseType: .A)], type: .DNA))
