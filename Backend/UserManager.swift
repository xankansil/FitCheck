//
//  UserManager.swift
//  backend
//
//  Created by John + Sean on 11/6/23.
//

// Commit
// TODO: sync string IDs with real, auto-generated IDs from firestore. - EDIT: try using documentID...? set this upon creation...?  (DONE!)
// TODO: standardize custom enum names (with "Type")    (DONE!)
// TODO: encode dummy clothing items and dummy outfit items!    (DONE!)
// TODO: make datecreated and mostrecwear an actual date    (DONE!)
// TODO: create real custom weather enum?  (DONE!)
// TODO: actually add user date created field so we can sort on firestore view  (DONE!)
// TODO: test reading and writing with multiple clothing items  (DONE!)
// TODO: update explanation of dataflow with new paradigm now that objects can be added directly to database (DONE!)
// TODO: successfully read clothing item values from database into arrays of APP-USABLE structs!    (DONE!)
// TODO: finalize "getAllClothingItems" function    (DONE!)
// TODO: see if the raw data vs enum issue was causing the earlier filtering function to break  (DONE!)
// TODO: compound queries (could send as a list or could actually let you pass the query... object?)    (DONE!)
// TODO: add a custom "QueryType" enum for use of more versatile filtering when searching   (DONE!)
// TODO: add search features by category! also maybe we really could just do a direct-to-DB dataflow.   (DONE!)
// TODO: add test filtering calls in createUser for different filtering requests    (DONE!)
// TODO: update examples at the head of this doc for filtering requests on clothing items (use real test cases) (DONE!)
// TODO: make standardized "create clothing item" function with optional parameters (and test in dummyvalues)   (DONE!)
// TODO: create codable / decodable structs for outfits like clothing info (use Corinna's outfit class as reference)    (DONE!)
// TODO: modify the clothingItem struct to have both super and subcategories (clothingCategory and clothingType)    (DONE!)
// TODO: remove alternate commented code (can be found in earlier pushes on github) (DONE!)
// TODO: successfully add dummy outfits to database using the "get all" and filtered clothing methods   (DONE!)
// TODO: create standardized "create outfit" function taking a list of clothingItem ids as input    (DONE!)
// TODO: successfully read an outfit from the database into the in-app outfit struct    (DONE!)
// TODO: also create a function that converts a list of clothingItems to a list of Ids  (DONE!)
// TODO: remove id-setting altogether in favor of the addClothingItem and addOutfit methods adding it properly  (DONE!)
// TODO: create a function for getting a list of actual clothingitems from a list of ids (like in an outfit)    (DONE!)
// TODO: make addOutfit alternate method that take fields rather than proper data   (DONE!)
// TODO: make addClothingItem alternate method that take fields rather than proper data (DONE!)
// TODO: large refactor using utility methods   (DONE!)
// TODO: fix swiftvalue bug to successully create an outfit query, and add example code (DONE!)
// TODO: update examples code to only have field-based versions of the addClothingItem and addOutfit methods    (DONE!)
// TODO: example of getClothingItems where you want to get all the clothingItems from a given outfit    (DONE!)
// TODO: add single "getClothingItem" and "getOutfit" functions based on ids    (DONE!)
// TODO: add "addClothingToOutfit" function (DONE!)
// TODO: add "removeClothingItemFromOutfit" function    (DONE!)
// TODO: deleteClothing function that also removes all instances of that item from all outfits  (DONE!)
// TODO: deleteOutfit function  (DONE!)
// TODO: create codable struct for userdata (DONE!)
// TODO: edit createUser to use the proper userdata struct  (DONE!)
// TODO: standardize confusing loginInfo / userManager userID struct discrepancies within UserManager   (DONE!)
// TODO: successfully read userdata into proper app-usable struct   (DONE!)
// TODO: Add favorite bool to clothingItem  (DONE!)

// In-Progress
// TODO: add img_url fields to all structs
// TODO: favorite clothes and favorite shoes in profile
// TODO: deleteUser function and deleteAllUsers that works for both firestore and authentication database (john help pls)
// TODO: make it so deleteUser sets you back to the login view (frontend help pls)

// Next
// TODO: get rid of obsolete stuff in the dummydata method to avoid confusion

