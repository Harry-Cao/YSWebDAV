//
//  ImagePreviewView.swift
//  YSWebDavPlayer
//
//  Created by HarryCao on 2024/5/26.
//

import SwiftUI

struct ImagePreviewView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
