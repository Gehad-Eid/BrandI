//
//  PopUpAi.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//

import SwiftUI

struct PopUpAi: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isLoading: Bool
    @Binding var response: String

    @State private var progress: CGFloat = 0.0
    @State private var progress1: Double = 0.5
    @State private var progress2: Double = 0.75
    @State private var progress3: Double = 0.75

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()

                VStack(alignment: .leading) {
                    if isLoading {
                        HStack {
                            CustomProgressBar(progress: $progress)
                            Text("\(Int(progress * 100))%")
                        }
                        .onAppear {
                            startProgress()
                        }

                        VStack(alignment: .leading) {
                            CustomProgressBarAutomatically(progress: $progress1, width: 285)
                            CustomProgressBarAutomatically(progress: $progress2, width: 285)
                            CustomProgressBarAutomatically(progress: $progress3, width: 200)
                        }
                        .onAppear {
                            withAnimation {
                                self.progress1 = 1.0
                                self.progress2 = 1.0
                                self.progress3 = 1.0
                            }
                        }
                    } else if let parsedResponse = parseResponse(response: response),
                              let overallScore = Double(parsedResponse.overallScore) {
                        // Update progress based on overallScore
                        let normalizedScore = max(0.0, min(1.0, overallScore / 100.0))

                        VStack {
                            HStack {
                                CustomProgressBar(progress: $progress)
                                Text("\(Int(overallScore))%")
                            }
                            .onAppear {
                                startProgress()
                            }
                            
                            HStack{
//                                "circle.badge.checkmark"
//                                "circle.badge.xmark"
                                
                                Text("Color Match: \(parsedResponse.colorMatch)")
                            }
                            
                            HStack{
                                Text("Compatability: \(parsedResponse.compatability)")
                            }
                            
                            HStack{
                                Text("Feedback: \(parsedResponse.feedback)")
                            }
                            
                            HStack{
                                Text("Grammar and Spelling:\(parsedResponse.grammarAndSpelling)")
                            }
                            
                            HStack{
                                Text("Image Match: \(parsedResponse.imageMatch)")
                            }
                        }
                        .onAppear {
                            progress = CGFloat(normalizedScore)
                        }
                    }

                    if !isLoading {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Done")
                                .frame(width: 315, height: 35)
                                .background(Color("BabyBlue"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }.padding(.top, 30)
                    }
                }
                .frame(width: 315, height: 230)
                .padding()
                .background(Color("Background"))
                .cornerRadius(18)
                .padding()

                Spacer()
            }
            Spacer()
        }
        .background(Color.black.opacity(0.5))
        .ignoresSafeArea()
    }

    // Increment the progress over time until it reaches 1.0
    private func startProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if progress < 1.0 {
                progress += 0.01 // progress speed
            } else {
                timer.invalidate()
            }
        }
    }

    func parseResponse(response: String) -> (overallScore: String, compatability: String, grammarAndSpelling: String, colorMatch: String, imageMatch: String, feedback: String)? {
        // Split the response string by commas
        let components = response.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }

        // Ensure the response has exactly 6 components
        guard components.count == 6 else { return nil }

        // Extract and clean up individual components
        let overallScore = components[0].replacingOccurrences(of: "overallScore: ", with: "")
        let compatability = components[1].replacingOccurrences(of: "compatability: ", with: "")
        let grammarAndSpelling = components[2].replacingOccurrences(of: "grammar and spiling: ", with: "")
        let colorMatch = components[3].replacingOccurrences(of: "color match: ", with: "")
        let imageMatch = components[4].replacingOccurrences(of: "image match: ", with: "")
        let feedback = components[5].replacingOccurrences(of: "feedback: ", with: "")

        return (overallScore, compatability, grammarAndSpelling, colorMatch, imageMatch, feedback)
    }
}

#Preview {
    PopUpAi(isLoading: .constant(true), response: .constant(""))
}
