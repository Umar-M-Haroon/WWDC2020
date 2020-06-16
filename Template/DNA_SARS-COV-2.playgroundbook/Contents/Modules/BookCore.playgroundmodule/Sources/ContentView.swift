//
//  ContentView.swift
//  DNAExercise
//
//  Created by Umar Haroon on 5/12/20.
//  Copyright © 2020 Umar Haroon. All rights reserved.
//
import SwiftUI
var colorBaseAButton = Color(red: 0, green: 5/255, blue: 180/255)
var colorBaseA = Color(red: 0, green: 5/255, blue: 74/255)
var colorBaseT = Color(red: 75/255, green: 235/255, blue: 207/255)
var colorBaseU = Color(red: 0, green: 89/255, blue: 255/255)
var colorBaseC = Color(red: 255/255, green: 3/255, blue: 3/255)
var colorBaseG = Color(red: 233/255, green: 254/255, blue: 4/255)


public struct Bases: Identifiable, Equatable {
    public var baseType: BaseTypes
    public var id = UUID()
    public init(baseType: BaseTypes) {
        self.baseType = baseType
    }
}

public enum BaseTypes: String {
    case A = "A", T, G, C, U
}
public enum StrandType {
    case RNA
    case DNA
}
struct BaseModel {
    static func isValidPair(lhs: Bases, rhs: Bases) -> Bool{
        switch lhs.baseType {
        case .A:
            return rhs.baseType == .U || rhs.baseType == .T
        case .C:
            return rhs.baseType == .G
        case .G:
            return rhs.baseType == .C
        case .T:
            return rhs.baseType == .A
        case .U:
            return rhs.baseType == .A
        }
    }
}
struct Base: View {
    var base: Bases
    var isFlipped: Bool
    var body: some View {
        getBase()
    }
    func getBase() -> AnyView {
        switch base.baseType {
        case .A:
            return AnyView(BaseA(isFlipped: isFlipped))
        case .T:
            return AnyView(BaseT(isFlipped: isFlipped))
        case .G:
            return AnyView(BaseG(isFlipped: isFlipped))
        case .C:
            return AnyView(BaseC(isFlipped: isFlipped))
        case .U:
            return AnyView(BaseU(isFlipped: isFlipped))
        }
    }
}

