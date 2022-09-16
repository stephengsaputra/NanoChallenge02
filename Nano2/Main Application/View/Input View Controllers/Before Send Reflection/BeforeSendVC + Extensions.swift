//
//  BeforeSendVC + Extensions.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 29/07/22.
//

import Foundation

extension BeforeSendVC {
    
    func sendReflection() {
        
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
                "emoji": "\(UserDefaults.standard.string(forKey: "emoji") ?? "")"
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

            Helper.getNetworkResponse(data: data, response: response, error: error)
            let httpResponse = response as? HTTPURLResponse

            if httpResponse?.statusCode == 200 {
                print("Success")
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(SuccessSubmitVC(), animated: true)
                }
            } else {
                print("Failed")
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(FailedSubmitVC(), animated: true)
                }
            }
        }
        .resume()
    }
}
