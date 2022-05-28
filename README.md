# Statify
A Music Discovery and Spotify Profile Visualizer web app. 
Built with Flutter and Spotify Web API. :blue_heart::green_heart:

#### Check out the live app at: https://stat-ify.web.app

### Table of Contents
- [Running Statify Locally](https://github.com/induviduality/statify/blob/main/README.md#rocket-running-statify-locally)
- [Features](https://github.com/induviduality/statify/blob/main/README.md#dart-features)
- [Toolchain](https://github.com/induviduality/statify/blob/main/README.md#%EF%B8%8F-toolchain)
- [Why Statify](https://github.com/induviduality/statify/blob/main/README.md#star-why-statify--inspiration)
- [Challenges Faced & Learnings](https://github.com/induviduality/statify/blob/main/README.md#memo-challenges-faced-and-learnings)
- [What's Next for Statify? [Future Scope]](https://github.com/induviduality/statify/edit/main/README.md#construction-whats-next-for-statify)
- [Feature Requests & Bug Reporting](https://github.com/induviduality/statify/edit/main/README.md#feature-requests--bug-reporting)

## :rocket: Running Statify locally

### Setting up the Spotify Web API

-   Head to  [developer.spotify.com](https://developer.spotify.com/).
-   Login with your Spotify account.
-   Once redirected to your Dashboard, Click on 'Create an App'.
-   Register your app by giving it a name and a description in the pop up that appears.
-   Under the field to add `Redirect URIs` add: 
	 ```
	 https://induviduality.github.io/local-redirect/
    ```
     (Make sure to include the `/` at the end too)
-   In your app dashboard, copy the  `Client ID`  and paste it somewhere safe till we use it in the following steps.
-   Click on  `Show Client Secret`  to reveal your  `Client Secret`  and copy the same.

> ❗  Your Client ID and Client Secret are to be highly confidential. Do not make it public at any cost. 

### Running the app:
- Clone this repo to your local machine.
- Ensure that you have the latest version of Flutter installed correctly. Use `flutter pub get` to get any missing dependencies, if needed.
- Navigate to the `lib` folder in the repo and create a file called `config.dart`. 
- Paste the following lines into `config.dart` :
  ```
  const  String clientID = 'CLIENT_ID';
  const  String clientSecret = 'CLIENT_SECRET';
  const  String redirectUri = 'https://induviduality.github.io/local-redirect/';
  ```
- Replace `CLIENT_ID` with the `Client ID` and `CLIENT_SECRET` with the `Client Secret` we copied from the dashboard. Note that both the credentials must be enclosed in single quotes.
- Run the app from the terminal using the command: 
```flutter run --web-port=8080```
Choose an available web browser to run on. Chrome is often fastest to run.
>**Why `--web-port=8080`?**
> Flutter randomly assigns port numbers at runtime. 
> 
> There are a few limitations in Flutter for Web platforms that hinder the app from listening to callbacks. Hence, the app manually retrieves the callback response from the redirect URI. 
> 
> This is done by making the page at `redirect_uri` to redirect to the localhost app manually. The port number must be known by the page for it to redirect. Specifying a specific port stops the randomization of these port numbers, allowing the page to redirect correctly.

## :dart: Features
- Spotify Authentication
- User Listening Style Analysis based on the features of the songs they listen to
- View User's Top Tracks
- View User's Top Artists
- View Track Stats by popularity, duration, release date
- Search for Songs
- Generate Song Recommendations based on a song
- Save Recommendations directly to a new Playlist
- Clean and simple UI/UX

## 🛠️ Toolchain
- Flutter
- Spotify Web API
- Material UI
- Firebase
- Git
- Little bit of HTML & JS

### Hosting
The Web app is hosted on Firebase. Check out the [official documentation on Firebase Hosting](https://firebase.google.com/docs/hosting/quickstart) to host the project.

## :star: Why Statify? // Inspiration

### Music Discovery
I'm sure there's been at least one time where you were vibing to one of your favourite songs wondered if you'll ever be able to find a song as great as that one. Enter Statify. Statify's music discovery feature allows users to discover songs similar to the song they provide as input. What's more? Users can save the recommendations as a playlist as well!

The Music Discovery part of the app contains two parts: searching for a song to seed as input, and fetching recommendations. These will be used to illustrate the significance of searching and sorting algorithms, as required by the Problem Statement.

### Profile Visualizations
Everyone loves Spotify Wrapped. We love to look back at our music and reflect upon it. Spotify Wrapped is simply a fun and feel-good experience for the users to flaunt their streaming habits. But the downside? Wrapped comes out only once a year, leaving us wanting more. 

Statify caters to exactly that. Statify allows users to look at their Spotify profiles at a deeper level than Wrapped at any time they wish. It comes with more visualizations of their streaming habits which your usual Wrapped doesn't show you.

This part adds a fun element to Statify. It uses sorting algorithms to process the streaming data of the user to provide the statistics.

## :memo: Challenges Faced and Learnings
- Being very new to Flutter, it felt daunting to comprehend how Flutter and its widget structure works. Working on this project helped me accelerate my learning curve by a mile.
- It was a great exercise to deal with an ambiguous problem statement and come up with ideas - gave a feel of what to expect in the industry
- Learnt a great deal about algorithms - classification and recommendation algorithms in particular. Found myself down a reading spiral as I read up about the math and algorithms during my research about the project.
- Understood deeply with regards to how user authentication and OAuth2.0 work.
- Since support for Web platforms in Flutter is new, I couldn't automate the process of receiving the authorization code after user authentication. It took me a lot of time to figure out what as going wrong and why when I tried to automate it. I eventually found a workaround to complete the authentication manually.
> **Flutter Limitations**
>  Flutter does not have an implementation to listen to link streams on Web platforms yet. Thus, listening to callbacks and retrieving the response can't be automated, unlike websites built with JavaScript.
>  In order to overcome that limitation, the app uses 2 additional pages to manually retrieve the callback response and pass it to the app.
>  - The first page is the page at the `redirect_uri` registered with the Spotify API. It contains a link which the user is prompted to click. On clicking, it redirects to a page within the app along with the callback response as arguments.
>  - The second page retrieves the arguments from its URL and passes it on to the upcoming pages for usage. This page resides within the app itself.

## :construction: What's next for Statify?

 - [ ] Add sharing profile as images for external sharing
 - [ ] Make Website more responsive
 - [ ] Add more timeframes to filter for Top Tracks & Artists

## Feature Requests & Bug Reporting

Feel free to  [open an issue](https://github.com/induviduality/statify/issues)  on GitHub if you encounter any bugs, or would like to see any additional features that can enhance this project!
