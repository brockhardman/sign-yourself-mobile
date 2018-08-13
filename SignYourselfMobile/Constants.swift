//
//  Constants.swift
//  iOSTemplate
//
//  Created by Brock Hardman on 1/24/17.
//  Copyright © 2017 Credera. All rights reserved.
//

struct Constants {
    //TESTING VALUES
    #if DEBUG
        static let isDebug = true
        static let baseRestURL = "https://sy-api-prod.herokuapp.com/site/v1"
        static let wepayEnvironment = kWPEnvironmentStage
        static let wepayClientId = ""
    #else
        static let isDebug = false
        static let baseRestURL = "https://sy-api-prod.herokuapp.com/site/v1"
        static let wepayEnvironment = kWPEnvironmentProduction
        static let wepayClientId = "187582"
    #endif
    
    static let testImageUrl = "https://image.s4.exct.net/lib/fe9f15707567057e7d/m/1/christmas-email_01.png"
    static let configFileName = "Configuration"
    static let activeControllersFileName = "activeViewControllers"
    
    //NOTIFICATIONS
    static let userDidLoginNotification = "userDidLoginNotification"
    static let userDidRegisterNotification = "userDidRegisterNotification"
    static let signInNeededNotification = "signInNeededNotification"
    
    //APIs
    static let profileAPI = "/profile?user_id=%@"
    static let loginAPI = "/user/login"
    static let registerAPI = "/user/register"
    static let eventListAPI = "/event/list?author_id=%@"
    static let projectListAPI = "/project/list?owner_id=%@"
    
    //Strings
    static let PUBLISHED = "published"
    static let DRAFT = "draft"
    static let DASHBOARD = "Dashboard"
    static let ADVISOR = "Advisor"
    static let FANS = "Fans"
    static let ASSOCIATES = "Associates"
    static let PROJECTS = "Projects"
    static let PROFILE = "Profile"
    static let CONTRIBUTIONS = "Contributions"
    static let ADD_NEW_PROJECT = "Add New Project"
    static let BANNERS = "Banners"
    static let MEMBERS = "Members"
    static let PERKS = "Perks"
    static let MY_PRODUCTS = "My Products"
    static let TRACKING = "Tracking"
    static let DISCOVER_PRODUCTS = "Discover Products"
    static let ANALYTICS = "Analytics"
    static let SOCIAL_MEDIA = "Social Media"
    static let GRAPH_ANALYTICS = "Graph Analytics"
    static let EVENTS = "Events"
    static let NEWS = "News"
    
    static let EDIT_BANNER = "Edit Banner"
    static let ADD_NEW_BANNER = "Add New Banner"
    static let EDIT_PERK = "Edit Perk"
    static let ADD_NEW_PERK = "Add New Perk"
    static let EDIT_PRODUCT = "Edit Product"
    static let ADD_NEW_PRODUCT = "Add New Product"
    static let EDIT_TRACKING = "Edit Tracking"
    static let ADD_NEW_TRACKING = "Add New Tracking"
    
    
    //Screens
    static let LANDING_SCREEN = "LandingScreen"
    static let REGISTER_SCREEN = "RegisterViewController"
    static let LOGIN_SCREEN = "LoginViewController"
    static let DASHBOARD_SCREEN = "HomeViewController"
    static let MENU_SCREEN = "MenuScreen"
    static let CONTRIBUTION_SCREEN = "ContributionViewController"
    static let MAIN_SCREEN = "MainScreen"
    static let PROJECTS_SCREEN = "ProjectsViewController"
    static let PROFILE_SCREEN = "ProfileViewController"
    static let ADD_NEWPROJECT_SCREEN = "AddNewProjectScreen"
    static let ASSOCIATESCREEN = "AssociatesScreen"
    static let ADVISOR_SCREEN = "AdvisorsScreen"
    static let FANS_SCREEN = "FansScreen"
    static let GLOBAL_SCREEN = "GlobalScreen"
    static let MEMBER_SCREEN = "MembersScreen"
    static let ANALYTICS_SCREEN = "AnalyticsScreen"
    static let SOCIAL_MEDIA_SCREEN = "SocialMediaScreen"
    static let GRAPH_ANALYTICS_SCREEN = "GraphAnalyticsScreen"
    static let EVENTS_SCREEN = "EventsScreen"
    static let NEWS_SCREEN = "NewsScreen"
    static let MY_ACCOUNT_SCREEN = "MyAccountScreen"
    static let EDIT_AND_ADD_BANNER_SCREEN = "EditAndAddBannerScreen"
    static let EDIT_AND_ADD_PERK_SCREEN = "EditAndAddPerkScreen"
    static let EDIT_AND_ADD_PRODUCT_SCREEN = "EditAndAddProductScreen"
    static let EDIT_AND_ADD_TRACKING_SCREEN = "EditAndAddTrackingScreen"
    static let MARKETING_SCREEN = "MarketingScreen"
    static let ROOT_CONTROLLER = "RootViewController"
    
    //Tabs
    static let PROJECTS_TAB = "ProjectsTab"
    static let MEDIA_TAB_VIEW_CONTROLLER = "MediaTabViewController"
    static let EVENTS_TAB = "EventsTab"
    static let ALL_EVENTS_TAB = "AllEventsTab"
    static let LATEST_EVENT_TAB = "LatestEventTab"
    static let UPCOMMING_EVENT_TAB = "UpcommingEventTab"
    static let PROJECT_DETAIL_SCREEN = "ProjectDetailViewController"
    static let INFORMATION_TAB = "InformationTab"
    static let PROFILE_TAB = "ProfileTab"
    static let EDIT_AND_ADD_TRACKING_TAB = "EditAndAddTrackingTab"
    static let TRACKING_MEMBERS_TAB = "TrackingMembersTab"
}
