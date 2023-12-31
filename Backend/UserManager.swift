//
//  UserManager.swift
//  backend
//
//  Created by John + Sean on 11/6/23.
//

/*
 EXPLANATION OF DATA FLOW:
 -Frontend will rely on UserManager functions to access and manage user data, closet, and outfits
 -We can store custom structs (like "ClothingItem" or "Outfit") directly on the database, so no need for additional "front-end" versions
 -For an explanation of the various query filters, see https://cloud.google.com/firestore/docs/query-data/queries#in_and_array-contains-any
 -Examples below; see "createDummyData" function for more examples!
 
 // Getting clothing items based on query
 let closetRef = closetRef(userID: userID)
 let clothingQuery = closetRef.whereField("color", isEqualTo: "red")
 let justReds = try await getClothingItems(userID: userID, query: clothingQuery)
 
 let allClothing = try await getAllClothingItems(userID: userID)
 let justDresses = try await getClothingItems(userID: userID, query: closetRef.whereField("clothing", isEqualTo: "dress"))
 let redsAndBlues = try await getClothingItems(userID: userID, query: closetRef.whereField("color", in: ["red", "blue"]))
 let neverWorn = try await getClothingItems(userID: userID, query: closetRef.whereField("times_worn", isLessThan: 1))
 
 // Getting outfits based on query
 let outfitQuery = outfitsRef.whereField("fit_colors", arrayContainsAny: ["multicolor"])
 let multicolorOutfits = try await getOutfits(userID: userID, query: outfitQuery)
 
 // Getting clothes from an outfit
 let allOutfits = try await getAllOutfits(userID: userID)
 let firstOutfitClothes = try await clothingIDstoClothingItems(userID: userID, ids: allOutfits[0].fit_pieces!)
 
 // Adding a new clothing item to the database (or use alternate method to pass a ClothingItem struct directly)
 // Note that this version returns a ClothingItem struct for optional use
 let partyShorts = try await addClothingItem(userID: userID,
         color: ColorType.green,
         category: CategoryType.bottom,
         clothing: ClothingType.shorts,
         occasion: OccasionType.holiday,
         weather: WeatherType.winter,
         dateAdded: Date(),
         mostRecWear: Date(),
         timesWorn: 10)
 
 // Adding a new outfit to the database (pretty much same reminders as above with clothing items)
 let redBlueOutfit = try await addOutfit(userID: userID,
         label: "reds and blues",
         fitPieces: clothingItemsToIDs(items: redsAndBlues),
         fitColors: [ColorType.red, ColorType.blue],
         occasion: OccasionType.party,
         favorite: true,
         dateAdded: Date(),
         mostRecWear: Date())
 
 // Adding a piece to an outfit (same structure for remove)
 try await addClothingToOutfit(userID: userID, outfitID: redBlueOutfit!.id!, clothingID: partyShorts!.id!)
 
 // Deleting a clothing item (also removes it from all outfits it's in)
 let removed = try await deleteClothingItem(userID: userID, clothingID: partyShorts!.id!)
 */


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


/* ENUMS for global use */


public enum ColorType: String, Codable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case black
    case white
    case pink
    case multicolor
    case brown
}

public enum CategoryType: String, Codable {
    case top
    case bottom
    case fullbody
    case outerwear
    case accessory
    case shoes
}

public enum ClothingType: String, Codable {
    // Tops
    case tanktop
    case shortsleeve
    case longsleeve
    case sweater
    case cardigan
    
    
    // Bottoms
    case pants
    case shorts
    case longskirt
    case shortskirt
    case jeans
    
    
    // Fullbody
    case dress
    case jumpsuit
    case overalls
    
    // Outerwear
    case jacket
    case sweatshirt
    case coat
    case vests
    
    // Accessories
    case hat
    case scarf
    case jewlery
    
    // Shoes
    case dressshoes
    case sneakers
    case boots
    case sandals
}

public enum OccasionType: String, Codable {
    case casual
    case fancy
    case loungewear
    case holiday
    case party
}

