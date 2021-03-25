# WikiLocations

A project based on [wikipedia](https://github.com/wikimedia/wikipedia-ios) to test deeplinks.

## Author
Marcos A. González Piñeiro
- [LinkedIn](https://www.linkedin.com/in/marcosagonzalezpinheiro/)
- [Github](https://github.com/xdmarcos/)
- [Email](mailto:xdmgzdev@gmail.com)

## Description

- The assigment is splitted in two folders:
- **WikiLocations:** Contains the iOS Application related files.
- **wikipedia-ios-main:** Contains the modified Wikipedia iOS Application 

- Wikilocations, has 2 schemes (PROD and STAGE) this was meant just to demonstrate a possible project configuration for 2 environments.
- For the purpose of the assessment PROD should be used since it's pointing to the provided [resource](https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json)
- Stage scheme will fetch locations from a mocked server.

## Usage

First, the modified wikipedia project should be open, build and run in the simulator/device.
Once this is done, open Wikilocations.workspace` select `Wikiocations` scheme, and simple build and run on the same simulator/device.

------

## Features

- ✅ Find locations from two different APIs, the PROD (provided in assignment) and STAGE (mocked API)
- ✅ Display content of the selected API in a UITableView with Diffable datasources.
- ✅ All the UI is written programmatically using UIKit and Autolayout.
- ✅ Wikipedia project was modified to understand deeplinks to Places tab whith the selected location.
- ✅ Creation of modules containing the reusable components using SPM.
- ✅ Accessibility support for Dynamic Font Sizing.
- ✅ Beautiful UI in both Light and Dark mode.
- ✅ Localized into three languages: English(default), Spanish, Dutch.
- ✅ Unit tests for somo of the main components.

## Roadmap

- ❒ Modify Wikipedia project to understand test app custom deep-links
- ❒ Add project setup with 2 schemes and 4 configurations
- ❒ Add packages to provide support to read plist, networking, UI and common components.
- ❒ Add MVVM components and logic.
- ❒ Add support for diffable datasources.
- ❒ Add support for dark mode and dynamic sizes.
- ❒ Add code queality tool configurations
- ❒ Add locasitions for different languages.
- ❒ Add unit test target and tests


## Personal Goals

I took this opportunity to experiment with new tools and frameworks and pay attention to good practises.

- ✅ Use MVVM linked with Combine framework or protocols. Finally I've decide for the version without Comine (this version cam be checked in the `Combine branch)
- ✅ Try Diffable datasources.
- ✅ Project configuration and schemes.
- ✅ Make use of SPM for local dependencies.
- ✅ Colors catalogue for Light and Dark Mode.
- ⚠️ Apply dependency injection and dependency inversion through protocol. 

------

## Project Architecture

This project follow the [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) design pattern.

## Dependencies

The application has a dependency on [wikipedia](https://github.com/wikimedia/wikipedia-ios) iOS App, is not an internal dependency, 
the app does not need wikipedia to work but to complete the full flow of the assigment the modified Wikipedia app must be installed on the same device/simulator.

### Localization

This project uses `Localizable.strings` and `InfoPlist.strings` to localize the app. This files can be found at `WikiLocations/App/Supporting Files` folder.

## Project Structure

- **Packages**: Contains the local SPM packages. Common, CommonUI, LightURLSessionDataTask, NetworkProvider and PlistReader.
- **WikiLocations:** Contains all the files related to the iOS Application.
- **App:** Contains the AppDelegate and the Configuration files and SupportingFiles. In case this project needed to support multiple scenes. The SceneDelegate would also fall under this folder.
- **Model:** Contains the files related to the model objects. 
- **ViewModel:** Contains the files part of the View model component. 
- **Repository:** Contains the files to provide the locations list to the view model.
- **Services:** Contains the files to provide the locations from the network API.

## Architecture

The project was build using the **MVVM**  design pattern. The reason for it was that for the size of this project, this pattern maintains the project structure simple enough and wihtout much boilerplate while still providing all the benefits of any other clean architecture. The main focus being on reusability and testability.

## Navigation

For the current project, and with the intention of keeping things simple enough, the locations from the provided service API will be shown in a tableView.
When a cell is selected by the user, the app will open wikipedia via through deep-link showing the `Places` tab and the selected location on map.

## Unit Tests

The project at its current state contains a set of tests for the main components of the app, such as ViewModels, Repository, Services and Model.

The tests follow the Given/When/Then format.

Ex. `testLoadData_whenItsAbleToLoadTheContent_updatesDataSource`

## UI Tests

The project at its current state doesn't contain any UI Tests.

The plan was to do them by making use of the [KIF Framework](https://github.com/kif-framework/KIF) and following the [Robot Pattern](https://academy.realm.io/posts/kau-jake-wharton-testing-robots/).

**Benefits:**

- **KIF:** The benefits of this framework are several, among which I could highlight:
- Allows you to perform functional tests on your views instead of integration tests. 
- The framework runs on the UnitTests target, which gives you the possibility to perform white box testing by mocking the dependencies. Something that it's not possible to do with the UITests targets.
- Because it runs on the UnitTests target, we can skip the navigation to specific parts of the app, and directly load the screen in its required state.
- **Robot Pattern:** The pattern is focused on splitting the `What` from the `How` Meaning that you have 2 entities responsable to run the set of tests. The first one is the `XCTestCase` which knows `What` to test and the second would be the `Robot` that knows how to execute the actions.


## Assumptions

During the initial analysis of the assigment I started thinking of what actually could bring value to it and if I decided to build my own components shuch a light and simple network layer,
and make use of good software development principles as SOLID, Dependency injection and Dependency inversion and design patterns as MVVM.

Once I started thinking about this, my attention went to two main features: 

- Modularizate the project using local swift packages.
- Enforce reusability and testability.
