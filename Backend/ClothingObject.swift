//
//  ClothingObject.swift
//  FitCheck
//
//  Created by Adalia Williams on 12/1/23.
//

import Foundation


class ClothingObject: ObservableObject{
    @Published var id: String?
    @Published var color: ColorType?
    @Published var category: CategoryType?
    @Published var clothing: ClothingType?
    @Published var occasion: OccasionType?
    @Published var weather: WeatherType?
    @Published var date_added: Date?
    @Published var most_rec_wear: Date?
    @Published var times_worn: Int64?
    @Published var favorite: Bool?
    @Published var img_url: String?
    @Published var isLoggedIn: Bool!
    @Published var userName: String!
    
    init(){
        self.id = ""
        self.color = .white
        self.category = .top
        self.clothing = .dress
        self.occasion = .casual
        self.weather = .spring
        self.date_added = Date()
        self.most_rec_wear = Date()
        self.times_worn = 0
        self.favorite = false
        self.img_url = ""
        self.isLoggedIn = true //must be true to create have clothing objects
        self.userName = ""
    }
}