public enum WeatherType: String, Codable {
    case winter
    case spring
    case summer
    case fall
}


/* STRUCTS for global use */


public struct ClothingItem: Codable, Hashable{
    var id: String?
    var color: ColorType?
    var category: CategoryType?
    var clothing: ClothingType?
    var occasion: OccasionType?
    var weather: WeatherType?
    var date_added: Date?
    var most_rec_wear: Date?
    var times_worn: Int64?
    var favorite: Bool?
    var img_url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case color
        case category
        case clothing
        case occasion
        case weather
        case date_added
        case most_rec_wear
        case times_worn
        case favorite
        case img_url
    }
}

public struct Outfit: Codable {
    var id: String?
    var label: String?
    var fit_pieces: Array<String>?
    var fit_colors: Array<ColorType>?
    var occasion: OccasionType?
    var favorite: Bool?
    var date_added: Date?
    var most_rec_wear: Date?
    var img_url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case label
        case fit_pieces
        case fit_colors
        case occasion
        case favorite
        case date_added
        case most_rec_wear
        case img_url
    }
}

public struct UserData: Codable {
    let id: String?
    let email: String?
    let date_created: Date?
    var img_url: String?
    var name: String?
    var favorite_season: WeatherType?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case date_created
        case img_url
    }
}


/* User Manager */


final class UserManager {
    
    // Singleton for use of methods
    static let shared = UserManager()
    var userInfo: UserData?
    private init() {}
    
