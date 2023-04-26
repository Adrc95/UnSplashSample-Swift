//
//  Photo.swift
//  unsplashsample
//
//  Created by Adrian on 16/4/23.
//

import Foundation

struct Photo {
    let id: String
    let url: URL
    let author: Author
    let camera: Camera?
    let description: String?
    let createdAt: String
}
