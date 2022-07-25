# Statify
A Music Discovery and Spotify Profile Visualizer web app. 
Built with Flutter and Spotify Web API. :blue_heart::green_heart:

**Check out the live app at: https://stat-ify.web.app** 

[Requires Credentials Registered with Spotify API, DM for test account credentials, or run it locally with your own account!]

#### Documentation available at: **[Statify - Complete Documentation](https://induja.gitbook.io/statify)**

## Table of Contents
- [Running Statify Locally](https://github.com/induviduality/statify/blob/main/README.md#rocket-running-statify-locally)
- [How does Statify demonstrate the use of algorithms?](https://github.com/induviduality/statify/blob/main/README.md#how-does-my-app-demonstrate-the-use-of-algorithms-in-streaming-apps)
- [Features](https://github.com/induviduality/statify/blob/main/README.md#dart-features)
- [Toolchain](https://github.com/induviduality/statify/blob/main/README.md#%EF%B8%8F-toolchain)
- [Why Statify? - The Inspiration](https://github.com/induviduality/statify/blob/main/README.md#star-why-statify--inspiration)
- [Challenges & Learnings](https://github.com/induviduality/statify/blob/main/README.md#memo-challenges-faced-and-learnings)
- [What's next? - Future Scope](https://github.com/induviduality/statify/blob/main/README.md#memo-challenges-faced-and-learnings)

## :rocket: Running Statify locally
Visit the docs page: [Running Statify Locally](https://induja.gitbook.io/statify/run-statify-locally/setting-up-the-spotify-web-api)

## ❔ Elaborating on the Engage Challenge Prompts
The documentation now contains the answers to the prompts given during Microsoft Engage's project challenge. You can find them [here.](https://induja.gitbook.io/statify/microsoft-engage-2022/elaborating-on-the-ms-engage-prompts)

## :dart: Features
- Spotify Authentication
- User Listening Style Analysis based on the features of the songs they listen to
- View User's Top Tracks
- View User's Top Artists
- View Track Stats by popularity, duration, release date
- Search for Songs
  - Responsive navigation with keyboard as well as mouse for input
- Generate Song Recommendations based on a song
- View Recommended tracks individually on Spotify
- Save Recommendations directly to a new Playlist
- Clean and actionable UI/UX
- Works well as a Progressive Web Application too! (PWA)

## 🛠️ Toolchain
### The Tech
<img src="https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg" height=40 /> <img src="https://www.vectorlogo.zone/logos/spotify/spotify-icon.svg" height=40 /> <img src="https://www.vectorlogo.zone/logos/firebase/firebase-icon.svg" height=40 /> <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Google_Material_Design_Logo.svg/800px-Google_Material_Design_Logo.svg.png?20170303121655" height=40 /> <img src="https://www.vectorlogo.zone/logos/git-scm/git-scm-icon.svg" height=40 /> <img src="https://www.vectorlogo.zone/logos/w3_html5/w3_html5-icon.svg" height=40 /> <img src="https://upload.vectorlogo.zone/logos/javascript/images/239ec8a4-163e-4792-83b6-3f6d96911757.svg" height=40 /> 

### The Tools
<img src="https://iconape.com/wp-content/files/ie/112455/svg/visual-studio-code-1.svg" height=40 /> <img src="https://icones.pro/wp-content/uploads/2021/06/icone-github-grise.png" height=40 /> <img src="https://www.vectorlogo.zone/logos/gitbook/gitbook-icon.svg" height=40 />

- Flutter: To build the website
- Spotify Web API: For fetching user data, search results, and recommendations using the API
- Material Design: UI System for beautiful apps
- Git: For Version Control
- Teeny bits of HTML & JS: For authentication workarounds
- VSCode: Source Code Editor
- GitHub: Code-hosting & VCS platform
- GitBook: For documentation

## :star: Why Statify? // Inspiration

### Music Discovery
I'm sure there's been at least one time where you were vibing to one of your favourite songs wondered if you'll ever be able to find a song as great as that one. Enter Statify. Statify's music discovery feature allows users to discover songs similar to the song they provide as input. What's more? Users can save the recommendations as a playlist as well!

The Music Discovery part of the app contains two parts: searching for a song to seed as input, and fetching recommendations. These will be used to illustrate the significance of searching and sorting algorithms, as required by the Problem Statement.

### Profile Visualizations
Everyone loves Spotify Wrapped. We love to look back at our music and reflect upon it. Spotify Wrapped is simply a fun and feel-good experience for the users to flaunt their streaming habits. But the downside? Wrapped comes out only once a year, leaving us wanting more. 

Statify caters to exactly that. Statify allows users to look at their Spotify profiles at a deeper level than Wrapped at any time they wish. It comes with more visualizations of their streaming habits which your usual Wrapped doesn't show you.

This part adds a fun element to Statify. It uses sorting algorithms to process the streaming data of the user to provide the statistics.

## :memo: Challenges Faced and Learnings
- Being new to Flutter, it felt daunting to comprehend how Flutter and its widget structure works. Working on this project helped me **accelerate my learning curve** by a mile.
- It was a great exercise to deal with an ambiguous problem statement and come up with ideas - gave a feel of what to expect in the industry.
- **Learnt a great deal about algorithms** - classification and recommendation algorithms in particular. Found myself down a reading spiral as I read up about the math and algorithms during my research about the project.
- Understood deeply with regards to **how user authentication and OAuth2.0 work.**
- Since support for Web platforms in Flutter is new, I couldn't automate the process of receiving the authorization code after user authentication. It took me a lot of time to figure out what as going wrong and why when I tried to automate it. I eventually found a workaround to complete the authentication manually.
- There were limitations with the Spotify API in handling users, which I'd discovered late into the project. It **taught me to investigate my choices** thoroughly.
- I picked up **Test-Driven Development** here. I hope to get better at it and incorporate more rigourous testing in my projects in the future.

> **Flutter Limitations**
>  Flutter does not have an implementation to listen to link streams on Web platforms yet. Thus, listening to callbacks and retrieving the response can't be automated, unlike websites built with JavaScript.
>  In order to overcome that limitation, the app uses 2 additional pages to manually retrieve the callback response and pass it to the app.
>  - The first page is the page at the `redirect_uri` registered with the Spotify API. It contains a link which the user is prompted to click. On clicking, it redirects to a page within the app along with the callback response as arguments.
>  - The second page retrieves the arguments from its URL and passes it on to the upcoming pages for usage. This page resides within the app itself.

## :construction: What's next for Statify?

 - [ ] Add sharing profile stats as images for external sharing (Half-implemented, just not supported on Web)
 - [ ] Make Website more responsive
 - [ ] Add more filtering options (for ex.: more timeframes for Top Tracks & Artists, add playlist options etc.)
 - [ ] Explore giving user control over their profile (filter options, custom profile link, etc.)

## Feature Requests & Bug Reporting

Feel free to  [open an issue](https://github.com/induviduality/statify/issues)  on GitHub if you encounter any bugs, or would like to see any additional features that can enhance this project!
