# Munch!


## App Name: Munch!
### Tagline: 📸 Snap, Split, Rate: Group Dining Made Easy!
### [Backend Repository Link](https://github.com/yufanhao/munch-backend)
---------------
## Frontend
* Andrew Gao
* Jimmy Chen

## Backend
* Fanhao Yu
* Jason Guo
---------------
## App Description
#### This app simplifies bill splitting and food discovery among friends. Users can scan receipts, assign items to friends, and automatically send Venmo requests with the correct amounts. After payment, users can rate their assigned items from 0 to 5 stars and leave a short message. These ratings appear on user profiles and contribute to a shared home feed, where users can explore the highest-rated, store-specific food items. A built-in map displays the locations of these top-rated items, allowing users to discover great food nearby and tap to open Apple Maps for instant directions. Whether you're settling up or seeking your next favorite meal, this app makes dining out easier.
---------------

## App Requirements
* Multiple Screens: Includes login, signup, home page, food review pages, restaurant based pages, food category pages, profile page, camera page, and bill split pages.
* Scrollable View: The initial screen is animated and all screens listed above are scrollable, with some having vertical and horizontal scroll features in the same page.
* Networking Integration: Flask backend API integration with Alamofire used is all screens to fetch and post data to the Database. Used to store information such as food, restaurant, reivew, and user items.

---------------

## Features

### App Icon
![APPPP](https://github.com/user-attachments/assets/69596dad-2b01-42ce-a697-22e1b61f8bd3)

### App Launch Animation
##### Once the user opens the app, an animation plays before they are met with a login screen.
![iMockup - iPhone 15 Pro Max](https://github.com/user-attachments/assets/8a974788-0021-44f1-8bae-6efcb5c595fe)               ![iMockup - iPhone 15 Pro Max-1](https://github.com/user-attachments/assets/2d8d471d-de48-4d4e-97fc-dd0ee78991da)               ![iMockup - iPhone 15 Pro Max-2](https://github.com/user-attachments/assets/7cb9c7b4-168b-4e4e-903a-da4883d5eb3f)

### Login and Signup Pages
#### The user is first met with a login page, but if they don't have an account, they can sign up/create an account where they can either enter in a username and password or sign in via Google. Sign in with Google is made possible with the googlesignin-ios package, which was imported as a dependency. The login credentials (username and password) are sent to the backend through Alamofire networking, using a userViewModel to handle the intermediate layer between the view and model.
![iMockup - iPhone 15 Pro Max](https://github.com/user-attachments/assets/ebc0b03b-1cce-4c58-a50d-a0ee89d41e2c)               ![iMockup - iPhone 15 Pro Max-1](https://github.com/user-attachments/assets/601a9f16-2848-48b0-a506-600df1e37ac4)               ![iMockup - iPhone 15 Pro Max (1)](https://github.com/user-attachments/assets/1281fcf6-e7a8-4900-92e3-181613fb3c10)


---

### Home Page ~> ...
#### Includes:
* Search Button
* Foods Near You 
* Food Spotlight
  
![iMockup - iPhone 15 Pro Max](https://github.com/user-attachments/assets/b0780031-c2c4-482d-8829-777ea1d86f0b)

### Search Page ~> Food Category Page 
#### The search page allows users to type in a query and view a filtered list of food categories. When a category is selected, the app navigates to a screen showing all foods in that category, sorted by rating. From there, users can tap a food item to view and submit a review. This flow connects the search interface with category browsing and review submission, creating a smooth, multi-step user experience driven by state and navigation variables.
![iMockup - iPhone 15 Pro Max](https://github.com/user-attachments/assets/82868873-12ee-4cdc-a8c7-5744a28fae37)               ![iMockup - iPhone 15 Pro Max-1](https://github.com/user-attachments/assets/8ee697ff-06de-464d-aef2-abe6e35fbbd6)               

### Food Near You Page ~> Resturant Page ~> Apple Maps
#### When user's click on this, they get taken to a resturant specific page where all items on the resturants menu are displayed. Users are able to zoom in and out of the map and get directions to the resturant by clicking the location icon on the map, using apple maps. This page also allows users to click into food items to see and make reviews. Networking is implemented to fetch nearby resturants including their id, name, location, image_url, and menu. Like many displays in the app, images are rendered using Async Image. 
![iMockup - iPhone 15 Pro Max-1](https://github.com/user-attachments/assets/b5081dcb-a9e6-4b63-ad70-ad26f446e2b4)               ![iMockup - iPhone 15 Pro Max](https://github.com/user-attachments/assets/60e58be6-2aff-47dd-a43f-16a5a18392f2)

### Resturant Specific Item Page
#### On this page, user is able to view other user's reviews on a resturant specific item and also create and post their own reviews on that item. Networking is implemented to post and fetch user reviews based on message, rating, etc.
![iMockup - iPhone 15 Pro Max-2](https://github.com/user-attachments/assets/918a489d-9606-4b5a-93dd-5d1dd18c2318)               ![iMockup - iPhone 15 Pro Max-3](https://github.com/user-attachments/assets/f45ae2d8-c4b7-4657-a0a5-d90f900a9cdd)               ![iMockup - iPhone 15 Pro Max-4](https://github.com/user-attachments/assets/4e2e4e47-2d50-4de1-8de8-803f4df2831f)

---

### Scanning Page ~> Cropping ~> Analyzing ~> Bill Splitting Page
#### The receipt scraping and camera functionality of our app allows users to take a picture of a receipt, send it to the backend as a jpeg/jpg for processing, and receive structured JSON data representing the items on the receipt. When the user navigates to the scan page, a full-screen camera view opens automatically using a UIImagePickerController wrapped in SwiftUI. After the user captures a photo and confirms it, the image is passed back to the view, and the app triggers a network request to upload the image to the Flask backend, through a ViewModel and NetworkManager.

#### The image is sent as a multipart form-data POST request using Alamofire and receives a structured response containing the list of items, tax, tips, and total price. The app receives this response, updates its state with the parsed items, and automatically navigates to a split bill screen where the user can review and assign each item. This flow tightly integrates camera capture, image upload, backend processing, and client-side navigation to create a seamless user experience for digitizing receipts.

![iMockup - iPhone 15 Pro Max](https://github.com/user-attachments/assets/3ce3084c-7f03-4c1a-906f-dcc413ace1e5)               ![iMockup - iPhone 15 Pro Max-1](https://github.com/user-attachments/assets/75ef1975-b306-44e6-b65d-4593cf1f941d)              
![iMockup - iPhone 15 Pro Max-2](https://github.com/user-attachments/assets/41b014ca-a105-4364-b09b-ef847552d482)               ![iMockup - iPhone 15 Pro Max (2)](https://github.com/user-attachments/assets/a90a4aa0-dcf2-49d3-afc5-a4525dfe9e06)

---

### Profile page ~> Request Sent ~> Venmo Payment Page
#### User is able to accept Venmo requests from friends which automatically takes them to the Venmo app using a Venmo deep link initiated at the backend, with the amount pre-populated. Users are also able to rate the item that their friend assigned them to help populate the community and friend pages.
![iMockup - iPhone 15 Pro Max (4)](https://github.com/user-attachments/assets/ba0b742c-220c-4b55-a14b-2454ebd1d3d5)

![iMockup - iPhone 15 Pro Max](https://github.com/user-attachments/assets/b569467d-24fe-4938-90ac-7f9701287527)
![iMockup - iPhone 15 Pro Max-1](https://github.com/user-attachments/assets/12c8ae25-86a0-4501-a10f-be42804d09eb)

----
#### Thanks for Munching with us! 😎
