Pursuit-Core-iOS-Images-Lab

1. xkcd comic Viewer

Documentation

 

Create an app with a single screen with a:

UIImageVIew
Stepper
TextField
Two Buttons ("Most recent" and "Random") 
The image view should display an xkcd comic.
Changing the stepper value up or down should display the comic from the next or previous day.
The user should be able to type a number into the textField to go to that numbered comic.
The "Most recent" button should go to the most recent comic.
The "Random" button should go to a random comic.
The text field and stepper should update accordingly whenever the comic changes.
 

2. Pokemon Cards

Documentation

 

Create an app with a viewController with a table view that segues to a detail view controller.

The first view controller should have a:

Search Bar
Table View
Searching for a card will load new data matching the description.  The table view should only should the images for the cards.  Selecting a pokemon card should segue to a detail view controller with:

A high-res image
Its name
Its types
Its weaknesses
Its set
3. Random User API

Documentation

 

Create an app with a table view controller and a detail view controller.

The tableview controller (or UIViewController with a tableView) should load a list of random people.  Use a custom tableView cell that contains their:

Profile picture (thumbnail),
Name
Age
Cell phone number
Selecting a cell should segue to a detail view controller that has their:

Large Image
Name
Age
All phone numbers
Location