    // Examples for creating data for a new user
    func createDummyData(userID: String) async throws {
        let dummyItem1 = ClothingItem(
            id: "tempID",
            color: ColorType.white,
            category: CategoryType.top,
            clothing: ClothingType.shortsleeve,
            occasion: OccasionType.casual,
            weather: WeatherType.summer,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 0,
            favorite: false,
            img_url: "shirt1"
        )
        try await addClothingItem(userID: userID, clothingData: dummyItem1)
            
        let dummyItem2 = ClothingItem(
            id: "tempID",
            color: ColorType.multicolor,
            category: CategoryType.top,
            clothing: ClothingType.shortsleeve,
            occasion: OccasionType.casual,
            weather: WeatherType.summer,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 0,
            favorite: false,
            img_url: "shirt2"
        )
        try await addClothingItem(userID: userID, clothingData: dummyItem2)
      
        let dummyItem3 = ClothingItem(
            id: "tempID",
            color: ColorType.red,
            category: CategoryType.top,
            clothing: ClothingType.tanktop,
            occasion: OccasionType.casual,
            weather: WeatherType.summer,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 2,
            favorite: false,
            img_url: "redTank"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem3)
      
       
        let dummyItem4 = ClothingItem(
            id: "tempID",
            color: ColorType.orange,
            category: CategoryType.top,
            clothing: ClothingType.longsleeve,
            occasion: OccasionType.fancy,
            weather: WeatherType.fall,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 1,
            favorite: false,
            img_url: "orangeLongsleeve"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem4)

        let dummyItem5 = ClothingItem(
            id: "tempID",
            color: ColorType.yellow,
            category: CategoryType.top,
            clothing: ClothingType.sweater,
            occasion: OccasionType.loungewear,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 3,
            favorite: false,
            img_url: "yellowSweater"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem5)

        let dummyItem6 = ClothingItem(
            id: "tempID",
            color: ColorType.green,
            category: CategoryType.top,
            clothing: ClothingType.cardigan,
            occasion: OccasionType.holiday,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 0,
            favorite: false,
            img_url: "greenCardigan"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem6)

        let dummyItem7 = ClothingItem(
            id: "tempID",
            color: ColorType.blue,
            category: CategoryType.bottom,
            clothing: ClothingType.pants,
            occasion: OccasionType.casual,
            weather: WeatherType.fall,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 6,
            favorite: false,
            img_url: "bluePants"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem7)

        let dummyItem8 = ClothingItem(
            id: "tempID",
            color: ColorType.purple,
            category: CategoryType.bottom,
            clothing: ClothingType.shorts,
            occasion: OccasionType.casual,
            weather: WeatherType.summer,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 2,
            favorite: false,
            img_url: "purpleShorts"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem8)

        let dummyItem9 = ClothingItem(
            id: "tempID",
            color: ColorType.black,
            category: CategoryType.bottom,
            clothing: ClothingType.longskirt,
            occasion: OccasionType.fancy,
            weather: WeatherType.spring,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 4,
            favorite: false,
            img_url: "blackSkirt"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem9)

        let dummyItem10 = ClothingItem(
            id: "tempID",
            color: ColorType.white,
            category: CategoryType.bottom,
            clothing: ClothingType.shortskirt,
            occasion: OccasionType.party,
            weather: WeatherType.summer,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 0,
            favorite: false,
            img_url: "whiteSkirt"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem10)

        let dummyItem11 = ClothingItem(
            id: "tempID",
            color: ColorType.black,
            category: CategoryType.bottom,
            clothing: ClothingType.jeans,
            occasion: OccasionType.party,
            weather: WeatherType.spring,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 5,
            favorite: false,
            img_url: "blackJeans"
        )

        try await addClothingItem(userID: userID, clothingData: dummyItem11)
      
        let dummyItem12 = ClothingItem(
            id: "tempID",
            color: ColorType.black,
            category: CategoryType.fullbody,
            clothing: ClothingType.dress,
            occasion: OccasionType.fancy,
            weather: WeatherType.spring,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 3,
            favorite: false,
            img_url: "blackDress"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem12)

        let dummyItem13 = ClothingItem(
            id: "tempID",
            color: ColorType.red,
            category: CategoryType.fullbody,
            clothing: ClothingType.jumpsuit,
            occasion: OccasionType.holiday,
            weather: WeatherType.fall,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 0,
            favorite: false,
            img_url: "redJumpsuit"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem13)

        let dummyItem14 = ClothingItem(
            id: "tempID",
            color: ColorType.orange,
            category: CategoryType.outerwear,
            clothing: ClothingType.jacket,
            occasion: OccasionType.casual,
            weather: WeatherType.fall,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 8,
            favorite: false,
            img_url: "orangeJacket"
        )

        try await addClothingItem(userID: userID, clothingData: dummyItem14)
      
        let dummyItem15 = ClothingItem(
            id: "tempID",
            color: ColorType.pink,
            category: CategoryType.outerwear,
            clothing: ClothingType.sweatshirt,
            occasion: OccasionType.loungewear,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 0,
            favorite: false,
            img_url: "pinkSweatshirt"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem15)
      

        let dummyItem16 = ClothingItem(
            id: "tempID",
            color: ColorType.black,
            category: CategoryType.outerwear,
            clothing: ClothingType.coat,
            occasion: OccasionType.casual,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 7,
            favorite: false,
            img_url: "blackPuffer"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem16)
       
        let dummyItem17 = ClothingItem(
            id: "tempID",
            color: ColorType.black,
            category: CategoryType.outerwear,
            clothing: ClothingType.vests,
            occasion: OccasionType.casual,
            weather: WeatherType.fall,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 8,
            favorite: false,
            img_url: "blackVest"
        )

        try await addClothingItem(userID: userID, clothingData: dummyItem17)
      
        let dummyItem18 = ClothingItem(
            id: "tempID",
            color: ColorType.red,
            category: CategoryType.accessory,
            clothing: ClothingType.hat,
            occasion: OccasionType.casual,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 7,
            favorite: false,
            img_url: "redHat"
        )
        try await addClothingItem(userID: userID, clothingData: dummyItem18)
      

        let dummyItem19 = ClothingItem(
            id: "tempID",
            color: ColorType.green,
            category: CategoryType.accessory,
            clothing: ClothingType.scarf,
            occasion: OccasionType.casual,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 0,
            favorite: false,
            img_url: "greenScarf"
        )
        
        try await addClothingItem(userID: userID, clothingData: dummyItem19)
      
       
        let dummyItem20 = ClothingItem(
            id: "tempID",
            color: ColorType.black,
            category: CategoryType.shoes,
            clothing: ClothingType.dressshoes,
            occasion: OccasionType.fancy,
            weather: WeatherType.fall,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 7,
            favorite: false,
            img_url: "blackDressShoes"
        )

        try await addClothingItem(userID: userID, clothingData: dummyItem20)
      
        let dummyItem21 = ClothingItem(
            id: "tempID",
            color: ColorType.black,
            category: CategoryType.shoes,
            clothing: ClothingType.sneakers,
            occasion: OccasionType.casual,
            weather: WeatherType.spring,
            date_added: Date(),
            most_rec_wear: nil,
            times_worn: 0,
            favorite: false,
            img_url: "whiteSneaker"
        )
        try await addClothingItem(userID: userID, clothingData: dummyItem21)
        
        
        let outFitList1: [ClothingItem] = [dummyItem21, dummyItem11, dummyItem5]
        let dummyOutfit1 = Outfit(
            id: "tempID",
                label: "New Outfit Number 1",
                fit_pieces: clothingItemsToIDs(items: outFitList1),
                fit_colors: [ColorType.yellow, ColorType.black],
                occasion: OccasionType.casual,
                favorite: false,
                date_added: Date(),
                most_rec_wear: Date(),
                img_url: "outfit2"
            )
        try await addOutfit(userID: userID, outfitData: dummyOutfit1)
        
        let outFitList2: [ClothingItem] = [dummyItem3, dummyItem10, dummyItem20]
        let dummyOutfit2 = Outfit(
            id: "tempID",
                label: "New Outfit Number 2",
                fit_pieces: clothingItemsToIDs(items: outFitList2),
                fit_colors: [ColorType.black, ColorType.red],
                occasion: OccasionType.fancy,
                favorite: false,
                date_added: Date(),
                most_rec_wear: Date(),
                img_url: "favOutfit"
            )
        try await addOutfit(userID: userID, outfitData: dummyOutfit2)
        
        // First get a reference to the closet / outfits for later use with queries
        let closetRef = closetRef(userID: userID)
        let outfitsRef = outfitsRef(userID: userID)
        
        // Using one-line, field-based version (best practice as there is no need to supply "tempID")
        /* 
        let partyShorts = try await addClothingItem(userID: userID,
                                                    color: ColorType.green,
                                                    category: CategoryType.bottom,
                                                    clothing: ClothingType.shorts,
                                                    occasion: OccasionType.holiday,
                                                    weather: WeatherType.winter,
                                                    dateAdded: Date(),
                                                    mostRecWear: Date(),
                                                    timesWorn: 10,
                                                    favorite: true,
                                                    img_url: "IMG_22K.jpg")
        */
        
        /*
        let clothingQuery = closetRef.whereField("color", isEqualTo: "red")
        let justReds = try await getClothingItems(userID: userID, query: clothingQuery)
        
        let allClothing = try await getAllClothingItems(userID: userID)
        let justDresses = try await getClothingItems(userID: userID, query: closetRef.whereField("clothing", isEqualTo: "dress"))
        let redsAndBlues = try await getClothingItems(userID: userID, query: closetRef.whereField("color", in: ["red", "blue"]))
        let neverWorn = try await getClothingItems(userID: userID, query: closetRef.whereField("times_worn", isLessThan: 1))
        
        // Convert clothing to id lists for use with outfits
        var clothingList1: [String] = []
        for piece in allClothing {
            clothingList1.append(piece.id!)
        }
        
        // Testing getting a single clothing item
        let testItem = try await getClothingItem(userID: userID, clothingID: clothingList1[0])
         */
        
        /*// Adding outfit directly to the databse (must set id to "tempID" so we can update it in the function)
        let dummyOutfit1 = Outfit(
            id: "tempID",
            label: "entire wardrobe",
            fit_pieces: clothingList1,
            fit_colors: [ColorType.multicolor],
            occasion: OccasionType.casual,
            favorite: true,
            date_added: Date(),
            most_rec_wear: Date())
        try await addOutfit(userID: userID, outfitData: dummyOutfit1)
        
        var listOfItems: [ClothingItem] = []
        
        if let top2 {
            listOfItems.append(top2)
        }
        
        // Adding outfit by supplying fields (don't need to set "tempID")
        let redBlueOutfit = try await addOutfit(userID: userID,
                                                label: "reds and blues",
                                                fitPieces: clothingItemsToIDs(items: redsAndBlues),
                                                fitColors: [ColorType.red, ColorType.blue],
                                                occasion: OccasionType.party,
                                                favorite: true,
                                                dateAdded: Date(),
                                                mostRecWear: Date())
         */
        
        // Testing getting outfits
        /*
        let allOutfits = try await getAllOutfits(userID: userID)
        // Example of getting a list of clothingItems from an outfit's clothing ids
        let firstOutfitClothes = try await clothingIDstoClothingItems(userID: userID, ids: allOutfits[0].fit_pieces!)
        
        // Example of using outfit queries
        let outfitQuery = outfitsRef.whereField("fit_colors", arrayContainsAny: ["multicolor"])
        let multicolorOutfits = try await getOutfits(userID: userID, query: outfitQuery)
         */
        
        // Testing adding a piece to an outfit (will not add repeats)
        /*
        try await addClothingToOutfit(userID: userID, outfitID: redBlueOutfit!.id!, clothingID: partyShorts!.id!)
        try await addClothingToOutfit(userID: userID, outfitID: redBlueOutfit!.id!, clothingID: partyShorts!.id!)
        
        // Testing removing a piece from an outfit (will not remove if it isn't there)
        try await removeClothingFromOutfit(userID: userID, outfitID: redBlueOutfit!.id!, clothingID: partyShorts!.id!)
        try await removeClothingFromOutfit(userID: userID, outfitID: redBlueOutfit!.id!, clothingID: partyShorts!.id!)
        
        // Testing deleting a clothing item
        let removed = try await deleteClothingItem(userID: userID, clothingID: partyShorts!.id!)
        //        print("Removed the following item: \n\(removed)")
        
        // Testing deleting an outfit
        try await deleteOutfit(userID: userID, outfitID: redBlueOutfit!.id!)
         */
        
        // Testing deleting this user (should also throw you back to the login/create user screen)
        // try await deleteUser(userID: userID)
        
        // Testing deleting all users (remove even from this example function lol, users should obv never be allowed to call this)
    }
    
