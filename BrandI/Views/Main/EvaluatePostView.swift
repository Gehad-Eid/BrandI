//
//  EvaluatePostView.swift
//  Challange1
//
//  Created by Gehad Eid on 16/10/2024.
//


import SwiftUI
import Alamofire

struct EvaluatePostView: View {
    @State private var text: String = ""
    @State private var image: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State private var evaluationResponse: String = ""
    
    // Hugging Face API settings
    let apiKey = "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"
    let apiUrl = "https://api-inference.huggingface.co/models/rhymes-ai/Aria"
    
    var body: some View {
        ScrollView() {
            Text("Evaluate Your Post")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Text Input Field
            TextEditor(text: $text)
                .padding()
                .border(Color.gray, width: 1)
                .frame(height: 100)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding()
            
            // Image Picker Button
            Button(action: {
                self.isShowingImagePicker = true
            }) {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                } else {
                    Text("Pick an Image")
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            // Submit Button
            Button(action: {
                if let imageData = image?.jpegData(compressionQuality: 0.8) {
                    evaluatePost(imageData: imageData, text: text)
                }
            }) {
                Text("Evaluate Post")
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            // Response from API
            Text("Evaluation Result:")
                .font(.headline)
            Text(evaluationResponse)
                .padding()
//                .border(Color.gray, width: 1)
//                .frame(height: 150)
            
            Spacer()
        }
//        .sheet(isPresented: $isShowingImagePicker) {
//            ImagePicker(image: self.$image)
//        }
        .padding()
    }
    
    // Alamofire request to evaluate post
    func evaluatePost(imageData: Data, text: String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        
        let parameters: [String: Any] = [
            "inputs": [
                "image": imageData.base64EncodedString(), // Convert image to base64
                "text": text
            ]
        ]
        
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    // Parse the response and update evaluationResponse
                    self.evaluationResponse = "Response: \(json)"
                    print(evaluationResponse)
                }
            case .failure(let error):
                print("Error: \(error)")
                self.evaluationResponse = "Error Is$$$$: \(error.localizedDescription)"
            }
        }
    }
}
