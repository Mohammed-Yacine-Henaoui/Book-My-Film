This project utilizes Flutter as the frontend framework, employing the BLoC state management pattern for efficient state handling. We have implemented a solid architecture consisting of distinct layers: UI (screens, widgets), Controller (BLoCs, events, states), and Data (web services, repositories, models).

In our architecture, the screen requests a specific state from the controller. The controller communicates with the repository, which interacts with the web services. Upon receiving the response from the web services, the repository updates the model, which is then consumed by the controller and passed back to the screen for display.

For the backend, we opted for Spring, structured around entities, repositories, services, and web services. This architecture enables clear separation of concerns, allowing for scalable and maintainable code. The @RestResourceController annotation facilitates the creation of RESTful APIs, which allow the frontend to interact seamlessly with the backend. We chose MySQL for our database, initializing our project with random data while adhering to all established rules to avoid conflicts.

# Class Diagram

![Class Diagram](front_end_gestion_cinema/images/uml.png)

# Screens of the Application

![photo 1](front_end_gestion_cinema/images/1.png)

![photo 2](front_end_gestion_cinema/images/2.png)

![photo 3](front_end_gestion_cinema/images/3.png)

![photo 4](front_end_gestion_cinema/images/4.png)

![photo 5](front_end_gestion_cinema/images/5.png)

![photo 6](front_end_gestion_cinema/images/6.png)

![photo 7](front_end_gestion_cinema/images/7.png)

![photo 8](front_end_gestion_cinema/images/8.png)

![photo 9](front_end_gestion_cinema/images/9.png)

![photo 10](front_end_gestion_cinema/images/10.png)

![photo 11](front_end_gestion_cinema/images/11.png)

![photo 12](front_end_gestion_cinema/images/12.png)

![photo 13](front_end_gestion_cinema/images/13.png)

![photo 14](front_end_gestion_cinema/images/14.png)

![photo 15](front_end_gestion_cinema/images/15.png)

![photo 16](front_end_gestion_cinema/images/16.png)

![photo 17](front_end_gestion_cinema/images/17.png)

![photo 18](front_end_gestion_cinema/images/18.png)

![photo 19](front_end_gestion_cinema/images/19.png)

![photo 20](front_end_gestion_cinema/images/20.png)

![photo 21](front_end_gestion_cinema/images/21.png)

![photo 22](front_end_gestion_cinema/images/22.png)

![photo 23](front_end_gestion_cinema/images/23.png)

![photo 24](front_end_gestion_cinema/images/24.png)

![photo 25](front_end_gestion_cinema/images/25.png)

![photo 26](front_end_gestion_cinema/images/26.png)

![photo 27](front_end_gestion_cinema/images/27.png)

![photo 28](front_end_gestion_cinema/images/28.png)

![photo 29](front_end_gestion_cinema/images/29.png)

![photo 30](front_end_gestion_cinema/images/30.png)

![photo 31](front_end_gestion_cinema/images/31.png)

![photo 32](front_end_gestion_cinema/images/32.png)

![photo 33](front_end_gestion_cinema/images/33.png)

![photo 34](front_end_gestion_cinema/images/34.png)

![photo 35](front_end_gestion_cinema/images/35.png)

# Requirements

- **Java 21**
- **MySQL** (Installed and running)
- **Dart SDK**
- **Flutter SDK**

# Run backend:

![jar](front_end_gestion_cinemaimages/java.png)



