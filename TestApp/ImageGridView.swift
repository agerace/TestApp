//
//  ImageGridView.swift
//  TestApp
//
//  Created by Anonymous Artist on 29/07/2022.
//

import SwiftUI

struct ImageGridView: View {
    
    @State var imageItems: [ImageItem] = []
    
    @State var searchTerm: String = ""
    @State var page: Int = 0
    @State var hasMoreItems: Bool = true
    @State var isSearching: Bool = false
    
    
    let layout = [GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 16.0, alignment: Alignment.center)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    LazyVGrid(columns: layout) {
                        ForEach(imageItems, id: \.self) { imageItem in
                            
                            NavigationLink(destination: ImageDetailView(imageItem: imageItem)) {
                                VStack(alignment: .center, spacing: 5) {
                                    AsyncImage(url: imageItem.previewURL) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    }placeholder: { ProgressView() }
                                        .frame(width: 80, height: 80, alignment: .center)
                                        .clipped()
                                        .cornerRadius(10.0)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10.0)
                                                .stroke(.gray, lineWidth: 2.0)
                                        )
                                    Text(imageItem.tags)
                                        .minimumScaleFactor(0.3)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                }.onAppear{
                                    if imageItem == imageItems[imageItems.count - 2] && hasMoreItems {
                                        searchMoreImageItems()
                                    }
                                }
                            }.padding(8)
                        }
                    }
                    if isSearching {
                        ProgressView()
                    }
                }
            }
            .searchable(text: $searchTerm)
            .navigationTitle("Grid View")
        }.onSubmit(of: .search, searchImageItems)
        
        
    }
    
    private func searchImageItems() {
        isSearching = true
        imageItems = []
        page = 1
        hasMoreItems = true
        NetworkManager().loadData(searchTerm: searchTerm, page: page) { imageItems in
            guard let imageItems = imageItems else { return }
            self.imageItems = imageItems.hits
            if imageItems.hits.count < 20 {
                hasMoreItems = false
            }
            isSearching = false
        }
    }
    
    private func searchMoreImageItems() {
        page = page + 1
        NetworkManager().loadData(searchTerm: searchTerm, page: page) { imageItems in
            guard let imageItems = imageItems else { return }
            self.imageItems.append(contentsOf: imageItems.hits)
            if imageItems.hits.count < 20 {
                hasMoreItems = false
            }
        }
    }
}

//
//struct ImageGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageGridView()
//    }
//}
