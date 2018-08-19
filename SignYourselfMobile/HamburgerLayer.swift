

import UIKit

enum MenuItem {
    case home
    case members
    case banners
    case perks
    case products
    case socialMedia
    case analytics
    case events
    case news
    
    var name: String {
        switch self {
        case .home: return Constants.HOME
        case .members: return Constants.MEMBERS
        case .banners: return Constants.BANNERS
        case .perks: return Constants.PERKS
        case .products: return Constants.PRODUCTS
        case .socialMedia: return Constants.SOCIAL_MEDIA
        case .analytics: return Constants.ANALYTICS
        case .events: return Constants.EVENTS
        case .news: return Constants.NEWS
        }
    }
    
    var iconName: String {
        switch self {
        case .home: return "dashboard"
        case .members: return "member"
        case .banners: return "banner"
        case .perks: return "gift_gray"
        case .products: return "product"
        case .socialMedia: return Constants.SOCIAL_MEDIA
        case .analytics: return "marketing"
        case .events: return Constants.EVENTS
        case .news: return Constants.NEWS
        }
    }
    
    var identifier: String {
        return "MenuItemCell"
    }
    
    static func allMenuItems() -> [MenuItem] {
        
        var items: [MenuItem] = []
        
        items.append(.home)
        items.append(.members)
        items.append(.banners)
        items.append(.perks)
        items.append(.products)
        items.append(.socialMedia)
        items.append(.analytics)
        items.append(.events)
        items.append(.news)
        
        return items
    }
}

