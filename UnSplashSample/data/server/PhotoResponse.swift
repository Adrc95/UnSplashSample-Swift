//
//  PhotoResponse.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation

struct PhotosResponse: Codable {
    let total: Int
    let totalPages: String
    let email: String
    let results: [PhotoDto]

    enum CodingKeys: String, CodingKey {
       case total
       case totalPages = "total_pages"
       case email
       case results
     }
}

struct PhotoDto: Codable {
    let id: String
    let createdAt: String
    let width: Int64
    let height: Int64
    let color: String
    let likes: Int64
    let likedByUser: Bool
    let description: String?
    let user: UserDto
    let currentUserCollections: [String]
    let urls: UrlsDto
    let links: LinksDto
    let exif: ExifDto?

    enum CodingKeys: String, CodingKey {
       case id
       case createdAt = "created_at"
       case width
       case height
       case color
       case likes
       case likedByUser = "liked_by_user"
       case description
       case user
       case currentUserCollections = "current_user_collections"
       case urls
       case links
       case exif
     }
}

struct UserDto: Codable {
    let id: String
    let username: String
    let name: String?
    let firstName: String?
    let lastName: String?
    let instragramUsername: String?
    let twitterUsername: String?
    let portfolioUrl: String?
    let profileImage: ProfileImageDto?
    let location: String?
    let links: ProfileLinksDto?

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case instragramUsername = "instagram_username"
        case twitterUsername = "twitter_username"
        case portfolioUrl = "portfolio_url"
        case profileImage = "profile_image"
        case location
        case links
    }
}

struct UrlsDto: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String

    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct ProfileImageDto: Codable {
    let small: String
    let medium: String
    let large: String

    enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }
}

struct ProfileLinksDto: Codable {
    let `self`: String
    let html: String
    let photos: String
    let likes: String

    enum CodingKeys: String, CodingKey {
        case `self` = "self"
        case html
        case photos
        case likes
    }
}

struct LinksDto: Codable {
    let `self`: String
    let html: String
    let download: String

    enum CodingKeys: String, CodingKey {
        case `self` = "self"
        case html
        case download
    }
}

struct ExifDto: Codable {
    let aperture: String?
    let exposureTime: String?
    let focalLength: String?
    let iso: Int?
    let make: String?
    let model: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case aperture
        case exposureTime = "exposure_time"
        case focalLength = "focal_length"
        case iso
        case make
        case model
        case name
    }
}
