//
//  Post.swift
//  PhotoShareApp
//
//  Created by Baran on 29.04.2023.
//

import Foundation

class Post {
    
    var email: String;
    var imageUrl: String;
    var comment: String;
    
    init(email: String, imageUrl: String, comment: String) {
        self.email = email
        self.imageUrl = imageUrl
        self.comment = comment
    }
}
