//
//  HuggingFaceAPI.swift
//  Challange1
//
//  Created by Gehad Eid on 13/10/2024.
//

import Alamofire
import Foundation

class HuggingFaceAPI {
    let apiUrl = "https://api-inference.huggingface.co/models/openai/clip-vit-base-patch32" // Or another model
    let apiKey = "YOUR_HUGGING_FACE_API_KEY"

    func evaluatePost(imageData: Data, caption: String, completion: @escaping (Result<Double, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        
        let parameters: [String: Any] = [
            "inputs": [
                "image": imageData.base64EncodedString(),
                "text": caption
            ]
        ]

        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let logits = json["logits_per_image"] as? [Double] {
                    // Assuming the result returns logits, use the first value as the evaluation score
                    completion(.success(logits.first ?? 0.0))
                } else {
                    completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
