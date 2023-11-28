//
//  UserManager.swift
//  backend
//
//  Created by John + Sean on 11/6/23.
//

// Done
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

// In-Progress
// TODO: create codable / decodable structs for outfits and userdata, like clothing info (use Corinna's outfit class as reference)
// TODO: create standardized "create outfit" function taking a list of clothingItem id's as input
// TODO: test dummy outfits using the "get all" and filtered clothing methods

// Next
// TODO: finalize getters and setters for all user data, all clothing items, all outfits, using the decodable enums
// TODO: edit createUser to use the proper userdata struct
// TODO: add updateOutfit method

// Upcoming
// TODO: IMAGE STORAGE on firebase as part of a clothing item / outfit. (requires creation of a new database)

// Important but save for later
// TODO: make it so frontend and backend can access the classes from "BackendOutfit" and "BackendClothingItem"
// TODO: standardize confusing loginInfo / userManager userID struct discrepancies (will update after profile views are created)
// TODO: remove dummyData call in createUser for final version!

// Less pertinent:
// TODO: do we want multiple closets...?
// TODO: dummy social media view = basically just a global outfit archive for now (proof of concept - shows that you CAN see other user data)
// TODO: make (and call) a DELETE ALL USERS function for both firestore and authentication database!
// TODO: paginating queries (maybe for global feed lol) https://cloud.google.com/firestore/docs/query-data/query-cursors#paginate_a_query
// TODO: fix the annoying warnings of incompatible constraints on the createUser view
// TODO: add partial data option for updating clothing items

/*
 EXPLANATION OF DATA FLOW:
 -Frontend will rely on UserManager functions to access and manage user data, closet, and outfits
 -We can store custom structs (like "ClothingItem" or "Outfit") directly on the database, so no need for additional "front-end" versions
 -For an explanation of the various FILTERS, see https://cloud.google.com/firestore/docs/query-data/queries#in_and_array-contains-any
 -Unfortunately no compound queries at the moment, but you could find the intersection of two arrays
 
 // Examples code:
 try await createDummyData(userID: loginData.uid)
 let allClothing = try await getAllClothingItems(userID: loginData.uid)
 
 // Testing queries
 let closetRef = Firestore.firestore().collection("users").document(loginData.uid).collection("closet")
 let query = closetRef.whereField("color", isEqualTo: "red")
 
 let justReds = try await getClothingItems(userID: loginData.uid, query: query)
 let justDresses = try await getClothingItems(userID: loginData.uid, query: closetRef.whereField("clothing", isEqualTo: "dress"))
 let redsAndBlues = try await getClothingItems(userID: loginData.uid, query: closetRef.whereField("color", in: ["red", "blue"]))
 let neverWorn = try await getClothingItems(userID: loginData.uid, query: closetRef.whereField("times_worn", isLessThan: 1))
 */


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


/* ENUMS for global use */


// Contains the full suite of query types for firestore
//public enum QueryType: String, Codable {
//    case less_than
//    case less_than_or_equal_to
//    case equal_to
//    case greater_than
//    case greater_than_or_equal_to
//    case not_equal_to
//    case array_contains
//    case array_contains_any
//    case within
//    case not_within
//}

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
    case mulicolor
}

public enum ClothingType: String, Codable {
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

// TODO: change to be like the other structs, and all this UserData
public struct DBUser {
    let userId: String
    let email: String
    let dateCreated: Date?
}

public struct ClothingItem: Codable {
    let id: String?
    let color: ColorType?
    let clothing: ClothingType?
    let occasion: OccasionType?
    let weather: WeatherType?
    let date_added: Date?
    let most_rec_wear: Date?
    let times_worn: Int64?
    
    enum CodingKeys: String, CodingKey {
        case id
        case color
        case clothing
        case occasion
        case weather
        case date_added
        case most_rec_wear
        case times_worn
    }
}

//class REMOVETHISOutfit: ObservableObject {
//    var id: String
//    var fitPieces: Array <String>
//    var label: String
//    var occasion: occasionType
//    var favorite: Bool
//    var mostRecWear: String
//    var fitColors: Array <colorType>
//
//
//    init(dbID: String, outfitPieces: Array <String>, fitLabel: String, fitOccasion: occasionType, fitFav: Bool, fitMostRecWear: String, outfitColors: Array <colorType>){
//        id = dbID
//        fitPieces = outfitPieces
//        label = fitLabel
//        occasion = fitOccasion
//        favorite = fitFav
//        mostRecWear = fitMostRecWear
//        fitColors = outfitColors
//    }
//}


/* User Manager */


final class UserManager {
    
    // Singleton for use of methods
    static let shared = UserManager()
    private init() {}
    
