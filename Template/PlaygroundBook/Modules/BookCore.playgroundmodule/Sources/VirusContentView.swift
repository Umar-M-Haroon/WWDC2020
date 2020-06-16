//
//  VirusContentView.swift
//  BookCore
//
//  Created by Umar Haroon on 5/15/20.
//

import SwiftUI
import UIKit
import SceneKit
public struct VirusContentView: View {
    @State var instructionText = Text("")
    @State var sceneView: SceneKitView!

    @State var shouldPlay = false
    @State var showingNotice = false
    @State var cellSteps = [
        CellStep(step: "Viral RNA uses cell machinery to make copies"),
        CellStep(step: "Virus attaches to cell"),
        CellStep(step: "Virus gets assembled and leaves cell"),
        CellStep(step: "Virus inserts RNA")
    ]
    var correctSteps = [
        CellStep(step: "Virus attaches to cell"),
        CellStep(step: "Virus inserts RNA"),
        CellStep(step: "Viral RNA uses cell machinery to make copies"),
        CellStep(step: "Virus gets assembled and leaves cell")
    ]
    public init() {}
    private func shouldShowUpButton(step: CellStep) -> Bool {
        return self.cellSteps.firstIndex(where: {$0.step == step.step})! != 0
    }
    private func shouldShowDownButton(step: CellStep) -> Bool {
        return self.cellSteps.firstIndex(where: {$0.step == step.step})! != 3
    }
    public var body: some View {
        ZStack {
            SceneKitView(shouldPlay: $shouldPlay)
            if showingNotice {
                FloatingNotice(showingNotice: $showingNotice)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showingNotice.toggle()
                            withAnimation {
                                self.shouldPlay = true
                                self.instructionText =
                                    Text("Congrats! You finished this playground! Thank you for your time!")
                                        .foregroundColor(.green)
                            }
                        }
                }
                .animation(.easeInOut)
            }
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0.0) {
                    Text("Arrange the steps in the correct order")
                    .font(.headline)
                    self.instructionText
                        .font(.headline)

                        HStack {
                            if self.cellSteps[0].step != self.correctSteps[0].step {
                                Text(self.cellSteps[0].step)
                            } else {
                                Text(self.cellSteps[0].step).foregroundColor(.green)
                            }

                            Button(action: {
                                withAnimation {
                                    self.cellSteps.swapAt(0, 1)
                                }
                                self.confirmAnswers()
                            }, label: {
                                if self.cellSteps[0].step != self.correctSteps[0].step {
                                    Image(systemName: "arrow.down")
                                        .frame(width: 44.0, height: 44.0, alignment: .center)
                                }
                            })
                        }
                        HStack {
                            if self.cellSteps[1].step != self.correctSteps[1].step {
                                Text(self.cellSteps[1].step)
                            } else {
                                Text(self.cellSteps[1].step).foregroundColor(.green)
                            }
                            Button(action: {
                                withAnimation {
                                    self.cellSteps.swapAt(1, 0)
                                    self.confirmAnswers()
                                }
                            }, label: {
                                if self.cellSteps[1].step != self.correctSteps[1].step {

                                    Image(systemName: "arrow.up")
                                        .frame(width: 44.0, height: 44.0, alignment: .center)
                                }
                            })

                            Button(action: {
                                withAnimation {
                                    self.cellSteps.swapAt(1, 2)
                                    self.confirmAnswers()
                                }
                            }, label: {
                                if self.cellSteps[1].step != self.correctSteps[1].step {

                                    Image(systemName: "arrow.down")
                                        .frame(width: 44.0, height: 44.0, alignment: .center)
                                }
                            })
                        }
                        HStack {
                            if self.cellSteps[2].step != self.correctSteps[2].step {
                                Text(self.cellSteps[2].step)
                            } else {
                                Text(self.cellSteps[2].step).foregroundColor(.green)
                            }
                            Button(action: {
                                withAnimation {
                                    self.cellSteps.swapAt(2, 1)
                                    self.confirmAnswers()
                                }
                            }, label: {
                                if self.cellSteps[2].step != self.correctSteps[2].step {
                                    Image(systemName: "arrow.up")
                                        .frame(width: 44.0, height: 44.0, alignment: .center)
                                }
                            })

                            Button(action: {
                                withAnimation {
                                    self.cellSteps.swapAt(2, 3)
                                }
                                self.confirmAnswers()
                            }, label: {
                                if self.cellSteps[2].step != self.correctSteps[2].step {
                                    Image(systemName: "arrow.down")
                                        .frame(width: 44.0, height: 44.0, alignment: .center)
                                }
                            })
                        }
                        HStack {
                            if self.cellSteps[3].step != self.correctSteps[3].step {
                                Text(self.cellSteps[3].step)
                            } else {
                                Text(self.cellSteps[3].step).foregroundColor(.green)
                            }
                            Button(action: {
                                withAnimation {

                                    self.cellSteps.swapAt(3, 2)
                                }
                                self.confirmAnswers()
                            }, label: {
                                if self.cellSteps[3].step != self.correctSteps[3].step {
                                    Image(systemName: "arrow.up")
                                        .frame(width: 44.0, height: 44.0, alignment: .center)
                                }
                            })

                        }
                }
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.8)
            }
        }
    }
    func confirmAnswers() {
        if self.cellSteps == correctSteps {
            withAnimation {
                showingNotice = true
            }
        } else {
            self.instructionText = Text("Keep going! For a virus to infect a cell, what must it do first?")
            showingNotice = false
        }
    }
}
struct FloatingNotice: View {
    @Binding var showingNotice: Bool

    var body: some View {
        VStack (alignment: .center, spacing: 8) {
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .font(.system(size: 48, weight: .regular))
                .padding(EdgeInsets(top: 20, leading: 5, bottom: 5, trailing: 5))
            Text("Correct!")
                .foregroundColor(.white)
                .font(.callout)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
        }
        .background(Color.gray.opacity(0.8))
        .cornerRadius(5)
        .transition(.scale)
    }
}
public struct CellStep: Identifiable, Equatable {
    public var step: String
    public var id = UUID()
}
extension CellStep {
    public static func ==(lhs: CellStep, rhs: CellStep) -> Bool {
        return lhs.step == rhs.step
    }
}
struct SceneKitView : UIViewRepresentable {
    @Binding var shouldPlay: Bool
    let scene = SCNScene(named: "Final.scn")!

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        return scnView
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        scnView.scene = scene
        scnView.isPlaying = shouldPlay
        scnView.scene?.isPaused = !shouldPlay
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true

        // show statistics such as fps and timing information

        // configure the view
        scnView.backgroundColor = UIColor.black
        
    }
}
struct VirusContentView_Previews: PreviewProvider {
    static var previews: some View {
        VirusContentView()
    }
}
