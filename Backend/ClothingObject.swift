//
//  ClothingObject.swift
//  FitCheck
//
//  Created by Adalia Williams on 12/1/23.
//

import Foundation



class ClothingObject: ObservableObject{
    @Published var closetObject : ClothingItem
        
    init() {
        self.closetObject = ClothingItem()
    }
}

    /*UNCERTIAN IF NEEDED OR DUPLICATE CODE
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
     
     func getID() -> String{
     return self.id!
     }
     
     func getColor() -> ColorType {
     return self.color!
     }
     
     func getCategory() -> CategoryType {
     return self.category!
     }
     
     func getClothingType() -> ClothingType {
     return self.clothing!
     }
     
     func getOccasion() -> OccasionType {
     return self.occasion!
     }
     
     func getWeather() -> WeatherType {
     return self.weather!
     }
     
     func getDateAdded() -> Date {
     return self.date_added!
     }
     
     func getRecentWornDate() -> Date {
     return self.most_rec_wear!
     }
     
     func getTimesWorn() -> Int64 {
     return self.times_worn!
     }
     
     func getFavorite() -> Bool {
     return self.favorite!
     }
     
     func getImgURL() -> String {
     return self.img_url!
     }
     
     
     }
     */
