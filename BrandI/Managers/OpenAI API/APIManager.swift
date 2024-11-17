//
//  APIManager.swift
//  Challange1
//
//  Created by Gehad Eid on 13/10/2024.
//

import Alamofire
import Foundation

class APIManager {
    static let shared = APIManager()
    private  init(){}
    
    func callOpenAIModel(imageBase64: String, text: String, completion: @escaping (String?) -> Void) async throws {
        let baseUrl = "https://api.openai.com/v1/chat/completions"
        
        let apiToken = ""
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization":  "Bearer \(apiToken)"
        ]
        
        let payload = [
            "model": "gpt-4o-mini",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": text
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpeg;base64,\(imageBase64)",
                                "detail": "low"
                            ]
                        ]
                    ]
                ]
            ]
        ] as! [String : Any]
        
        let response = await AF.request(baseUrl,
                                        method: .post,
                                        parameters: payload,
                                        encoding: JSONEncoding.default,
                                        headers: headers
        )
            .serializingDecodable(APIResponse.self)
            .response
        
        switch response.result {
        case .success(let apiResponse):
            completion(apiResponse.choices.first?.message.content)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            completion(nil)
        }
        //        .responseString { response in
        //              switch response.result {
        //              case .success(let data):
        //                  // Print the entire response for debugging
        //                  print("API Response: \(data)")
        //
        //                  // Parse the JSON manually
        //                  if let jsonData = data.data(using: .utf8),
        //                     let responseObject = try? JSONDecoder().decode(APIResponse.self, from: jsonData) {
        //                      // Extract content from the first choice
        //                      if let content = responseObject.choices.first?.message.content {
        //                          completion(content)
        //                      } else {
        //                          completion(nil)
        //                      }
        //                  } else {
        //                      completion(nil)
        //                  }
        //              case .failure(let error):
        //                  print("Error: \(error.localizedDescription)")
        //                  completion(nil)
        //              }
        //          }
    }
}

  // Define the response structure for decoding
  struct APIResponse: Decodable {
      let choices: [Choice]
  }

  struct Choice: Decodable {
      let message: Message
  }

  struct Message: Decodable {
      let content: String
  }
    
//    let apiUrl = "https://api-inference.huggingface.co/models/openai/clip-vit-base-patch32" // Or another model
//    let apiKey = "YOUR_HUGGING_FACE_API_KEY"
//
//    func evaluatePost(imageData: Data, caption: String, completion: @escaping (Result<Double, Error>) -> Void) {
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(apiKey)"
//        ]
//        
//        let parameters: [String: Any] = [
//            "inputs": [
//                "image": imageData.base64EncodedString(),
//                "text": caption
//            ]
//        ]
//        
//
//        
//
//        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                if let json = value as? [String: Any], let logits = json["logits_per_image"] as? [Double] {
//                    // Assuming the result returns logits, use the first value as the evaluation score
//                    completion(.success(logits.first ?? 0.0))
//                } else {
//                    completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
