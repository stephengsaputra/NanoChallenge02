//
//  Helper.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import Foundation

class Helper {
    
    static let model = ReflectionsModel()
    
    static func getNetworkResponse(data: Data?, response: URLResponse?, error: Error?) -> Void {
        
        print("Response: \(response as Any)\n")
        print("Error: \(error)\n")
        guard let data = data else { return }
        print(data, String(data: data, encoding: .utf8) ?? "*unknown encoding*")
    }
    
    static func sendReflection() {
        
        print(UserDefaults.standard.string(forKey: "integrationToken")!)
        
        let url = URL(string: "https://api.notion.com/v1/pages")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        request.allHTTPHeaderFields = [
            "Authorization"  : "Bearer \(UserDefaults.standard.string(forKey: "integrationToken")!)",
            "Content-Type"   : "application/json",
            "Notion-Version" : "2022-06-28"
        ]

        request.httpBody = try! JSONSerialization.data(withJSONObject: [
            "parent": [
                "database_id": "\(UserDefaults.standard.string(forKey: "databaseID")!)"
            ],
            "icon": [
                "type": "emoji",
                "emoji": "🔥"
            ],
            "properties": [
                "title": [
                    [
                        "type": "text",
                        "text": [
                            "content": UserDefaults.standard.string(forKey: "reflectionTitle")!
                        ]
                    ]
                ]
            ],
            "children": [
                [
                    "object": "block",
                    "type": "heading_2",
                    "heading_2": [
                        "rich_text": [[ "type": "text", "text": [ "content": "What did you do today?" ] ]]
                    ]
                ],
                [
                    "object": "block",
                    "type": "paragraph",
                    "paragraph": [
                        "rich_text": [
                            [
                                "type": "text",
                                "text": [
                                    "content": UserDefaults.standard.string(forKey: "reflectionBody")!
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ])

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            getNetworkResponse(data: data, response: response, error: error)
            let httpResponse = response as? HTTPURLResponse

            if httpResponse?.statusCode == 200 {
                print("Success")
            } else {
                print("Failed")
            }
        }
        .resume()
    }
}
