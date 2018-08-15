//
//  Project.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 1/27/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class Project : Codable {
    var id : Int?
    var name : String?
    var description : String?
    var goal : String?
    var status : Int?
    var trending : Int?
    var image_thumb_path : String?
    var image_path : String?
    var media_path : String?
    var embed_media : String?
    var video_path : String?
    var embed_video : String?
    var slug : String?
    var owner_id : Int?
    var members : [String]?
    var token : String?
    var created_at : String?
    var updated_at : String?
    var avatar_file_name : String?
    var avatar_file_size : String?
    var avatar_content_type : String?
    var avatar_updated_at : String?
}
