//
//  BookModelStruct.swift
//  TakeItEasyApp
//
//  Created by Zahid Merchant on 2022-06-16.
//

import Foundation


struct BookModel: Decodable {
    let items: [Books]
}

struct Books: Decodable {
    let id : String
    let selfLink : String
    let volumeInfo : VolumeInfo
}

struct VolumeInfo: Decodable{
     let title : String
     let description : String
     let imageLinks : ImageLinks
     let previewLink : String
    
}

struct ImageLinks : Decodable{
    let smallThumbnail : String
    let thumbnail : String
}
