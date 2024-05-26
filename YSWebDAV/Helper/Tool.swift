//
//  Tool.swift
//  YSWebDavPlayer
//
//  Created by HarryCao on 2024/5/25.
//

import Foundation

struct Tool {
    static func fileNameFromPath(_ path: String) -> String {
        var fileName: String?
        if let url = URL(string: path) {
            let pathComponents = url.pathComponents
            fileName = pathComponents.last
        }
        return fileName ?? ""
    }

    static func fileType(from path: String) -> FileType {
        if path.hasSuffix("/") {
            return .folder
        }
        let fileExtension = (path as NSString).pathExtension.lowercased()
        switch fileExtension {
        case "mp4", "mov", "avi", "mkv", "flv", "wmv", "webm", "m4v", "mpeg", "mpg":
            return .video
        case "jpg", "jpeg", "png", "gif", "bmp", "tiff":
            return .image
        case "mp3", "wav", "aac", "flac", "ogg", "m4a":
            return .audio
        default:
            return .unknown
        }
    }
}
