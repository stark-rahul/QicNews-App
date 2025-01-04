//
//  Today.swift
//  QicNews
//
//  Created by Guest on 03/01/25.
//

import Foundation
import SwiftUI

//MARK: DataModel

struct Today: Identifiable {
    var id = UUID().uuidString
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artwork: String
}

var todayItems: [Today] = [
    Today(appName: "LEGO Brewls", appDescription: "Battle withfriends online", appLogo: "Logo1", bannerTitle: "smash yopr rivals in ledo grels", platformTitle: "Apple Arcade", artwork: "Logo1"),
    Today(appName: "Frozen Horizon", appDescription: "raching Game Racing", appLogo: "Logo2", bannerTitle: "Your in change of horizantal festival", platformTitle: "Apple Arcade", artwork: "Logo2")
]

var dummyText = "You can modify this Free Cover Banner for season x fortnite game PSD Template as you wish and free to use this Free Cover Banner for season x fortnite game PSD Template PSD in your personal and commercial projects. This Free Cover Banner for season x fortnite game PSD Template comes in web-ready formats 1920x1080px size and 150Dpi and RGB colors so all you have to do is fill in your own texts and replace the photos. You can easily modify and edit this Free Cover Banner for season x fortnite game PSD Template file according to your own needs. It will definitely save your time as you don’t have to design it completely from scratch. You can modify this Free Cover Banner for season x fortnite game PSD Template as you wish and free to use this Free Cover Banner for season x fortnite game PSD Template PSD in your personal and commercial projects. All you need is adobe photoshop to edit this Burger... "
