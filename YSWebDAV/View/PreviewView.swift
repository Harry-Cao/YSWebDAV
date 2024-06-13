//
//  PreviewView.swift
//  YSWebDavPlayer
//
//  Created by HarryCao on 2024/5/26.
//

import SwiftUI

struct PreviewView: View {
    let viewModel: FilesViewModel
    @State var fileId: UUID

    var body: some View {
        TabView(selection: $fileId) {
            ForEach(viewModel.previewFiles) { file in
                switch file.type {
                case .video, .audio:
                    PlayerView(url: viewModel.getUrl(file: file))
                        .navigationTitle(file.name)
                        .tag(file.id)
                case .image:
                    ImagePreviewView(url: viewModel.getUrl(file: file))
                        .navigationTitle(file.name)
                        .tag(file.id)
                case .folder,
                        .unknown:
                    EmptyView()
                        .navigationTitle(file.name)
                        .tag(file.id)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .tabViewStyle(.page)
    }
}
