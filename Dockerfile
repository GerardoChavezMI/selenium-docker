# Use the ChromeDriver image
FROM selenium/standalone-chrome:125.0-chromedriver-125.0

USER root

# Install Maven and OpenJDK 11
RUN apt-get update && apt-get install -y maven openjdk-11-jdk python3-pip

# Use root user for installation

# Add Google Chrome repository
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list

# Install Google Chrome
RUN apt-get update && apt-get install -y google-chrome-stable

# download and install allure and python pip
RUN apt-get update && apt-get install -y default-jre-headless python3-pip
RUN wget https://github.com/allure-framework/allure2/releases/download/2.29.0/allure_2.29.0-1_all.deb
RUN dpkg -i allure_2.29.0-1_all.deb

# Set the working directory in the container
WORKDIR /app

# Copy the local source code to the Docker container
COPY . .

RUN ["mkdir", "/app/test-output"]

# Run the specific test
RUN mvn test -Dtest=SeleniumTest#testGoogleSearchTest

RUN ["rm", "-rf", "/app/test-output"]

RUN ["mkdir", "/app/test-output"]

RUN ["chmod", "+x", "runTests.sh"]