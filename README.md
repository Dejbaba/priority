README

Project Name: Priority Test

PROJECT SETUP INSTRUCTIONS:

1)Clone the repository: git clone (https://github.com/Dejbaba/priority.git)

2)open project in preferred IDE(Android Studio or VS Code)

3)fetch all dependencies and run project

4)set entry widget to 'Container()' then run seed method for products upload to firestore

5)deploy firebase function so it can calculate average rating for each seeded products when the initial review data is 'seeded'

6)run seed method for initial reviews upload to firestore

7)set entry widget to 'Discover()' to access the app

ASSUMPTIONS MADE DURING DEVELOPMENT:

1)I assumed users were already authenticated to use the app. i simulated authentication by generating a unique id for each device that use the app.

2)I assumed the system(E-commerce platform) already has a list of products(sneakers). I simulated this by 'seeding' 70 products into the fire store. i also 'seeded' reviews for all products

3)I assumed that when a user creates an order successfully, the products in that order are paid for, and this allows the user to be able to write a review for the purchase products

CHALLENGES FACED AND HOW I OVERCAME THEM:

Challenge 1: Product Specifications and limited assets(images).

Solution: It was a bit difficult to define product specifications due to the limited image assets provided. Only images for Nike, Adidas and Jordan were provided. So i used only 3 sneaker images(Nike, Jordan and Adidas), then generated random names using the available brand with a unique identifier to make sure all product names are distinct. This also gave me the opportunity to simulate how the app would behave
when certain products aren't available.

Challenge 2: Textformfield Input for quantity value when adding to cart

Solution: This was challenging because it introduced many edge-cases such as users being able to input any numeric value which might turn out to be greater than the quantity available for a particular product.This was solved by doing a check to compare the user's input with the available quantity of the selected product and providing feedbacks to user where needed.

Challenge 3: No Scope or Acceptance Criteria for Filter Screen

Solution: This was a bit challenging because the use case is vast. This was solved by narrowing down filter implementation to just one selection per filter category provided in the design

Additional Features or Improvements Added:

Feature 1: Wishlist Implementation

A 'heart' icon was added to each product item on the 'discover' screen to allow users add items to wishlist. This was also added 
to the carousel on the product details screen.
When a user adds an item to wishlist, a wishlist icon appears close to the cart icon which allow users access their wishlist where they can perform actions such
as 'delete' on each wishlist item. When the wishlist is empty, the wishlist icon close to the cart icon disappears.

Feature 2: Review Product

When a user creates an order successfully, this is seen as an item purchase. This gives the user the ability to review the product(s) purchased. When a user navigates to the 
review section of the product details screen for a product purchased, the user would see a 'review product' text which when clicked,
reveals a bottom-sheet for the user to review the product

Feature 3: Order Screen

This is more of an improvement. I added a order screen so that users can see the list of orders created on the app.
