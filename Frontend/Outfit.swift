//
//  Outfit.swift
//  FitCheck
//
//  Created by Corinna Plefka on 11/5/23.
//

import SwiftUI

class Outfit: ObservableObject {
    var id: String
    var fitPieces: Array <ClothingItem>
    var label: String
    var occasion: occasionType
    var favorite: Bool
    var mostRecWear: String
    var fitColors: Array <colors>
    
    
    init(dbID: String, outfitPieces: Array <ClothingItem>, fitLabel: String, fitOccasion: occasionType, fitFav: Bool, fitMostRecWear: String, outfitColors: Array <colors>){
        id = dbID
        fitPieces = outfitPieces
        label = fitLabel
        occasion = fitOccasion
        favorite = fitFav
        mostRecWear = fitMostRecWear
        fitColors = outfitColors
    }
}
