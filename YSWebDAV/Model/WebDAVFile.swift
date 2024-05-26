//
//  WebDAVFile.swift
//  YSWebDavPlayer
//
//  Created by HarryCao on 2024/5/25.
//

import Foundation

struct WebDAVFile: Identifiable {
    let id: UUID = UUID()
    let type: FileType
    let name: String
    let path: String
}

enum FileType {
    case unknown
    case folder
    case video
    case audio
    case image

    var systemIconName: String {
        switch self {
        case .unknown:
            return "camera.metering.unknown"
        case .folder:
            return "folder.fill"
        case .video:
            return "play.rectangle"
        case .audio:
            return "waveform"
        case .image:
            return "photo.fill"
        }
    }
}
