//
//  Readme.md
//  FetchRecipe
//
//  Created by Lucas Knight on 4/24/25.
//

### Summary: Include screen shots or a video of your app highlighting its features

**Screenshots:** 

![Simulator Screenshot - iPhone 15 Pro - 2025-04-25 at 07 19 34](https://github.com/user-attachments/assets/c82b0c17-0ccb-4b3b-8466-2d529dd613fe)
![Simulator Screenshot - iPhone 15 Pro - 2025-04-25 at 07 19 47](https://github.com/user-attachments/assets/ba450967-92e1-48e1-80b9-cacce46d580d)
![Simulator Screenshot - iPhone 15 Pro - 2025-04-25 at 07 19 38](https://github.com/user-attachments/assets/8da54687-cde0-44cb-95be-0af222cbdb43)

**Recording:** (Had to lower quality to 480 to allow gitHub to show)

https://github.com/user-attachments/assets/2edd382e-0749-4c32-8cb0-dc2c14d96cbd


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized clean architecture using MVVM, and user-friendly error handling. These areas are key to building a scalable and maintainable SwiftUI app that could handle real-world conditions like slow networks, empty or malformed data. I also prioritized efficient image loading by implementing a custom caching layer to avoid unnecessary network requests. I also priortized SwiftUI Previews as they speed up development and help catch bugs as well as poor designs.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

About 10-11 hours over three days. The first day I spent my time setting up the initial architecture with the Model, ViewModel and the Service layer. The next day I focused on the image caching as this was a new feature for me this took me longer to set up the end result. I went through three different deisgns for the ImageCache. After that I spent some time cleaning up the UI and adding other features such as the RecipeDetailView (to show the youtube and source urls) as well as the search feature for the List. On the Last day I spent my time writing Unit Tests and polishing the app up with little fixes. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

One tradeoff was to keep the UI very minimal and focused on the required tasks. For example the recipe detail view is very bland and frankly not too useful to a user (app provides less than the webpage equivalent). I would have liked to spent more time adding more useful details for each recipe as well as options for viewing the source and youtube links within the app inside a WebView or VideoPlayer. This keeps the user more reliant on the app and increases its useabilty. 

Another tradeoff could potentially be the ImageCache. This was a new feature (creating from the ground up) for me. Due to this it went through a few interations and while I like the end product I dont know if its the best or most effcient solution. And I didnt want to spend too much more time on this to see if there was another version that could be more efficent. 

### Weakest Part of the Project: What do you think is the weakest part of your project?

On the surface the UI and usefulness of the project. As I dont believe there is enough infomation and use provided by the current version for it too provide a good product for a user. However thats not what this project aims to create or solve but I did want to point that out as I think the UI suffers from a bland UI due to this and app development should always have the user in the forefront of reasoning. 

Under the hood I would say the image caching, not that its bad or broken but I have the least amount of experience with it and therfore holds a little uncomfortability. This is in comparison to other parts of the app I have more experience with and am comfortable with its use such as SwiftUI design, MVVM pattern, the Service layer and error handling.   

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I want to provide the SwiftUI Previews set up. As they are not needed however I find alot of use in spending time up front to set these up. I personaly find them to almost act as UI and ViewModel Unit Tests since you have to spend some time thinking through how the app will handle different states and data and them get an instant verification of that in the Preview window. They are also useful in setting up Mock Scenarios such as the Error and Empty states shown below. This also allows for unessesary code to not be added to the production code (to test mocked scenarios with flags protecting them). In summary, when working in SwiftUI I do like to priortize Previews.

**RecipeListView Previews**

https://github.com/user-attachments/assets/cdd1bc6c-6774-4e8d-8ab9-2461731c34fd

**RecipeDetailView Previews** 

![Screenshot 2025-04-25 at 8 07 56 AM](https://github.com/user-attachments/assets/4871463a-32e2-4d9d-a74b-d120af725c68)

![Screenshot 2025-04-25 at 8 08 05 AM](https://github.com/user-attachments/assets/83c6d8ed-373e-417d-987e-ddd34f430e8b)
