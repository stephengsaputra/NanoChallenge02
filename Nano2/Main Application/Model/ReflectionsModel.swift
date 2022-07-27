//
//  ReflectionsModel.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import Foundation

struct ReflectionsModel {
    
    var integrationToken = UserDefaults.standard.string(forKey: "integrationsToken") ?? ""
    var databaseID = UserDefaults.standard.string(forKey: "databaseID") ?? ""
    var reflectionTitle = UserDefaults.standard.string(forKey: "reflectionsTitle") ?? ""
    var reflectionBody = UserDefaults.standard.string(forKey: "reflectionsBody") ?? ""
}
