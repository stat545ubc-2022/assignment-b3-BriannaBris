# Assignment B3 - Creating the "Playing with Penguins" Shiny App

## Introducing the "Playing with Penguins" Shiny App

For this assignment, I chose **Option B:** to create my own Shiny app, using the `palmerpenguins::penguins` dataset.  The "Playing with Penguins" Shiny app allows you to filter the penguins dataset by *Year* and *Island* and compare bill length, bill depth, flipper length and body mass between penguins species under the chosen parameters.  After selecting your desired year and island from the side bar menu, the app will output a corresponding violin plot and data table.

You can access and deploy the app [here](https://4tyn88-brianna0bristow.shinyapps.io/Penguins/).

## The **Penguins folder** contains...
- the *app.R file* holds the raw code for the Shiny app
- the *rsconnect folder* holds the necessary files for running and deploying app 
- the *www folder* where app images are stored

## About the `penguins` Dataset

The data used in this Shiny app is from **palmerpenguins** package and can be loaded into R via the following code chunk: `install.packages("palmerpenguins")`.  Data in this package was collected and made available by Dr. Kristen Gorman and the Palmer Station, Antarctica LTER, a member of the Long Term Ecological Research Network.  The penguins dataset contain data for 344 penguins, collected from 3 different species and 3 islands in the Palmer Archipelago, Antarctica.
