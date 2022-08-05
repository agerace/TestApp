//
//  ImageDetailView.swift
//  TestApp
//
//  Created by Anonymous Artist on 03/08/2022.
//

import SwiftUI
import PDFKit

struct ImageDetailView: View {
    let imageItem: ImageItem
    
    @State private var imageScale: CGFloat = 1
    @State private var showMetadata = false

    var body: some View {
        
        ZStack {
            AsyncImage(url: imageItem.largeImageURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                
            }placeholder: { ProgressView() }
            .scaleEffect(imageScale)
            .gesture(
                MagnificationGesture().onChanged{ value in
                    imageScale = value >= 1 ? value : 1
                }
                    .onEnded{ _ in
                        withAnimation{
                            imageScale = 1
                        }
                        
                    }
            )
            .simultaneousGesture(
                TapGesture(count: 2).onEnded{
                    withAnimation{
                        imageScale = imageScale > 1 ? 1 : 4
                    }
                }
            )
            .simultaneousGesture(
                TapGesture(count: 1).onEnded{
                    showMetadata = !showMetadata
                }
            )
            if showMetadata {
                Text(imageItem.tags)
                    .background(Color.white.opacity(0.5))
            }
        }
        
        
    }
}

#warning("Check how to create a view with a mock image item")

//struct ImageDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageDetailView(imageItem: ImageItem)
//    }
//}
