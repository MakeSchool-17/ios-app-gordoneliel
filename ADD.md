#App Design Document


##Objective
Office Hours is an app that enables people to connect with mentors.

##Audience
A lot of high school and college students don't have the opportunity to connect with mentors. My app helps people looking for guidance on a career, or general advice connect with people who do, mentors. On the other hand, those in the industry looking to mentor now have a medium to communicate and give back to the community. This as a platform where both mentors and mentees connect, have fun, and learn from each other.

##Experience


##Technical
- Messaging / Voip

####External Services
- Parse for backend
- Sinch / Layer for messaging?

####Screens
The first screen a user will see is a login screen, a profile is needed in order to filter out spam; the mentors need to sign up as well, so the first login/signup screen is essential for onboarding users.
When logged in as a mentee, the first screen is the home screen which has a list of mentors near the user. From this screen, a user can tap on a mentor profile to view more information; they can connect if they haven't yet, or contact them if they already have. 


####Views / View Controllers/ Classes
###### Views
- Login / Signup Screen 
- Home / Find Screen
- Messages Screen
- Settings Screen
- Mentor Detail View (Connected / Not Connected)

###### ViewControllers
- Login / Signup
- Home / Find 
- Messages
- Settings

###### Classes
 - Mentor
 - Mentee

####Data Models

##MVP Milestones
###### Week 1
- Login / Signup
- LinkedIn API integration

###### Week 2
- Mentor finder/ Home View
- Mentor - Mentee relationship / Properties

###### Week 3
- Messaging / Voice Calling
