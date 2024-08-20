# Global E-commerce Finance Tech

## Getting Started

### Clone Repositories
In your main project directory, run the following git commands (note there are **two repositories to check out**):
#### SSH
```sh
git clone git@github.ford.com:global-ecommerce-finance-tech/eu-geft.git
git clone git@github.ford.com:global-ecommerce-finance-tech/eu-geft-config.git
```
  
#### HTTP
```sh
git clone https://github.ford.com/global-ecommerce-finance-tech/eu-geft.git
git clone https://github.ford.com/global-ecommerce-finance-tech/eu-geft-config.git
```

### Install Dependencies

#### Homebrew (Mac)
If you use [Homebrew](https://brew.sh), a Brewfile is checked into the repository which will install most of the dependencies (and some goodies) with one execution of the following command in the project root:

```
brew bundle
```

#### Java 11
This project requires Java 11. If you do not have that version installed on your machine you will need to get it.

To see if you are using Java 11 run ```java --version```. (If you get an error try ```java -version``` instead.)

##### OSX
If you are not using Java 11, check homebrew to see if it's installed. Run ``` brew search jdk``` and look for a green check next to adoptopenjdk11.

If you do not have adoptopenjdk11 run ```brew cask install adoptopenjdk11```

#### Node and NPM
Go to [NodeJs.org](https://nodejs.org/) to download Node with NPM.

### Build, Test, Run
#### Backend
Inside the eu-geft folder, run the following commands:
```sh
./gradlew build
```
```sh
LOCAL_CLOUD_CONFIG_BOOTSTRAP=true LOCAL_CLOUD_CONFIG_DIR='{insert path to config project}' SPRING_PROFILES_ACTIVE=local ./gradlew bootRun
```

_(The config folder is the `eu-geft-config` repository checked out earlier)_

This will start the spring boot application (including the front-end) on port 8080.

Visit [this localhost URL](http://localhost:8080/gb?countryCode=gb&orderId=sit-fake-order) to see the application in action.

**NOTE:** To create credentials for EDU go to [FMA Sandbox](https://fma-sandbox-perf-ford.apps.pd01i.edc1.cf.ford.com/) -> Sign In -> Create Account. Currently, EDU is used for all non-prod environments.

#### Frontend

For frontend related development work please follow these instructions:

Inside the eu-geft folder, run the following commands:
```sh
cd src/main/webapp
npm install
npm run test-ci
npm run start
```

This will build and start serving the front-end application on port 3000. Hot Module Reloading is enabled and any changes you make to the code should be reflected instantly in the browser.

Visit [this localhost URL](http://localhost:3000/gb?countryCode=gb&orderId=sit-fake-order) to see the application in action.

### IntelliJ Setup
#### Proxy Setup with Intellij
You may not need to set up these proxies. If everything works without them, great! If, however, you can't build because URLs are not found, you should try these steps.
1. While using Intellij, go to preferences
2. Navigate to "system settings"->Http proxy
3. Select the "Manual proxy configuration" radio button and then the "HTTP" radio button
4. Under "Host name" type `internet.ford.com` and select port `83`
5. Under the "no proxy for" heading, use `*.ford.com, localhost, 127.0.0.1`
##### Proxy Setup with Intellij Terminal (Mac)
1. Check to see if any proxy settings are already present by clicking on "Terminal" at the bottom
2. Type `env | grep -i proxy` to see if environment variables are set
3. You will want to add the proxy config by typing the following commands:

   a. `export http_proxy=http://internet.ford.com:83`

   b. `export https_proxy=http://internet.ford.com:83`

   c. `export no_proxy="ford.com,localhost,127.0.0.1"`

   d. `export HTTP_PROXY=http://internet.ford.com:83`

   e. `export HTTPS_PROXY=http://internet.ford.com:83`

   f. `export NO_PROXY="ford.com,localhost,127.0.0.1"`

##### Proxy Setup with Intellij Terminal (Windows)
1. Check to see if any proxy settings are already present by clicking on "Terminal" at the bottom
2. Type `SET | findstr proxy` to see if any proxy environment variables are set
3. You will want to add the proxy config by typing the following commands:

   a. `set http_proxy=http://internet.ford.com:83`

   b. `set https_proxy=http://internet.ford.com:83`

   c. `set no_proxy="ford.com,localhost,127.0.0.1"`

   d. `set HTTP_PROXY=http://internet.ford.com:83`

   e. `set HTTPS_PROXY=http://internet.ford.com:83`

   f. `set NO_PROXY="*.ford.com,localhost,127.0.0.1"`

####  IntelliJ Spring Boot Configurations
There are some things you need to have in your spring boot run configuration to successfully build and start the application locally.

- Set your JRE path to the location of your Java 11 install (eg. ```/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home```)
- Set your active profile to local
- Set environment variable. You need LOCAL_CLOUD_CONFIG_BOOTSTRAP and LOCAL_CLOUD_CONFIG_DIR
    - LOCAL_CLOUD_CONFIG_BOOTSTRAP should be set to true
    - LOCAL_CLOUD_CONFIG_DIR should be the full path to your local repo for the config project
    
#### Useful IntelliJ Plugins
You will need to be off the VPN to install plugins.
* Kotlin
* PlantUML Integration - to view puml files in the [docs](./docs) folder.

For additional information please check the [wiki](https://github.ford.com/global-ecommerce-finance-tech/eu-geft/wiki)