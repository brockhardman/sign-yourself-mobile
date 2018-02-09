//
//  Profile.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 1/27/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

struct Profile : Codable {
    var id : String?
    var user_id : String?
    var name : String?
    var first_name : String?
    var last_name : String?
    var genre : String?
    var about : String?
    var phone : String?
    var city : String?
    var country : String?
    var state_province : String?
    var zip_code : String?
    var image_thumb_path : String?
    var image_path : String?
    var slug : String?
    var token : String?
    var status : String?
    var featured : String?
    var created_at : String?
    var updated_at : String?
    var facebook_user_id : String?
    var facebook_auth_token : String?
    var twitter_user_id : String?
    var twitter_auth_token : String?
    var instagram_user_id : String?
    var instagram_auth_token : String?
    var soundcloud_user_id : String?
    var soundcloud_auth_token : String?
    var vimeo_user_id : String?
    var vimeo_auth_token : String?
    var youtube_user_id : String?
    var youtube_auth_token : String?
    var user : User?
}