public struct ContentView: View {
    var startingBases: [Bases]
    @State var addedBases: [Bases] = []
    @State var answerView = Text("")
    @State var completionSpacer: CGFloat = 0.0
    @State var showingNotice = false
    var strandType: StrandType
    public init (bases: [Bases], type: StrandType) {
        self.startingBases = bases
        self.strandType = type
    }
    public var body: some View {
        VStack {
            Text("Below is a DNA strand")
            Text("Match the strand with the appropriate bases")
//            Spacer()
            VStack {
                Rectangle()
                    .foregroundColor(.purple)
                    .padding(.bottom, -10.0)
                    .frame(height: 2.0, alignment: Alignment.top)
                HStack(alignment: .top, spacing: 7.0) {
                    ForEach(startingBases) { base in
                        VStack(alignment: .center, spacing: 0.0) {
                            Base(base: base, isFlipped: true)
                            Rectangle()
                                .frame(width: 10.0, height: 20.0, alignment: .center)
                                .foregroundColor(.purple)
                        }
                    }
                }
                .padding([.leading, .trailing], 8.0)
                .frame(height: 200.0, alignment: Alignment.top)
                .scaleEffect(x: 1.0, y: -1.0, anchor: .center)
                .padding(.bottom, completionSpacer)


                HStack(alignment: .top, spacing: 7.0) {
                    ForEach(addedBases, id: \.id) { (base) in
                        GeometryReader { geometry in
                            VStack {
                                Base(base: base, isFlipped: false)
                                Rectangle()
                                    .frame(width: 10.0, height: 20.0, alignment: .center)
                                    .foregroundColor(.purple)
                                    .padding([.top, .bottom], -8.0)
                                Rectangle()
                                    .foregroundColor(.purple)
                                    .padding(.bottom, -10.0)
                                    .padding([.leading, .trailing], -60.0)
                                    .frame(height: 2.0, alignment: Alignment.top)
                                Spacer(minLength: 30.0)
                                HStack (alignment: .center, spacing: 8.0) {
                                    if (self.addedBases.firstIndex(where: {$0.id == base.id}) != 0) {
                                        Button.init(action: {
                                            withAnimation {
                                                let baseIndex = self.addedBases.firstIndex(where: {$0.id == base.id})!
                                                self.addedBases.swapAt(baseIndex, baseIndex - 1)
                                                self.confirmAnswers()
                                            }
                                        }) {
                                            Image(systemName: "arrow.left")
                                                .foregroundColor(.blue)
                                                .scaleEffect(1.3)
                                        }
                                    }
                                    Button.init(action: {
                                        withAnimation {
                                            self.removeBase(id: base.id)
                                            self.confirmAnswers()
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .scaleEffect(1.5)
                                    }
                                    if (self.addedBases.firstIndex(where: {$0.id == base.id}) != self.addedBases.count - 1) {
                                        Button.init(action: {
                                            withAnimation {
                                                let baseIndex = self.addedBases.firstIndex(where: {$0.id == base.id})!
                                                self.addedBases.swapAt(baseIndex, baseIndex + 1)
                                                self.confirmAnswers()
                                            }
                                        }) {
                                            Image(systemName: "arrow.right")
                                                .foregroundColor(.blue)
                                                .scaleEffect(1.3)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(height: 200.0, alignment: Alignment.bottom)
                .padding([.leading, .trailing], 8.0)
                VStack {
                    Text("Add a Base")
                        .font(.headline)
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.addedBases.append(Bases(baseType: .A))
                                self.confirmAnswers()
                            }
                        }, label:{
                            Text("A")
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(colorBaseAButton, lineWidth: 3)
                            )
                        })
                        Button(action: {
                            withAnimation {
                                if self.strandType == .DNA{
                                    self.addedBases.append(Bases(baseType: .T))
                                } else {
                                    self.addedBases.append(Bases(baseType: .U))
                                }
                                self.confirmAnswers()
                            }
                        }, label:{
                            if self.strandType == .DNA{
                                Text("T")
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(colorBaseT, lineWidth: 3)
                                )
                            } else {
                                Text("U")
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(colorBaseT, lineWidth: 3)
                                )
                            }
                        })
                        Button(action: {
                            withAnimation {
                                self.addedBases.append(Bases(baseType: .C))
                                self.confirmAnswers()
                            }
                        }, label:{
                            Text("C")
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(colorBaseC, lineWidth: 3)
                            )
                        })
                        Button(action: {
                            withAnimation {
                                self.addedBases.append(Bases(baseType: .G))
                                self.confirmAnswers()
                            }
                        }, label:{
                            Text("G")
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(colorBaseG, lineWidth: 3)
                            )
                        })
                    }
                    answerView
                }
                if showingNotice {
                    FloatingNotice(showingNotice: $showingNotice)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showingNotice.toggle()
                            }
                    }
                    .animation(.easeInOut)
                }

            }
            .padding(.bottom, 140.0)
        }
    }
    func confirmAnswers() {
        if addedBases.count < startingBases.count {
            answerView = Text("Keep going!")
            completionSpacer = 0
            showingNotice = false
            return
        }
        if addedBases.count > startingBases.count {
            answerView = Text("There are too many bases, remove a base!")
            completionSpacer = 0
            showingNotice = false
            return
        }
        let correctPairs = startingBases.enumerated().map { (arg0) -> Bool in
            let (index, _) = arg0
            return BaseModel.isValidPair(lhs: startingBases[index], rhs: addedBases[index])
        }
        if correctPairs.contains(false) {
            withAnimation(.spring()) {
                answerView = Text("Not all pairs are correct, try again!")
                completionSpacer = 0
                showingNotice = false
            }
        } else {
            withAnimation(.spring()) {
                answerView = Text("All pairs are correct! Nice job!")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                completionSpacer = -110
            }
            showingNotice = true
        }
    }
    func removeBase(id: UUID) {
        addedBases.removeAll(where: {$0.id == id})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(bases: [Bases(baseType: .T), Bases(baseType: .T), Bases(baseType: .C), Bases(baseType: .A)], type: .DNA)
    }
}
