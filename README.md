# HealthMon Android Application

## CMSC 23 B7L Group 2 Members
- Araez, Danielle Lei R.  
- Concepcion, Sean Kierby I.  
- Dela Cruz, Laydon Albert L.  
- Luñeza, Marcel Luiz G.  


## Program Description
#### App Name
HealthMon

#### App Theme
<img src="https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/8ef99047-6276-432e-8124-54173b590cb4" data-canonical-src="https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/8ef99047-6276-432e-8124-54173b590cb4" width="250" height="300" />


#### App Icon
<img src="https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/e2693622-7ec2-4526-83f7-fa92ed51bde4" data-canonical-src="https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/e2693622-7ec2-4526-83f7-fa92ed51bde4" width="250" height="250" />

HealthMon is a health monitoring system application created using the Flutter framework which is connected to a Firebase Cloud Firestore for database and Firebase Authentication for the login and signup features.

The application hosts three types of accounts which are the user, entrance monitor, and admin. All of the accounts have the base features such as creating a health entry and generating a building pass. On the other hand, certain features are only available to a particular account type: entrance monitor accounts are able to view logs, search student logs, update logs, and read generated QR. Meanwhile, admin accounts are granted the abilities for the following: viewing student accounts, viewing quarantined students, viewing students that are under monitoring, managing (approving or rejecting) students' requests, and elevating user accounts to admin or entrance monitor.


## Installation Guide
### Using Chrome or Edge (not recommended) 
1. Access the GitHub Link (https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza)
2. Clone the main repository
3. In the terminal, go to the app's path
4. Execute flutter run
5. Select Chrome or Edge as the simulator for the app

### Using Phone (recommended)
#### Through GitHub Link
1. Access the Github Link (https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza)
2. Clone the main repository
3. In the terminal, go to the app's path
4. On your phone, enable the developer option and USB debugging from the settings
5. Execute flutter devices
6. Execute flutter run
7. Make sure to accept the app's permission to camera for qr scanning

#### Through APK
1. Alternatively, you can install the app through an APK provided by the developers
2. Just also make sure to accept the app's permission to camera for qr scanning

## How To Use the Health Monitor App
HealthMon showcases wide variety of features centered around monitoring the health of all users registered on this app.

### User View
1. To access the services and features offered by HealthMon, a user must first sign up (as User) to create his/her account.

![HM signup](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/14352dd1-5260-4e49-a68b-901765904171)


2. After a successful sign up, the user will then be redirected to the home page of the app.

![HM home](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/387afd21-c0db-4053-8428-9681ea6be1ef)


3. The user can then add an entry for the day wherein he or she must fill up a form to determine whether he or she should be cleared, quarantined, or under monitoring (it should be noted that the user can only create an entry once per day, however the user can still edit or delete his/her entry where such request is to be approved by the admin).

![HM entry](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/5a723f2f-c4a9-4f3e-98d9-bc9662f46fe8)


4. If the user experienced no symptoms and had no contacts with someone that is positive, then his/her status would be labeled as "Cleared" and can then generate a qr code to be presented to the entrance monitor. Otherwise, he or she would have a status of "Quarantined" or "Under Monitoring."

![HM qr page](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/3f5ecab5-18cb-411a-bdec-b581ab5f5a1d)


### Entrance Monitor View
1. To access the services and features offered by HealthMon, a user must first sign up (as Entrance Monitor) to create his/her account.

![HM signup em](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/926fedae-9bf8-4bae-b389-229129b59fb1)


2. After a successful sign up, the user will then be redirected to the home page of the app whererin he or she is granted access to the actions that are also available to user, but with added features such as viewing logs, searching student logs, updating logs, and reading generated QR.

![HM home em](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/d05180ee-ed8f-4dbd-bd6c-18066954fea6)


3. Accounts identified as entrance monitor are able to view created logs together with the students' name, location, student number, date of log creation, and current status.

![HM view logs](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/083a4184-3e8b-41ed-9fee-cd296099cbb8)


4. Entrance monitor can also search for a particular logs registered in the database.

![HM search logs](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/1850cefd-462c-46b5-9cd9-cd8aa4d8b093)


5. The ability to read generated qr codes is also granted for the entrance monitor.

![HM qr page](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/fdd41f2c-20c9-4629-b4af-ab00f41b171e)


6. Another feature that is available to entrance monitor is setting a location.

![HM location](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/1fa5e42f-638e-4b2f-8ede-a5acebbf9bbf)


### Admin View
1. To access the services and features offered by HealthMon, a user must first sign up (as Admin) to create his/her account.

![HM signup em](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/926fedae-9bf8-4bae-b389-229129b59fb1)


2. After a successful sign up, the user will then be redirected to the home page of the app whererin he or she is granted access to the actions that are also available to user, but with added features such as viewing all students, viewing quarantined students, viewing under monitoring students, and managing (approve or reject) students requests.

![HM home admin](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/0253627d-8df6-442e-8785-a24bc023e0cf)


3. Accounts identified as admin are able to view all students wherein he or she has the capability to elevate the that certain student account to become admin or entrance monitor. Moreover, admins can also add certain students to quarantine. Filtering of the list according to student number, date, college, or course is also able to be performed in this page.

![HM view students](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/78d99df8-0723-4f71-ae53-73ddf551ab59)


4. Admin can also view and clear quarantined students. 

![HM quarantined](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/38114ff8-8654-43b5-82d1-8de2033cf1c4)


5. The ability to view under monitring students and manage their status (i.e. add to quarantine or mark as clear) is also granted for the admin. 

![HM under monitoring](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/ca915a42-6825-481c-be22-9e265c502223)


6. Another feature that is available to admin is viewing and managing (approve or rejecting) students requests.

![HM requests](https://github.com/CMSC-23-2nd-Sem-2022-2023/project-araez_concepcion_delacruz_luneza/assets/125255946/e25850b7-4379-4c5e-b945-7171903bcf79)