// Upcoming
// TODO: IMAGE STORAGE on firebase as part of a clothing item / outfit. (requires creation of a new database)
// TODO: Investigate this and official docs https://www.youtube.com/watch?v=sTiD8a9sBWw
// TODO: Successfully store photos on database
// TODO: Add img_path optional fields to all three structs: user (profile pic), clothing item and outfit (social media)
// TODO: Delete calls successfully also remove images from the storage database

// Important but save for later
// TODO: remove front end versions of duplicate clothing + outfit structs (located in frontend files)
// TODO: make it so frontend and backend can access the same clothingItem / Outfit / UserData structs (from this file)
// TODO: add optionals everywhere so invalid data doesn't crash the app (kind of a biggie but really hard to test)

// Housekeeping
// TODO: remove dummyData call in createUser for final version -> massively reduce createUser overhead!
// TODO: test that the lack of dummy init doesn't break anything - all frontend views must work on zero clothing / outfit data

// Less pertinent:
// TODO: dummy social media view = basically just a global outfit view for now (proof of concept - shows that you CAN see other user data)
// TODO: paginating queries (maybe for global feed lol) https://cloud.google.com/firestore/docs/query-data/query-cursors#paginate_a_query
// TODO: do we want multiple closets...? (why would you even say such a thing)
// TODO: fix the annoying warnings of incompatible constraints on the createUser view
// TODO: make it so that by default, an outfits colors array field is generated by the colors of its clothingItems
// TODO: fields-based updatClothingItem and updateOutfit options (putting on hold unless we add edit functionality)

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
    
    // Outerwear
    case jacket
    case sweatshirt
    case coat
    case vests
    
    // Accessories
    case hat
    case scarf
    
    // Shoes
    case dressshoes
    case sneakers
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


public struct ClothingItem: Codable {
    var id: String?
    let color: ColorType?
    let category: CategoryType?
    let clothing: ClothingType?
    let occasion: OccasionType?
    let weather: WeatherType?
    let date_added: Date?
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
    let label: String?
    var fit_pieces: Array<String>?
    var fit_colors: Array<ColorType>?
    let occasion: OccasionType?
    var favorite: Bool?
    let date_added: Date?
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
    private init() {}
    
