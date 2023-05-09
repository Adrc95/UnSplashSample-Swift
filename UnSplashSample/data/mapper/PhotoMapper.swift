//
//  PhotoMapper.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation

extension Camera {
    init(dto: ExifDto) {
        aperture = dto.aperture.orEmpty()
        exposureTime = dto.exposureTime.orEmpty()
        focalLength = dto.focalLength.orEmpty()
        iso = dto.iso ?? -1
        make = dto.make.orEmpty()
        model = dto.model.orEmpty()
        name = dto.name.orEmpty()
    }
}

extension Photo {
    init(dto: PhotoDto) {
        id = dto.id
        url =  URL(string: dto.urls.regular)!
        author = Author(dto: dto.user)
        camera = dto.exif.let { value in
            Camera(
                aperture: value.aperture.orEmpty(),
                exposureTime: value.exposureTime.orEmpty(),
                focalLength: value.focalLength.orEmpty(),
                iso: value.iso ?? -1,
                make: value.make.orEmpty(),
                model: value.model.orEmpty(),
                name: value.name.orEmpty()
            )
        }
        description = dto.description
        createdAt = dto.createdAt
    }
}

extension Author {
    init(dto: UserDto) {
        username = dto.username
        name = dto.name.orEmpty()
        firstName = dto.firstName.orEmpty()
        lastName = dto.lastName.orEmpty()
        photo = dto.profileImage.let { value in
            URL(string: value.medium)!
        }
        location = dto.location.orEmpty()
    }
}
