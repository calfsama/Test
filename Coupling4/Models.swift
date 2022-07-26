//
//  Models.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 22/06/22.
//

import Foundation

enum Gender {
    case female, male, other
}



struct User{
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let birthDate: Date
    let gender: Gender
    let count: UserCount
    let joinedDate: Date
}

struct UserCount{
    let followers: Int
    let following: Int
    let post: Int
}

public enum UserPostType: String{
    case photo = "Photo"
    case video = "Video"
}

public struct UserPost{
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createddate: Date
    let taggeUsers: [String]
    let owner: User
    
}
    struct PostLike{
        let username: String
        let postIdentifier: String
    }
    struct CommentLike{
        let username: String
        let commentIdentifier: String
    }
    
    struct PostComment{
        let identifier: String
        let username: String
        let text: String
        let createdeDate: Date
        let likes: [CommentLike]
    }

struct ImageView{
     var image: String
    
    static func postImage() -> [ImageView] {
        let first = ImageView(image: "1")
        
        let second = ImageView(image: "2")
        
        let third = ImageView(image: "1")
        
        let fourth = ImageView(image: "2")
        
        return[first, second, third, fourth]
    }
  
}
    
 
