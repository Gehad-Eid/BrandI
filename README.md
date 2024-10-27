
# BrandI - Social Media Post Organizer App

## Project Overview

**BrandI** is a SwiftUI app designed to help content creators organize and manage their social media posts more effectively. Users can upload posts with images, text, and other details, and the app provides personalized recommendations to enhance the quality of their content. The app integrates with Firebase for user authentication and Firestore as the back-end database for storing user data, posts, and events.

---

## Features

- **User Authentication**: Sign up, sign in, and manage accounts using Firebase Authentication.
- **Firestore Integration**: Store user data, posts, and events in Firestore, with each item linked to the authenticated user.
- **Post Recommendations**: Get personalized suggestions for improving social media posts based on content analysis, using Hugging Face’s CLIP model.
- **Siri Integration**: Create posts and events using voice commands with Siri for hands-free operation.
- **Calendar View**: View all upcoming posts and events in a calendar format, with insights on what’s planned for the next month, week, and tomorrow, helping users stay organized.
- **Social Media Posting**: Post directly to **TikTok** and **Instagram**, allowing users to quickly share their content across platforms without leaving the app.
  
---

## Project Structure

- **Views**: 
  - SwiftUI views for creating, viewing, and managing posts and events.
  - A calendar view that displays upcoming posts and events with quick insights.
- **Models**: 
  - `Post`: Represents a social media post with attributes like `title`, `content`, `date`, `platforms`, and `recommendation`.
  - `Event`: Represents an event with `title`, `content`, `startDate`, and `endDate`.
  - `DBUser`: Represents user data, including their email, user ID, and associated posts or events.
- **ViewModel**: 
  - `ProfileViewModel`: Handles the logic for retrieving and managing user data from Firestore and keeping the UI updated.
  - `CalendarViewModel`: Manages the calendar insights, displaying posts and events according to their time frame (e.g., tomorrow, week, month).
- **Firebase Integration**: Manages user authentication and stores user-related data in Firestore, including their posts and events.

---

## Features

1. **User Authentication**: 
   - Users can sign up, log in, and manage their accounts securely with Firebase Authentication.

2. **Post and Event Creation**: 
   - Users can create social media posts and schedule events, both of which are stored in Firestore.
  
3. **Siri Integration**: 
   - Users can create posts and events using Siri, allowing for hands-free organization.
  
4. **Post to Social Media**: 
   - Users can publish their posts directly to **TikTok** and **Instagram**, simplifying the process of sharing content on these platforms.
  
5. **Calendar View**: 
   - A calendar feature provides a comprehensive view of upcoming posts and events. It offers insights on what's planned for the next month, week, and tomorrow to help users stay on top of their schedules.
  
6. **Post Recommendations**: 
   - The app gives recommendations to enhance social media posts based on the content, using Hugging Face’s CLIP model.

---

## Project Structure

- **Views**: 
   - The app's UI is built using SwiftUI, making it easy to create, view, and manage posts and events.
   - A calendar view allows users to see their upcoming schedule of posts and events, sorted by day, week, or month.
  
- **Models**: 
   - `Post`: The data model for a social media post, which includes details like `title`, `content`, `date`, `platforms`, and personalized `recommendation`.
   - `Event`: The model for events, with attributes like `title`, `content`, `startDate`, and `endDate`.
   - `DBUser`: The model for users, including their authentication info and associated posts or events.

- **Firebase Integration**: 
   - The app utilizes Firebase Authentication for secure user login and Firestore to store user data, including posts and events.

---

## Setup Instructions

1. **Clone the Repository**: Download or clone the **BrandI** project files to your local machine.

2. **Install Dependencies**:
   - Ensure Firebase SDK is installed. If needed, add it via Swift Package Manager or Cocoapods.
   - Follow [Firebase Setup Instructions](https://firebase.google.com/docs/ios/setup) to integrate Firebase into the app.

3. **Configure Firebase**:
   - Add your Firebase project’s `GoogleService-Info.plist` to the Xcode project.
   - Set up Firestore and Firebase Authentication in your Firebase Console.

4. **Running the App**:
   - Open the project in Xcode.
   - Connect the project to your Firebase setup.
   - Run the app on a simulator or a physical device.

5. **Post and Event Model**:
   - The `Post` model includes fields like `title`, `content`, `date`, `platforms`, and `recommendation`. Users can create posts and view them in the app, and posts are stored in Firestore under each user’s document.
   - The `Event` model includes attributes for event scheduling, such as `title`, `content`, `startDate`, and `endDate`.

---

## Firebase Configuration

1. **Firestore**:
   - Users’ posts and events are saved under the `users` collection. Each user document contains subcollections `posts` and `events` where their individual posts and events are stored.

2. **Firebase Authentication**:
   - User authentication is required for accessing and managing posts and events.

---

## Future Enhancements

- Integrate with additional social media platforms.
- Add notifications for upcoming post and event deadlines.
- Expand the recommendation feature for more advanced content optimization.

---

## Credits

- **Project Name**: BrandI
- **Technologies Used**: SwiftUI, Firebase, Firestore, FireStorage, Hugging Face (CLIP model), Siri
