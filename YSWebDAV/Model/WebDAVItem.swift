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
    var host: String
    var path: String

    init(name: String = "", userName: String = "", password: String = "", host: String = "", path: String = "") {
        self.name = name
        self.userName = userName
        self.password = password
        self.host = host
        self.path = path
    }
}

extension WebDAVItem: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return WebDAVItem(name: self.name, userName: self.userName, password: self.password, host: self.host, path: self.path)
    }
}