    // Examples for creating data for a new user
    func createDummyData(userID: String) async throws {
//        // Use "tempID" so that we can track it down to give each item a proper id (auto-generated from firestore)
//        let dummyItem1 = ClothingItem(
//            id: "tempID",
//            color: ColorType.black,
//            category: CategoryType.fullbody,
//            clothing: ClothingType.dress,
//            occasion: OccasionType.casual,
//            weather: WeatherType.winter,
//            date_added: Date(),
//            most_rec_wear: Date(),
//            times_worn: 0,
//            favorite: false)
//        
//        let dummyItem2 = ClothingItem(
//            id: "tempID",
//            color: ColorType.red,
//            category: CategoryType.accessory,
//            clothing: ClothingType.hat,
//            occasion: OccasionType.party,
//            weather: WeatherType.summer,
//            date_added: Date(),
//            most_rec_wear: Date(),
//            times_worn: 0,
//            favorite: false)
//        
//        let dummyItem3 = ClothingItem(
//            id: "tempID",
//            color: ColorType.red,
//            category: CategoryType.fullbody,
//            clothing: ClothingType.dress,
//            occasion: OccasionType.casual,
//            weather: WeatherType.winter,
//            date_added: Date(),
//            most_rec_wear: Date(),
//            times_worn: 0,
//            favorite: false)
//        
//        let dummyItem4 = ClothingItem(
//            id: "tempID",
//            color: ColorType.blue,
//            category: CategoryType.fullbody,
//            clothing: ClothingType.dress,
//            occasion: OccasionType.casual,
//            weather: WeatherType.winter,
//            date_added: Date(),
//            most_rec_wear: Date(),
//            times_worn: 1,
//            favorite: false)
//        
//        // Add items per their data
//        try closetRef.addDocument(from: dummyItem1)
//        try closetRef.addDocument(from: dummyItem2)
//        try closetRef.addDocument(from: dummyItem3)
//        try closetRef.addDocument(from: dummyItem4)
//        
//        // Update the clothingIDs to be their real, firestore-given ids
//        let closet = try await Firestore.firestore().collection("users").document(userID).collection("closet").whereField("id", isEqualTo: "tempID").getDocuments()
//        for document in closet.documents {
//            if document == document {
//                let realID = document.documentID
//                try await document.reference.updateData(["id" : realID])
//            }
//        }
        
        // First get a reference to the closet / outfits for later use with queries
        let closetRef = closetRef(userID: userID)
        let outfitsRef = outfitsRef(userID: userID)
        
        // Using explicit "addClothingItem" function (automatically generates appropriate IDs, still needs "tempID")
        let dummyItem5 = ClothingItem(
            id: "tempID",
            color: ColorType.blue,
            category: CategoryType.shoes,
            clothing: ClothingType.dressshoes,
            occasion: OccasionType.casual,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: Date(),
            times_worn: 1,
            favorite: false)
        try await addClothingItem(userID: userID, clothingData: dummyItem5)
        
        // Using one-line, field-based version (best practice as there is no need to supply "tempID")
        let partyShorts = try await addClothingItem(userID: userID,
                                                    color: ColorType.green,
                                                    category: CategoryType.bottom,
                                                    clothing: ClothingType.shorts,
                                                    occasion: OccasionType.holiday,
                                                    weather: WeatherType.winter,
                                                    dateAdded: Date(),
                                                    mostRecWear: Date(),
                                                    timesWorn: 10,
                                                    favorite: true)
        
        // Testing queries on clothingItems
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
        
        // Adding outfit directly to the databse (must set id to "tempID" so we can update it in the function)
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
        
        // Adding outfit by supplying fields (don't need to set "tempID")
        let redBlueOutfit = try await addOutfit(userID: userID,
                                                label: "reds and blues",
                                                fitPieces: clothingItemsToIDs(items: redsAndBlues),
                                                fitColors: [ColorType.red, ColorType.blue],
                                                occasion: OccasionType.party,
                                                favorite: true,
                                                dateAdded: Date(),
                                                mostRecWear: Date())
        
        // Testing getting outfits
        let allOutfits = try await getAllOutfits(userID: userID)
        // Example of getting a list of clothingItems from an outfit's clothing ids
        let firstOutfitClothes = try await clothingIDstoClothingItems(userID: userID, ids: allOutfits[0].fit_pieces!)
        
        // Example of using outfit queries
        let outfitQuery = outfitsRef.whereField("fit_colors", arrayContainsAny: ["multicolor"])
        let multicolorOutfits = try await getOutfits(userID: userID, query: outfitQuery)
        
        // Testing adding a piece to an outfit (will not add repeats)
        try await addClothingToOutfit(userID: userID, outfitID: redBlueOutfit!.id!, clothingID: partyShorts!.id!)
        try await addClothingToOutfit(userID: userID, outfitID: redBlueOutfit!.id!, clothingID: partyShorts!.id!)
        
        // Testing removing a piece from an outfit (will not remove if it isn't there)
        try await removeClothingFromOutfit(userID: userID, outfitID: redBlueOutfit!.id!, clothingID: partyShorts!.id!)
        try await removeClothingFromOutfit(userID: userID, outfitID: redBlueOutfit!.id!, clothingID: partyShorts!.id!)
        
        // Testing deleting a clothing item
        let removed = try await deleteClothingItem(userID: userID, clothingID: partyShorts!.id!)
        //        print("Removed the following item: \n\(removed)")
        
        // Testing deleting an outfit
       // try await deleteOutfit(userID: userID, outfitID: redBlueOutfit!.id!)
        
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
    func loadDataOnLogin(loginData: LoginData) async throws {
        // Data needed for initial view can be retrieved here
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
        return try await getClothingItems(userID: userID, query: closetRef.whereField("id", in: ids))
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
    func addClothingItem(userID: String, color: ColorType?, category: CategoryType?, clothing: ClothingType?, occasion: OccasionType?, weather: WeatherType?, dateAdded: Date?, mostRecWear: Date?, timesWorn: Int64?, favorite: Bool?) async throws -> ClothingItem? {
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
                                        favorite: favorite)
        
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
