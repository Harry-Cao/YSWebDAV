//
//  WebDAVItem.swift
//  YSWebDavPlayer
//
//  Created by Harry Cao on 12/3/23.
//

import Foundation
import SwiftData

@Model
final class WebDAVItem {
    var name: String
    var userName: String
    var password: String
    var baseUrl: String
    var path: String

    init(name: String = "", userName: String = "", password: String = "", baseUrl: String = "", path: String = "") {
        self.name = name
        self.userName = userName
        self.password = password
        self.baseUrl = baseUrl
        self.path = path
    }
}
