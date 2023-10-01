# Contributing Guidelines

Thank you for considering contributing to Ayur! We welcome your suggestions, bug reports, feature requests, or any other contributions that can enhance our project. To ensure a smooth collaboration, please follow these guidelines when contributing to our GitHub project:

### Getting Started

**1. Fork the Repository:** Start by forking the Ayur repository to your own GitHub account.

**2. Clone the Repository:** Clone the forked repository to your local machine using the following command:

    git clone https://github.com/abhigoyani/ayur.git

**3. Switch to the Project Directory:** Navigate to the project directory:

    cd ayur

**4. Set Up Development Environment:** Make sure you have Python and Flutter installed. Refer to the project documentation for detailed setup instructions.

### Building and Running the Project

**1. Build Docker Container:** Build the Docker container for the Flask backend API. Use the following command:

    docker build -t flask-smorest-api .

**2. Run Docker Image:** Run the Docker image as a detached process, mapping port 5000 from the container to your host machine:

    docker run -dp 5000:5000 flask-smorest-api

**3. Run Flutter Application:**

```
    flutter pub get
    flutter run -d <device_id>
```

### Making Changes

**1. Branching:** Create a new branch for your feature, bugfix, or improvement. Use a descriptive branch name related to the changes you are making.

    git checkout -b feature-name

**2. Code Changes:** Make your code changes, following the project's coding style and guidelines.

**3. Testing:** Test your changes thoroughly to ensure they do not introduce new issues.

### Committing Changes

**1. Commit Messages:** Write clear and concise commit messages explaining the purpose of the changes.

**2. Pull Latest Changes:** Before pushing changes, pull the latest changes from the main repository to avoid conflicts.

    git pull origin main

**3. Push Changes:** Push your changes to your forked repository.

    git push origin feature-name

### Submitting a Pull Request

**1. Create a Pull Request:** Go to your forked repository on GitHub and click on "New Pull Request." Provide a descriptive title and summary of your changes.

**2. Review:** Your pull request will be reviewed by the maintainers. Be prepared to address any feedback or make necessary changes.
