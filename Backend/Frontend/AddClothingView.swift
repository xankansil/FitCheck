//
//  AddClothingView.swift
//
//This view will allow the user to take pictures and add clothing to the database/ their closet

import SwiftUI

struct AddClothingView: View {
    //@EnvironmentObject var newClothingItem : ClothingObject
    
    
    // TODO: have the susbequent views of the item-creating-process see, edit, and pass along the global variable. Then submit to the DB
    // I have been mainly trying to test and debug these processes in the SeasonQuestionView to pass the global variable.
    // and the ColorQuestionView to test passing along the hopefully updated global variable info to the db
    
    // Both of the above issues seem to be running into the same issue of not seeing the necessary variable/function within scope.
    // even though they should both be visible within those files. It seems like declarations of the variable and the function are
    // proper and shouldnt be problematic.
    
    // Part of me is wondering if this issue is not coming from something on our end, but on swifts. Just like how it was not able to detect
    // and jump to views outside of the current folder, even though every source online and in person said it should be
    
    
    var body: some View {
        NavigationStack{
            VStack(
                spacing: 50
            ) {
                NavigationLink(destination: AddTopView()){
                    //newClothingItem.closetObject.category = CategoryType.top
                    Text("ADD TOPS")
                }
                NavigationLink(destination: AddBottomsView()){
                    Text("ADD BOTTOMS")
                    
                }
                NavigationLink(destination: AddFullBodyView()){
                    Text("ADD FULL BODY")
                }
                NavigationLink(destination: AddOuterwearView()){
                    Text("ADD OUTERWEAR")
                }
                NavigationLink(destination: AddShoesView()){
                    Text("ADD SHOES")
                }
            }
            .navigationTitle("Add Clothing")
            
        }
    }
}

struct AddClothingView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothingView()
    }
}
