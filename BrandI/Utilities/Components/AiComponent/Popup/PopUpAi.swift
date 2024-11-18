//
//  PopUpAi.swift
//  Challange1
//
//  Created by sumaiya on 24/10/2567 BE.
//  Edited by Gehad Eid on 17/11/2024.
//

import SwiftUI

struct PopUpAi: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isLoading: Bool
    @Binding var response: String
    @Binding var showPopup: Bool
    
    @State private var progress: CGFloat = 0.0
    @State private var progress1: Double = 0.5
    @State private var progress2: Double = 0.75
    @State private var progress3: Double = 0.75
    
    // Helper function for parsing strings to integers
    func intValue(from string: String) -> Int {
        return Int(string) ?? 0
    }
    
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
                    } else if let parsedResponse = parseResponse(response: response) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                CustomProgressBar(progress: $progress)
                                Text("\(Int(parsedResponse.overallScore)!)%")
                            }
                            .onAppear {
                                startProgress()
                            }
                            
                            HStack {
                                Image(systemName: Int(parsedResponse.colorMatch)! > 70 ? "circle.badge.checkmark" : "circle.badge.xmark")
                                    .font(.caption)
                                    .foregroundColor(Int(parsedResponse.colorMatch)! > 70 ? .blue : .gray)
                                Text("Color Match: \(parsedResponse.colorMatch)")
                                    .font(.caption)
                                    .foregroundColor(Int(parsedResponse.colorMatch)! > 70 ? .blue : .gray)
                            }
                            
                            HStack {
                                Image(systemName: Int(parsedResponse.compatability)! > 70 ? "circle.badge.checkmark" : "circle.badge.xmark")
                                    .font(.caption)
                                    .foregroundColor(Int(parsedResponse.compatability)! > 70 ? .blue : .gray)
                                Text("Compatability: \(parsedResponse.compatability)")
                                    .font(.caption)
                                    .foregroundColor(Int(parsedResponse.compatability)! > 70 ? .blue : .gray)
                            }
                            
                            HStack {
                                Image(systemName: Int(parsedResponse.grammarAndSpelling)! > 70 ? "circle.badge.checkmark" : "circle.badge.xmark")
                                    .font(.caption)
                                    .foregroundColor(Int(parsedResponse.grammarAndSpelling)! > 70 ? .blue : .gray)
                                Text("Grammar and Spelling: \(parsedResponse.grammarAndSpelling)")
                                    .font(.caption)
                                    .foregroundColor(Int(parsedResponse.grammarAndSpelling)! > 70 ? .blue : .gray)
                            }
                            
                            HStack {
                                Image(systemName: Int(parsedResponse.imageMatch)! > 70 ? "circle.badge.checkmark" : "circle.badge.xmark")
                                    .font(.caption)
                                    .foregroundColor(Int(parsedResponse.imageMatch)! > 70 ? .blue : .gray)
                                Text("Image Match: \(parsedResponse.imageMatch)")
                                    .font(.caption)
                                    .foregroundColor(Int(parsedResponse.imageMatch)! > 70 ? .blue : .gray)
                            }
                            
                            HStack {
                                Text("Feedback: \(parsedResponse.feedback)")
                                    .font(.caption)
                                    .foregroundColor(Int(parsedResponse.imageMatch)! > 70 ? .blue : .gray)
                            }
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "circle.badge.checkmark")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(response)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    if !isLoading {
                        Button(action: {
                            showPopup = false
                            //dismiss()
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
    PopUpAi(isLoading: .constant(true), response: .constant(""), showPopup: .constant(false))
}
