//
//  PlayerView.swift
//  YSWebDavPlayer
//
//  Created by HarryCao on 2024/5/25.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    let url: URL

    var body: some View {
        VideoPlayer(player: AVPlayer(url: url))
            .ignoresSafeArea()
    }
}