    // Creating example data for a new user
    func createDummyData(userID: String) async throws {
        // Note that a real id is to be given after document creation (firestore auto-generates a unique id)
        let dummyItem1 = ClothingItem(
            id: "tempID",
            color: ColorType.black,
            clothing: ClothingType.dress,
            occasion: OccasionType.casual,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: Date(),
            times_worn: 0)
        
        let dummyItem2 = ClothingItem(
            id: "tempID",
            color: ColorType.red,
            clothing: ClothingType.hat,
            occasion: OccasionType.party,
            weather: WeatherType.summer,
            date_added: Date(),
            most_rec_wear: Date(),
            times_worn: 0)
        
        let dummyItem3 = ClothingItem(
            id: "tempID",
            color: ColorType.red,
            clothing: ClothingType.dress,
            occasion: OccasionType.casual,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: Date(),
            times_worn: 0)
        
        let dummyItem4 = ClothingItem(
            id: "tempID",
            color: ColorType.blue,
            clothing: ClothingType.dress,
            occasion: OccasionType.casual,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: Date(),
            times_worn: 1)
        
        // Add items per their data
        let closetRef = Firestore.firestore().collection("users").document(userID).collection("closet")
        try closetRef.addDocument(from: dummyItem1)
        try closetRef.addDocument(from: dummyItem2)
        try closetRef.addDocument(from: dummyItem3)
        try closetRef.addDocument(from: dummyItem4)
        
        // Using explicit "addClothingItem" function
        let dummyItem5 = ClothingItem(
            id: "tempID",
            color: ColorType.blue,
            clothing: ClothingType.shoes,
            occasion: OccasionType.casual,
            weather: WeatherType.winter,
            date_added: Date(),
            most_rec_wear: Date(),
            times_worn: 1)
        try await addClothingItem(userID: userID, clothingData: dummyItem5)
        
        // Update the clothingIDs to be their real, firestore-given ids
        let closet = try await Firestore.firestore().collection("users").document(userID).collection("closet").whereField("id", isEqualTo: "tempID").getDocuments()
        for document in closet.documents {
            if document == document {
                let realID = document.documentID
                try await document.reference.updateData(["id" : realID])
            }
        }
    }
    
    // This function is called by the login manager when a new account is created
    func createNewUser(loginData: LoginData) async throws {
        // Create userdata given auth
        let userData: [String:Any] = [
            "user_id" : loginData.uid,
            "email" : loginData.email ?? "",
            "photo_url" : loginData.photoUrl ?? "",
            "date_created" : Date()
        ]
        // Set user data in database
        try await Firestore.firestore().collection("users").document(loginData.uid).setData(userData, merge: false)
        
        // TESTING / Examples
        try await createDummyData(userID: loginData.uid)
        let allClothing = try await getAllClothingItems(userID: loginData.uid)
        
        // Testing queries
        let closetRef = Firestore.firestore().collection("users").document(loginData.uid).collection("closet")
        let query = closetRef.whereField("color", isEqualTo: "red")
        
        let justReds = try await getClothingItems(userID: loginData.uid, query: query)
        let justDresses = try await getClothingItems(userID: loginData.uid, query: closetRef.whereField("clothing", isEqualTo: "dress"))
        let redsAndBlues = try await getClothingItems(userID: loginData.uid, query: closetRef.whereField("color", in: ["red", "blue"]))
        let neverWorn = try await getClothingItems(userID: loginData.uid, query: closetRef.whereField("times_worn", isLessThan: 1))
        
        // Create outfits using above arrays of clothing items

        //        print("just reds:")
        //        for item in justReds {
        //            print(item.id!)
        //        }
        //
        //        print("just dresses:")
        //        for item in justDresses {
        //            print(item.id!)
        //        }
        //
        //        print("reds and blues:")
        //        for item in redsAndBlues {
        //            print(item.id!)
        //        }
        //
        //        print("never worn:")
        //        for item in neverWorn {
        //            print(item.id!)
        //        }
    }
    
    // Here is where any pertinent data can be loaded and initialized on login
    func loadDataOnLogin(loginData: LoginData) async throws {
        // Data needed for initial view can be retrieved here
    }
    
    
    /* GETTERS */
    
    
    // Returns a user data struct given a userID (TODO: use actual user data struct!)
    func getUserData(userID: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userID).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        guard let data = snapshot.data(), let email = data["email"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let dateCreated = data["date_created"] as? Date
        
        return DBUser(userId: userId, email: email, dateCreated: dateCreated)
    }
    
