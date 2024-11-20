//
//  APIManager.swift
//  Challange1
//
//  Created by Gehad Eid on 13/10/2024.
//

import Alamofire
import Foundation

// The response structure for decoding
struct APIResponse: Decodable {
    let choices: [Choice]
}

struct Choice: Decodable {
    let message: Message
}

struct Message: Decodable {
    let content: String
}

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
                
        var messages: [[String: Any]] = [
            [
                "role": "user",
                "content": [
                    [
                        "type": "text",
                        "text": text
                    ]
                ]
            ]
        ]
        
        // Conditionally add image content
        if !imageBase64.isEmpty {
            if var content = messages[0]["content"] as? [[String: Any]] {
                content.append([
                    "type": "image_url",
                    "image_url": [
                        "url": "data:image/jpeg;base64,\(imageBase64)",
                        "detail": "low"
                    ]
                ])
                messages[0]["content"] = content
            }
        }
        
        let payload: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": messages
        ]
        
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
    }
}
    

//        let payload = [
//            "model": "gpt-4o-mini",
//            "messages": [
//                [
//                    "role": "user",
//                    "content": [
//                        [
//                            "type": "text",
//                            "text": text
//                        ],
//                        [
//                            "type": "image_url",
//                            "image_url": [
//                                "url": "data:image/jpeg;base64,\(imageBase64)",
//                                "detail": "low"
//                            ]
//                        ]
//                    ]
//                ]
//            ]
//        ] as! [String : Any]


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
