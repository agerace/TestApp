//
//  ImageDetailView.swift
//  TestApp
//
//  Created by César Gerace on 03/08/2022.
//

import SwiftUI

struct ImageDetailView: View {
    let imageItem: ImageItem
    
    var body: some View {
        AsyncImage(url: imageItem.largeImageURL) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        }placeholder: {
            ProgressView()
        }
    }
}

#warning("Check how to create a view with a mock image item")

//struct ImageDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageDetailView(imageItem: ImageItem)
//    }
//}
