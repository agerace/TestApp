//
//  ImageGridView.swift
//  TestApp
//
//  Created by César Gerace on 29/07/2022.
//

import SwiftUI

struct ImageGridView: View {
    
    @State var imageItems: [ImageItem] = []
    
    
    @State var searchTerm: String = ""
    
    
    let layout = [GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 16.0, alignment: Alignment.center)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(imageItems, id: \.self) { imageItem in
                        
                        NavigationLink(destination: ImageDetailView(imageItem: imageItem)) {
                            VStack {
                                AsyncImage(url: imageItem.previewURL) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                }placeholder: {
                                    ProgressView()
                                }
                                
                                .frame(maxWidth: 80, alignment: .center)
                                Text(imageItem.tags).minimumScaleFactor(0.3).lineLimit(2)
                                    .minimumScaleFactor(0.3)
                                    .multilineTextAlignment(.center)
                            }.padding(8)
                        }
                    }
                }
            }.searchable(text: $searchTerm)
                .navigationTitle("Grid View")
        }.onSubmit(of: .search, searchImageItems)
        
        
    }
    
    private func searchImageItems() {
        NetworkManager().loadData(searchTerm: searchTerm) { imageItems in
            guard let imageItems = imageItems else { return }
            self.imageItems = imageItems.hits
        }
    }
}


struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView()
    }
}