    // This function is called by the login manager when a new account is created
    func createNewUser(loginData: LoginData) async throws {
        // Create UserData given auth
        let userData = UserData(id: loginData.uid,
                                email: loginData.email,
                                date_created: Date())
        
        // Add user data to the database
        try setUserData(userID: loginData.uid, data: userData)
        
        // Comment out for final version!
        try await createDummyData(userID: loginData.uid)
    }
    
    // Here is where any pertinent data can be loaded and initialized on login
    func loadDataOnLogin(loginData: LoginData) async throws  {
        // Data needed for initial view can be retrieved here
        userInfo = try await getUserData(userID: loginData.uid)
    }
    
    // TODO: (this really should not exist as it breaks all concept of async stuff. must handle optionals being nil in all views fastidiously)
    func getLoadedData() -> UserData? {
        return self.userInfo
    }
    
    /* UTILITY */
    
    
    // Takes a userID and returns a reference to the closet collection in the database for use with queries
    func closetRef(userID: String) -> CollectionReference {
        return Firestore.firestore().collection("users").document(userID).collection("closet")
    }
    
    // Takes a userID and returns a reference to the outfits collection in the database for use with queries
    func outfitsRef(userID: String) -> CollectionReference {
        return Firestore.firestore().collection("users").document(userID).collection("outfits")
    }
    
