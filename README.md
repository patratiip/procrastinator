# procrastinator

Link: https://procrastinator-2000.web.app/

Procrastinator is an educational Flutter application available on multiple platforms, including mobile devices (Android, iOS), tablets, web, as well as Windows and macOS. It serves as a versatile "3-in-1" solution for managing academic processes, offering tailored functionalities for students, trainers, and academy management.

Key Features:
📌 Students can manage their schedules, mark attendance, track activities and health status, and view attendance statistics.

![procrasinator_app_demo](assets/demo/procratinator_demo.gif)

📌 Trainers have tools to manage classes, maintain attendance records, and provide educational materials.

📌 Management has access to features for schedule control, approval of sick notes, and overall academy management.

The application employs a custom DI container, which dynamically generates dependency packages based on the user type. Each user type has unique repositories that restrict functionality on both the frontend and backend sides. The application’s architecture follows CLEAN principles, ensuring scalability, maintainability, and separation of concerns.

Firebase is used for user authentication and as the primary database, including integration with Firestore.

Project Development Plan:

1.  Firestore integration: Connect to Firestore. ✅
2.  Bloc management: Implement blocs. ✅
3.  DI and CLEAN architecture: Optimize application structure. ✅
4.  Architecture. DI. Apps for students, trainers, management
    with they own dependencies scopes. ✅
5.  Write tests.
6.  Add flavors.
7.  Set up CI/CD.
