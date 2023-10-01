# Ayur

## Get Started

Getting started with Ayur is quick and easy! Follow these steps to contribute and make a difference:

### 1. Fork the Repository

Start by forking the Ayur repository to your GitHub account. Click the "Fork" button at the top right corner of the repository page. This creates a copy of the repository in your account.

### 2. Clone the Repository

Clone the forked repository to your local machine using Git. Open your terminal and run the following command:

```bash
git clone https://github.com/your-username/ayur.git
```

### 3. Run Locally

To run Ayur locally, follow these steps for both the Flutter app and the Python backend:

#### 3.1. Flutter App

##### a. Install Dependencies

First, make sure you have Flutter installed. If not, you can download it from [Flutter official website](https://flutter.dev/docs/get-started/install).
Navigate to the Flutter project directory and get the required packages using the following command:

```bash
flutter pub get
```

##### b. Run flutter application

```bash
flutter run -d <device_id>
```

#### 3.2 Flask Backend

##### a. Build Docker Container

Build the Docker container for the Flask backend API. Run this command inside the project directory:

```bash
docker build -t flask-smorest-api .
```

##### b. Run Docker Image

Run the Docker image as a detached process, mapping port 5000 from the container to your host machine.

```bash
docker run -dp 5000:5000 flask-smorest-api
```

Now, Ayur's Flutter app and Python backend are running locally, allowing you to explore the application and its features.

Happy coding! 🚀

## Inspiration 💡

Taking medicine on time is a must, but sometimes we forget due to our busy schedules. That's why we created Ayur, a personal medicine scheduler that ensures you never miss a dose. Its standout feature is reminding not only you but also alerting designated contacts by making a call if you haven't taken your medicine.

## What it does ❓

-   Schedules medicine for you.
-   Sends reminders to your phone.
-   If reminders are ignored, it makes a call (making sure you don't skip your medicine).
-   Analyzes symptoms and provides possible causes and precautions using PaLM 2.

## How we built it 🤔

technology used:
We utilized the following technologies:

-   Flask: for building the API.
-   PostgreSQL: for data storage.
-   Gunicorn: for hosting the API.
-   PaLM 2: to suggest possible causes and precautions.
-   Flutter: to design the user interface.
-   Twilio: for user authentication and phone call reminders.

## Challenges we ran into 🧠

-   Running a process in the background and triggering a function at a scheduled time on Android.
-   Implementing phone call functionality if the user didn't respond to the medicine notification. We achieved this by using time-triggered Azure functions and periodic checks.

## Accomplishments that we're proud of 😎

We take pride in the following achievements:

-   Completing the project within the specified time limit.
-   Utilizing Marshmallow and flask-smorest to create a structured API, even though it required some extra time.
-   Leveraging the PaLM 2 model to suggest causes and precautions.

## What we learned 📝

Throughout this project, we gained valuable insights and learned to use various technologies, including:

-   Flask-smorest, Flask-JWT, Marshmallow, Azure functions, and Cron Job for backend development.
-   Method channels and function scheduling for the Android side.
-   Utilizing PaLM 2 by Google to analyze symptoms.

## What's next for Ayur 🤖

-   Enhanced User Experience: We're committed to refining the app's interface and usability based on user feedback. Seamlessly navigating through the app and managing health will become even more intuitive.
-   AI Advancements: Ayur will continually evolve its AI capabilities, ensuring more accurate symptom analysis and providing even better recommendations for causes and precautions.
-   Customized Health Insights: We aim to offer personalized health insights based on an individual's medical history, preferences, and lifestyle. Tailoring suggestions will make Ayur an indispensable health companion.