    // Converts a list of clothingItems (for example, the return of a "getClothingItems" call) and returns a list of their item ids
    func clothingItemsToIDs(items: [ClothingItem]) -> [String] {
        var idList: [String] = []
        for piece in items {
            idList.append(piece.id!)
        }
        return idList
    }
    
    // Converts a list of clothingItem ids into a list of actual ClothingItems
    // Really just a wrapper for a call to "getClothingItems" with a special query for matching id fields (so requires a userID)
    func clothingIDstoClothingItems(userID: String, ids: [String]) async throws -> [ClothingItem] {
        let closetRef = closetRef(userID: userID)
        // Check if list is empty
        if (ids.isEmpty) {
            return []
        } else {
            return try await getClothingItems(userID: userID, query: closetRef.whereField("id", in: ids))
        }
    }
    
    
    /* GETTERS */
    
    
    // Returns a UserData struct given a userID
    func getUserData(userID: String) async throws -> UserData? {
        let snapshot = try await Firestore.firestore().collection("users").document(userID).getDocument()
        
        // Attempts to read the user document in as a UserData struct
        do {
            let userData = try snapshot.data(as: UserData.self)
            return userData
        } catch let error as NSError {
            print("Error loading user data from database: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Returns a single clothing item given a userid and a valid clothingid
    func getClothingItem(userID: String, clothingID: String) async throws -> ClothingItem? {
        // Calls getClothingItems with a custom query for matching this exact id
        let query = closetRef(userID: userID).whereField("id", isEqualTo: clothingID)
        let matchingItems = try await getClothingItems(userID: userID, query: query)
        // Returns the first item with a matching id (should be only 1), or nil if none were found
        return matchingItems.isEmpty ? nil : matchingItems[0]
    }
    
    // Returns an array of all clothing items in a closet for a given userID
    func getAllClothingItems(userID: String) async throws -> [ClothingItem] {
        // Array of clothing items to return
        var clothingArray: [ClothingItem] = []
        
        // Attempt to load all clothing items into the local array
        let closet = try await closetRef(userID: userID).getDocuments()
        for document in closet.documents {
            do {
                // Add item to items array if database data can be properly decoded
                let closetItem = try document.data(as: ClothingItem.self)
                clothingArray.append(closetItem)
            } catch let error as NSError {
                print("Error loading clothing item from database: \(error.localizedDescription)")
            }
        }
        return clothingArray;
    }
    
    // Returns an array of clothing items using a query (use unique id field for a single item!)
    // See examples of using queries at the top of this file
    func getClothingItems(userID: String, query: Query) async throws -> [ClothingItem] {
        // Array of clothing items to return
        var clothingArray: [ClothingItem] = []
        
        // Attempt to load clothing items into the local array matching the query
        let queried = try await query.getDocuments()
        
        // Put all of the selected items in an array for return
        for document in queried.documents {
            do {
                // Add item to items array if database data can be properly decoded
                let closetItem = try document.data(as: ClothingItem.self)
                clothingArray.append(closetItem)
            } catch let error as NSError {
                print("Error loading clothing item from database: \(error.localizedDescription)")
            }
        }
        return clothingArray;
    }
    
    // Returns a single outfit given a userid and a valid outfit
    func getOutfit(userID: String, outfitID: String) async throws -> Outfit? {
        // Calls getOutfits with a custom query for matching this exact id
        let query = outfitsRef(userID: userID).whereField("id", isEqualTo: outfitID)
        let matchingItems = try await getOutfits(userID: userID, query: query)
        // Returns the first item with a matching id (should be only 1), or nil if none were found
        return matchingItems.isEmpty ? nil : matchingItems[0]
    }
    
    // Returns an array of all outfits
    func getAllOutfits(userID: String) async throws -> [Outfit] {
        // Array of outfits to return
        var outfitArray: [Outfit] = []
        
        // Attempt to load all outfits into the local array
        let outfits = try await outfitsRef(userID: userID).getDocuments()
        for document in outfits.documents {
            do {
                // Add item to items array if database data can be properly decoded
                let outfit = try document.data(as: Outfit.self)
                outfitArray.append(outfit)
            } catch let error as NSError {
                print("Error loading outfit from database: \(error.localizedDescription)")
            }
        }
        return outfitArray;
    }
    
    // Returns an array of outfits with optional filters (see examples at top of document!
    func getOutfits(userID: String, query: Query) async throws -> [Outfit] {
        // Array of outfits to return
        var outfitArray: [Outfit] = []
        
        // Attempt to load outfits into the local array matching the query
        let queried = try await query.getDocuments()
        
        // Put all of the selected items in an array for return
        for document in queried.documents {
            do {
                // Add item to items array if database data can be properly decoded
                let outfit = try document.data(as: Outfit.self)
                outfitArray.append(outfit)
            } catch let error as NSError {
                print("Error loading outfit from database: \(error.localizedDescription)")
            }
        }
        return outfitArray;
    }
    
    
    /* SETTERS */
    
    
    // Sets / updates user data for a given userID
    func setUserData(userID: String, data: UserData) throws {
        try Firestore.firestore().collection("users").document(userID).setData(from: data, merge: true)
    }
    
    // Adds a new clothing item to the user's closet, taking a ClothingItem struct (must supply an id of "tempID" for automatic conversion)
    func addClothingItem(userID: String, clothingData: ClothingItem) async throws {
        // Add the new clothing item to the database
        let closetRef = closetRef(userID: userID)
        try closetRef.addDocument(from: clothingData)
        
        // Update the closet ids to be their real, firestore-given ids
        let tempRef = try await closetRef.whereField("id", isEqualTo: "tempID").getDocuments()
        for document in tempRef.documents {
            if document == document {
                let realID = document.documentID
                try await document.reference.updateData(["id" : realID])
            }
        }
    }
    
    // Adds a new clothingItem, taking optional values for the fields to be used (best practice, as no need to supply item id!)
    // Returns the struct of the item added
    func addClothingItem(userID: String, color: ColorType?, category: CategoryType?, clothing: ClothingType?, occasion: OccasionType?, weather: WeatherType?, dateAdded: Date?, mostRecWear: Date?, timesWorn: Int64?, favorite: Bool?, img_url: String?) async throws -> ClothingItem? {
        // Convert given fields into a proper ClothingItem struct
        var clothingData = ClothingItem(id: "tempID",
                                        color: color,
                                        category: category,
                                        clothing: clothing,
                                        occasion: occasion,
                                        weather: weather,
                                        date_added: dateAdded,
                                        most_rec_wear: mostRecWear,
                                        times_worn: timesWorn,
                                        favorite: favorite,
                                        img_url: img_url)
        
        // Add the new clothing item to the database
        let closetRef = closetRef(userID: userID)
        try closetRef.addDocument(from: clothingData)
        
        // Update the closet ids to be their real, firestore-given ids
        let tempRef = try await closetRef.whereField("id", isEqualTo: "tempID").getDocuments()
        for document in tempRef.documents {
            if document == document {
                let realID = document.documentID
                try await document.reference.updateData(["id" : realID])
                clothingData.id = realID
            }
        }
        
        return clothingData
    }
    
    // Takes a userID and clothingID and overrides the data of an existing clothing item
    func updateClothingItem(userID: String, clothingID: String, clothingData: ClothingItem) async throws {
        // Attempts to update the data of the given clothing item
        try closetRef(userID: userID).document(clothingID).setData(from: clothingData)
    }
    
    // Adds a new outfit to the user's outfits collection (example in the createDummyData method!)
    func addOutfit(userID: String, outfitData: Outfit) async throws {
        // Add the new outfit to the database
        let outfitsRef = outfitsRef(userID: userID)
        try outfitsRef.addDocument(from: outfitData)
        
        // Update the outfits ids to be their real, firestore-given ids
        let tempRef = try await outfitsRef.whereField("id", isEqualTo: "tempID").getDocuments()
        for document in tempRef.documents {
            if document == document {
                let realID = document.documentID
                try await document.reference.updateData(["id" : realID])
            }
        }
    }
    
    // Adds a new outfit, taking optional values for the fields to be used. Generates item id automatically.
    // Returns the struct of the item added
    func addOutfit(userID: String, label: String?, fitPieces: [String]?, fitColors: [ColorType]?, occasion: OccasionType?, favorite: Bool?, dateAdded: Date?, mostRecWear: Date?) async throws -> Outfit? {
        // Convert given fields into a proper outfit struct
        var outfitData = Outfit(
            id: "tempID",
            label: label,
            fit_pieces: fitPieces,
            fit_colors: fitColors,
            occasion: occasion,
            favorite: favorite,
            date_added: dateAdded,
            most_rec_wear: mostRecWear)
        
        // Add the new outfit to the database
        let outfitsRef = outfitsRef(userID: userID)
        try outfitsRef.addDocument(from: outfitData)
        
        // Update the outfits ids to be their real, firestore-given ids
        let tempRef = try await outfitsRef.whereField("id", isEqualTo: "tempID").getDocuments()
        for document in tempRef.documents {
            if document == document {
                let realID = document.documentID
                try await document.reference.updateData(["id" : realID])
                outfitData.id = realID
            }
        }
        
        // Returns the outfit
        return outfitData
    }
    
    // Adds a clothing item to a given outfit
    func addClothingToOutfit(userID: String, outfitID: String, clothingID: String) async throws {
        // Attempts to retrieve the given outfit
        var fit = try await getOutfit(userID: userID, outfitID: outfitID)
        
        // Adds the given clothingID to the list
        if !(fit?.fit_pieces?.contains(clothingID))! { // ay caramba
            fit?.fit_pieces?.append(clothingID)
        }
        
        // Updates the outfit in the database
        try outfitsRef(userID: userID).document(outfitID).setData(from: fit)
    }
    
    
    /* DELETE */
    
    
    // Deletes all users (only for use in development)
    func deleteAllUsers() async throws {
        // TODO: do the thing
    }
    
    // Deletes a given user from the database and returns you to the login screen
    func deleteUser(userID: String) async throws -> UserData? {
        // Retrieve the item for return
        let item = try await getUserData(userID: userID)
        
        // Delete the user from the database
        try await Firestore.firestore().collection("users").document(userID).delete()
        
        // Delete the user from the authentication server
//        Auth.auth()
        
        // Return user to the login screen
        // TODO: get frontend peopleee
        
        // Return deleted item
        return item
    }
    
    // Deletes a given clothing item from the database and removes it from outfits it's in
    func deleteClothingItem(userID: String, clothingID: String) async throws -> ClothingItem? {
        // Retrieve the item for return
        let item = try await getClothingItem(userID: userID, clothingID: clothingID)
        
        // Delete the item
        try await closetRef(userID: userID).document(clothingID).delete()
        
        // Attempt to remove the item from all outfits it was in
        let outfitQuery = outfitsRef(userID: userID).whereField("fit_pieces", arrayContains: clothingID)
        let outfits = try await getOutfits(userID: userID, query: outfitQuery)
        for fit in outfits {
            try await removeClothingFromOutfit(userID: userID, outfitID: fit.id!, clothingID: clothingID)
        }
        
        // Return deleted item
        return item
    }
    
    // Deletes a given outfit from the database
    func deleteOutfit(userID: String, outfitID: String) async throws -> Outfit? {
        // Retrieve the item for return
        let item = try await getOutfit(userID: userID, outfitID: outfitID)
        
        // Delete the item
        try await outfitsRef(userID: userID).document(outfitID).delete()
        
        // Return deleted item
        return item
    }
    
    // Removes a clothing item from a given outfit
    func removeClothingFromOutfit(userID: String, outfitID: String, clothingID: String) async throws {
        // Attempts to retrieve the given outfit
        var fit = try await getOutfit(userID: userID, outfitID: outfitID)
        
        // Removes the given clothingID from the list
        if (fit?.fit_pieces?.contains(clothingID))! {
            let filtered = fit?.fit_pieces?.filter { $0 != clothingID }
            fit?.fit_pieces = filtered
        }
        
        // Updates the outfit in the database
        try outfitsRef(userID: userID).document(outfitID).setData(from: fit)
    }
    
}
