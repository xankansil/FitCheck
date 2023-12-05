import SwiftUI

struct CameraView: View {
    @EnvironmentObject var newClothingItem : ClothingObject
    
    @State private var image: Image? = Image("karthick")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    var body: some View {
        // WARNING: Force wrapped image for demo purpose
        
        
        Text("Click here to take or upload photo")
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
        
//        print(\(newClothingItem.closetObject.category))
//        print(\(closetObject.clothing))
//        print(\(closetObject.weather))
//        print(\(closetObject.occasion))
//        print(\(closetObject.color))
        
        image!
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
            .frame(width: 200, height: 200, alignment: .center)
            .clipped()
            .shadow(radius: 10)
            .onTapGesture { self.shouldPresentActionScheet = true }
            .sheet(isPresented: $shouldPresentImagePicker) {
                SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
        }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = true
            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = false
            }), ActionSheet.Button.cancel()])
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
