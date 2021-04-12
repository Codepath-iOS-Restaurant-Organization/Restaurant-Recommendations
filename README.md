# Restaurant-Recommendations
## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Restaruant recommendation app for friends, family, and couples who have a hard time deciding where to eat.

### App Evaluation
- **Category:** Social Networking / Restaurants / Food
- **Mobile:** This app would be primarily developed for mobile but in the future could be easily converted to a website.
- **Story:** Users add restaurants they would like to dine at. Then they can add friends and get recommendations based on restaurants in both user's list.
- **Market:** Any individual who needs help deciding where to dine at.
- **Habit:** This app would be used whenever a user needs to figure out where to eat. I am asumming this app won't be used daily by a user but weekly or monthly.
- **Scope:** In the beginning this app would be among friends. But in the future it can evolve into a app that can just give you recommendations not needing another user's list.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User login
* User register
* Search restaurants
* Add restaurants to favorites
* Add friends
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
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
