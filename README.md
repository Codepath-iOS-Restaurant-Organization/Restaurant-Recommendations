# Restaurant-Recommendations
## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Restaurant recommendation app for friends, family, and couples who have a hard time deciding where to eat.

### App Evaluation
- **Category:** Social Networking / Restaurants / Food
- **Mobile:** This app would be primarily developed for mobile but in the future could be easily converted to a website.
- **Story:** Users add restaurants they would like to dine at. Then they can add friends and get recommendations based on restaurants in both user's list.
- **Market:** Any individual who needs help deciding where to dine at.
- **Habit:** This app would be used whenever a user needs to figure out where to eat. I am asumming this app won't be used daily by a user but weekly or monthly.
- **Scope:** In the beginning this app would be among friends. But in the future it can evolve into a app that can just give you recommendations not needing another user's list. Also in the future this app can grow into a app that can give recommendations for a group of people and not just a single friend.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User login 
- [x] User register
- [x] Search restaurants
- [x] Add restaurants to favorites
- [x] Add friends
* See friend's favorited restaurants
* Restaurant recomendtions based on both user's restaurant list.

**Optional Nice-to-have Stories**

* Texting a friend within the app to look at a restaurant.

### 2. Screen Archetypes

* Login / Register Screen
* User Profile Screen
   * See total amount of friends.
   * See favorited restaurants in a collectionView.
   * Add a new friend.
   * Go to search screen.
   * Go to friends sceen.
   * Log out user.
* Search Screen
    * Provides restaurants based on user's text entered.
    * Show results in a tableView.
    * When clicking cell go to restaurant detail page.

* Restaurant Detail Screen
    * Shows details of the restaurant.
    * Can add this restaurnt to your favorites.
* Friends screen
    * See all friends in a tableView.
    * When clicking a cell go to recommendation page.
* Recommendation Screen
    * TableView with two sections.
    * First section is recommended restaurants.
    * Second section is friend's other restaurants.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Won't be using tabs.

**Flow Navigation** (Screen to Screen)

* Login page
   * Login -> Homepage
* HomePage
   * Homepage -> Login page, when sign out is clicked.
   * Homepage -> Search screen, when seach button is clicked.
   * Homepage -> Friend screen, when friend label is tapped.
* Seach Screen
    * Seach Screen -> restaurant detail, when cell is tapped.
    * Seach screen -> Home page, when back button on navigation bar is clicked.
* Restaurant Detail Screen
    * Restaurant Detail -> Home page, when add to favorites button is tapped.
    * Restaurant Detail -> Seach screen, when back button on navigation bar is tapped.
* Friend Screen
    * Friend Screen -> Recommendation screen, when tableView cell is clicked.
    * Friend Screen -> Home page, when back button on navigation bar is clicked.
* Restaurant Recommendatoin Screen
    * Restaurant Recommendatoin Screen -> Restaurant detail screen, when tableView cell is clicked.

## Wireframes
<img src="https://i.imgur.com/KM5pDwT.png" width=600>



## Schema 

### Models

#### Users
| Property | Type | Description |
|----------|------|-------------|
|email| String| Email of user|
|friends|Array of Strings|emails of user's friends|
|favoriteRestaurants| Array of Strings| id's of restaurants from the yelp api|
|profilePicture| String| user's profile picture image url|


### Networking
All network calls are broken down into three helper classes: FirebaseHelper, Search, & UserInformation. Just intialize class and call functions written ex:
let firebase = FirebaseHelper()
firebase.signInUser or .signUpUser or .addFriend or .addRestaurant ...

Example of a function inside one of the classes:

func signUpUser(userEmail: String, userPassword: String){
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (results, error) in
            
            if let e = error {
                self.delegate?.error(error: e)
            }
            else {
                self.delegate?.signUpSuccessful()
            }
        }
    }


- LoginViewController:
    - (Read/GET) Check to see if user exist's
      - let firebase = FirebaseHelper()
      - firebase.signInUser(userEmail: String, password: String)
    
    - (Create/POST) Authenticate a new user. Add user email to database.
      - firebase.signUpUser(userEmail: String, password: String)

- HomeViewController:
    - (Read/GET) Get all of user's friends.
        - let user = UserInformation()
        - user.getUserFriends(email: String)
    - (Read/GET) Get all of user's favorite restaurants.
        - user.getUserRestaurants(email: String)
    - (Create/POST) Add a new friend
      - firebase.addFriend(friendName: String)
    - (Create/POST) Upload profile picture
      - firebase.uploadProfilePicture(email: String, image: UIImage)
    - (Read/GET) Get all of user's favorite restaurant details from yelp
      - search.getSingleRestaurant(restaurantID: String)
    
- SearchViewController:
    - (Read/GET) Get restaurants from user entered text.
      - let search = Search()
      - search.performSearchApiRequest(lattitude: String, longtitude: String, restaurantName: String)
    
- RestaurantDetailViewController:
    - (Create/POST) Add a restaurnt id to user's favorite restaurants list
      - firebase.addFavoriteRestaurant(theID: String)
    
- FriendsTableViewController:
    - (Read/GET) Get friends profile pictures
      - user.getProfilePicture(email: String)
    
- RecommendationTableViewController:
    - (Read/GET)Get selected friend's favorite restaurants to compare with current user
      - friend.getUserRestaurants(email: String)

### API Endpoints
#### Yelp Api

- Base URL: https://api.yelp.com/v3/businesses/search

| HTTP Verb | Endpoint | Description |
|-----------|-----------|-----------|
|GET|/term|Search term, for example "food" or "restaurants". The term may also be business names, such as "Starbucks".|
|GET|/term="Restaurant"/categories=restaurants|Only get business that are restaurants. 

- Base URL: https://api.yelp.com/v3/businesses/{id}
    - Get business details of a specific business.

## Build Progress

### Login / Register
![login](https://user-images.githubusercontent.com/19720373/116739827-27b73600-a9c2-11eb-8703-c3268206eb72.gif)

### Add Friends & Sign Out
![add_Friend_Signout](https://user-images.githubusercontent.com/19720373/116739979-5a612e80-a9c2-11eb-9698-aedffaf95eac.gif)

### Search Bar

![searchBar](https://user-images.githubusercontent.com/19720373/116740007-651bc380-a9c2-11eb-92da-851f0326a9fb.gif)

## Build Progress 2

### Home Update: Choosing Profile Picture
![newHomeUpdate](https://user-images.githubusercontent.com/19720373/117508781-243e2480-af57-11eb-98a7-428ebe204e4b.gif)

### Search Update: Can Search For A Restaurant

![giphy](https://user-images.githubusercontent.com/19720373/117508850-3a4be500-af57-11eb-9b5a-a36a019032e6.gif)

## Build Progress 3

### Home Update: Show Profile Image And Total Amount of Friends
![homeView](https://user-images.githubusercontent.com/19720373/118346385-fb92cd80-b508-11eb-983e-480d488c181b.gif)

### Friend Update: Show User's Friends

![friends](https://user-images.githubusercontent.com/19720373/118346395-0d747080-b509-11eb-9be9-8b0386bdc40c.gif)


### Detail Update: Show Details of Restaurant

![detail](https://user-images.githubusercontent.com/19720373/118346414-22e99a80-b509-11eb-800d-c3c73bb09ce6.gif)




