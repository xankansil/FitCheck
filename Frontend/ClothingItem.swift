//
//  ClothingItem.swift
//  FitCheck
//
//  Created by Corinna Plefka on 11/5/23.
//

import SwiftUI

enum ClothingCategory: String{
    case pants
    case shirt
    case shoes
    case shorts
    case skirt
    case dress
    case jacket
    case sweatshirt
    case sweater
    case longSleeve
    case hat
}

enum colors: String {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case black
    case white
    case pink
    case mulicolor
}

enum occasionType: String {
    case casual
    case fancy
    case loungewear
    case holiday
    case party
}


class ClothingItem: ObservableObject {
    var category: ClothingCategory
    var color: colors
    var occasion: occasionType
    var dateAdded: String
    var weather: String
    var timesWorn: Int
    var mostRecWear: String
    
    init(clCategory: ClothingCategory, clColor: colors, clOccasion: occasionType, clDateAdded: String, clWeather: String, clTimesWorn: Int, clMostRecWear: String){
        category = clCategory
        color = clColor
        occasion = clOccasion
        dateAdded = clDateAdded
        weather = clWeather
        timesWorn = clTimesWorn
        mostRecWear = clMostRecWear
    }
}
