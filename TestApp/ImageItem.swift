//
//  ImageItem.swift
//  TestApp
//
//  Created by Anonymous Artist on 03/08/2022.
//

import Foundation

struct ImageItem: Decodable, Identifiable, Hashable {
    let id: Int
    let tags: String
    let previewURL: URL
    let largeImageURL: URL
}