    // Returns an array of all clothing items in a closet for a given userID
    func getAllClothingItems(userID: String) async throws -> [ClothingItem] {
        // Array of clothing items to return
        var clothingArray: [ClothingItem] = []
        
        // Attempt to load all clothing items into the local array
        let closet = try await Firestore.firestore().collection("users").document(userID).collection("closet").getDocuments()
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
    
    //    // Returns an array of clothing items with optional filters (use unique ID for a single item)
    //    // Must be called multiple times in succession for complex queries
    //    // Takes a userID, the name of the field being queried, the operator (an enum), and a value to construct a query
    //    // See top of document for examples
    //    func getClothingItems(userID: String, field: String, queryOperator: QueryType, value: Any? = nil, arrValues: [Any]? = nil) async throws -> [ClothingItem] {
    //        // Array of clothing items to return
    //        var clothingArray: [ClothingItem] = []
    //
    //        // Attempt to load clothing items into the local array matching the query
    //        let closetRef = Firestore.firestore().collection("users").document(userID).collection("closet")
    //
    //        // Obviously kind of horrible on its face? But works for now and is pretty versatile for single-field requests
    //        var queried = try await closetRef.getDocuments()
    //        switch (queryOperator) {
    //        case QueryType.less_than:
    //            queried = try await closetRef.whereField(field, isLessThan: value!).getDocuments()
    //            break
    //        case QueryType.less_than_or_equal_to:
    //            queried = try await closetRef.whereField(field, isLessThanOrEqualTo: value!).getDocuments()
    //            break
    //        case QueryType.equal_to:
    //            queried = try await closetRef.whereField(field, isEqualTo: value!).getDocuments()
    //            break
    //        case QueryType.greater_than:
    //            queried = try await closetRef.whereField(field, isGreaterThan: value!).getDocuments()
    //            break
    //        case QueryType.greater_than_or_equal_to:
    //            queried = try await closetRef.whereField(field, isGreaterThanOrEqualTo: value!).getDocuments()
    //            break
    //        case QueryType.not_equal_to:
    //            queried = try await closetRef.whereField(field, isNotEqualTo: value!).getDocuments()
    //            break
    //        case QueryType.array_contains:
    //            queried = try await closetRef.whereField(field, arrayContains: value!).getDocuments()
    //            break
    //        case QueryType.array_contains_any:
    //            if(arrValues != nil) {
    //                queried = try await closetRef.whereField(field, arrayContainsAny: arrValues!).getDocuments()
    //            }
    //            break
    //        case QueryType.within:
    //            if(arrValues != nil) {
    //                queried = try await closetRef.whereField(field, in: arrValues!).getDocuments()
    //            }
    //            break
    //        case QueryType.not_within:
    //            if(arrValues != nil) {
    //                queried = try await closetRef.whereField(field, notIn: arrValues!).getDocuments()
    //            }
    //            break
    //        }
    //
    //        // Put all of the selected items in an array for return
    //        for document in queried.documents {
    //            do {
    //                // Add item to items array if database data can be properly decoded
    //                let closetItem = try document.data(as: ClothingItem.self)
    //                clothingArray.append(closetItem)
    //            } catch let error as NSError {
    //                print("Error loading clothing item from database: \(error.localizedDescription)")
    //            }
    //        }
    //        return clothingArray;
    //    }
    
    // Returns an array of all outfits
    func getAllOutfits(userID: String) async throws {
        // Attempt to load all outfit items into the local array
        let outfits = try await Firestore.firestore().collection("users").document(userID).collection("outfits").getDocuments()
        for document in outfits.documents {
            print("\(document.documentID) => \(document.data())")
        }
    }
    
    // Returns an array of outfits with optional filters (use unique ID for a single item)
    func getOutfits(userID: String) {
        
    }
    
    
    /* SETTERS */
    
    
    // Sets / updates user data for a given userID
    func setUserData(userID: String) async throws -> DBUser {
        // TODO: allow the function to alter current database values, return new user struct
        abort()
    }
    
    // Adds a new clothing item to the user's closet
    func addClothingItem(userID: String, clothingData: ClothingItem) async throws {
        // Add the new clothing item to the database
        let closetRef = Firestore.firestore().collection("users").document(userID).collection("closet")
        try closetRef.addDocument(from: clothingData)
        
        // Update the clothingIDs to be their real, firestore-given ids
        let closet = try await Firestore.firestore().collection("users").document(userID).collection("closet").whereField("id", isEqualTo: "tempID").getDocuments()
        for document in closet.documents {
            if document == document {
                let realID = document.documentID
                try await document.reference.updateData(["id" : realID])
            }
        }
    }
    
    // Takes a userID and clothingID and overrides the data of an existing clothing item
    func updateClothingItem(userID: String, clothingID: String, clothingData: ClothingItem) async throws {
        // Attempts to update the data of the given clothing item
        try Firestore.firestore().collection("users").document(userID).collection("closet").document(clothingID).setData(from: clothingData)
    }
    
    // Adds new outfit to the user's outfits collection
    func addOutfit(userID: String) async throws {
        // TODO: create an array of clothing id's
    }
    
    
    /* DELETE */
    
    
    // Delete all users
    func deleteAllUsers() async throws {
        
    }
    
    // Delete user
    func deleteUser(userID: String) async throws{
        // TODO: have it remove the users info from the database & put them at login screen
    }
    
    // Delete clothing item and remove it from outfits it's in
    func deleteClothing(userID: String) async throws{
        // TODO: remove a piece of clothing from the database and remove it from any outfits that it is in
    }
    
    // Delete an outfit
    func deleteOutfit(userID: String) async throws{
        // TODO: remove an outfit from the database
    }
}
