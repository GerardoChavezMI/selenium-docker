#!/bin/bash

# Check if Allure is installed
if ! command -v allure &> /dev/null
then
    echo "Allure could not be found. Please install it first."
    exit
fi

# Assert that environment variables exist and are not null or empty
variables=("ENVIRONMENTS" "PLATFORM_GOAL_EXECUTION_TEST")
for var in "${variables[@]}"
do
  if [ -z "${!var}" ]
  then
    echo "Environment variable $var is not set or is empty."
    exit 1
  fi
done


export CLIENT_ID_ENV_SSO
export CAPTCHA_LOCAL_STORAGE_VALUE
export PASSWORD
export PASSWORD_SUPER_ADMIN
export ENVIRONMENTS
export PLATFORM_GOAL_EXECUTION_TEST

mvn test -Dtest=SeleniumTest\#"$TEST_FILTERS"

# Generate Allure report
echo Generating allure report
cd test-output
allure generate . --report-name "Automation e2e tests on $ENVIRONMENTS" --clean -o allure-report/