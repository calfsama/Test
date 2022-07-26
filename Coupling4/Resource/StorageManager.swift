//
//  StorageManager.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 21/06/22.
//

import FirebaseStorage
//
public class StorageManager {
   static let shared = StorageManager()
    


    private let bucket = Storage.storage().reference()

    public enum CPStorageManagerError: Error{
        case faildToDownLoad
    }
    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping(Result<URL, Error>)-> Void) {

    }

    public func downloadImage(with reference: String, completion: @escaping(Result<URL, CPStorageManagerError>)-> Void){
        bucket.child(reference).downloadURL(completion: {url ,error in
            guard let url = url, error == nil else{
            completion(.failure(.faildToDownLoad))
                return

        }
            completion(.success(url))
        } )
}


public enum UserPostType{
    case photo, video
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
    
}

