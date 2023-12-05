# Fit Check App 
## By Adalia Williams, Xan Kansil, Corinna Plefka, John Sailliard, and Sean St. Clair

### Instructions to run 
Clone the repo on Xcode and build and run the app as normal. Pictures may have to be on local computer and reuploaded to assets. 


### Description 
Our app mimics a virtual closet application. The user is first asked to make an account to store their closet on. The app has features to add your own clothing items to your closet as well as making outfits from the items in your closet. There is also a social media like aspect to our app where a user has a personal profile to share their favorite outfits too. 


### Using The App 
When first launching the app the user will be prompted to login. The user will need to create an account and then use those credentials to login again after. Once logged in the user is able to use the navigation bar at the bottom to navigate through the main screens. 

The add clothing screen allows the user to add a clothing item to their closet by taking a picture of it and filling out prompts about the basic information of the item. Once completed the clothing item will upload to the database. 

The create an outfit screen allows a user to create an outfit from the clothing items that are in the closet. On the left side of the view the user can see tops, bottoms, and shoes and scroll horizontally along the categories to create outfit ideas. The right side of the view allows a user to go into their closet to view their clothing items. 

The closet screen displays the clothing items in the closet and allows the user to search and navigate through their closet. The closet is sorted by different categories of clothing. 

The profile screen shows a user's profile and displays a few fun questions about the user's fashion interest and about their closet. 

The home feed screen displays what a user's favorite outfits are. The feed shows a picture of an outfit as well as a title and description of the outfit. 


### Features 
Our app uses a Google Firebase as the server connection. The user's account information as well as closet information is stored on there. The closet data pulls from the datbase of clothing items. Our system uses a file called UserManager to navigate between the database and the views. 
