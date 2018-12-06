//
//  Album.swift
//  SimpleMusic
//
//  Created by Kirill Shteffen on 06/12/2018.
//  Copyright © 2018 BlackBricks. All rights reserved.
//

import Foundation

struct Album: Encodable {
    let data: AlbumData
}
struct AlbumData: Encodable {
    let attributes: Attributes
    let href: String
    let id: String
    let relationships: Relationships
    let type: String
}

struct Relationships: Encodable {
}

struct Attributes: Encodable {
    let artistName: String
    let artwork: Artwork
    let copyright: String
    let editorialNotes: EditorialNotes
    let genreNames: [String]
    let isComplete: Bool
    let isMasteredForItunes: Bool
    let isSingle: Bool
    let name: String
    let playParams: PlayParams
    let recordLabel: String
    let releaseDate: String
    let trackCount: Int
    let url: String
}

struct Artwork: Encodable {
    let bgColor: String
    let height: Int
    let textColor1: String
    let textColor2: String
    let textColor3: String
    let textColor4: String
    let url: String
    let width: String
}

struct EditorialNotes: Encodable {
    let short: String
    let standard: String
}

struct PlayParams: Encodable {
    let id: String
    let kind: String
}
