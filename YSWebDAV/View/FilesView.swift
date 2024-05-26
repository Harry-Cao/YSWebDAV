//
//  FilesView.swift
//  YSWebDavPlayer
//
//  Created by Harry Cao on 12/3/23.
//

import SwiftUI

struct FilesView: View {
    @StateObject var viewModel: FilesViewModel

    var body: some View {
        List(viewModel.searchResult) { file in
            if file.type == .unknown {
                HStack {
                    Image(systemName: file.type.systemIconName)
                    Text(file.name)
                }
            } else {
                NavigationLink {
                    switch file.type {
                    case .folder:
                        FilesView(viewModel: FilesViewModel(item: viewModel.itemFromFolder(file)))
                    case .video, .audio:
                        PlayerView(url: viewModel.getUrl(file: file))
                    case .image:
                        ImagePreviewView(url: viewModel.getUrl(file: file))
                    case .unknown:
                        EmptyView()
                    }
                } label: {
                    HStack {
                        Image(systemName: file.type.systemIconName)
                        Text(file.name)
                    }
                }
            }
        }
        .navigationTitle(viewModel.item.name)
        .searchable(text: $viewModel.searchText)
    }
}
