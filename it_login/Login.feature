Feature: Enter user
  In order to use website tools user should be authenticated as a consultant
  User try login with incorrect user name
  User try login with incorrect password
  User try login with empty user name
  User try login with empty password
  User try login after closing active session

  Scenario: Successful login
    Given  User on login page
    When User fill login form:
      | field    | value     |
      | login    | tuser     |
      | password | Qwerty123 |
    And User press signIn button
    Then User should see "Job Search" form title
    Then User should see "Logout" button

  Scenario: Unsuccessful credentials with empty values
    Given  User on login page
    When User fill login form:
      | field    | value |
      | login    |       |
      | password |       |
    And User press signIn button
    Then User should see message "Login is null"

  Scenario: Successful Re-login after clear session
    When User fill login form:
      | field    | value     |
      | login    | tuser     |
      | password | Qwerty123 |
    And User press signIn button
    And All cookies was clear
    When User try to logout
    Then User should see message "Session ExpiredTake note of any unsaved data, and click here or press ESC key to continue." about stop cookies
    And User should see dialog login page with "Please, login" title
    When User fill login form again:
      | field    | value     |
      | login    | tuser     |
      | password | Qwerty123 |
    And User press submit signIn button
    Then User should see "Logout" button
#
  Scenario: Incorrect user name
    When User fill login form:
      | field    | value     |
      | login    | user      |
      | password | Qwerty123 |
    And User press signIn button
    Then User should see message "Login error. Please try again"

  Scenario: Incorrect password
    When User fill login form:
      | field    | value     |
      | login    | tuser     |
      | password | Qwerty321 |
    And User press signIn button
    Then User should see message "Login error. Please try again"

  Scenario: Sign in with only login
    When User fill login form:
      | field | value |
      | login | tuser |
    And User press signIn button
    Then User should see message "Password is null"

  Scenario: Sign in with only password
    Given  User on login page
    When User fill login form:
      | field    | value     |
      | password | Qwerty123 |
    And User press signIn button
    Then User should see message "Login is null"

  Scenario: Successful login with username: test
    Given  User on login page
    When User fill login form:
      | field    | value          |
      | login    | test@gmail.com |
      | password | 48Q0uG00       |
    And User press signIn button
    Then User should see "Job Search" form title
    Then User should see "Logout" button

  Scenario: Unsuccessful login with username: test
    When User fill login form:
      | field    | value          |
      | login    | test@gmail.com |
      | password | Qwerty123      |
    And User press signIn button
    Then User should see message "Login error. Please try again"

  Scenario: Successful login with username: testuser
    Given  User on login page
    When User fill login form:
      | field    | value              |
      | login    | testuser@gmain.com |
      | password | d3LasqUh           |
    And User press signIn button
    Then User should see "Job Search" form title
    Then User should see "Logout" button

  Scenario: Unsuccessful login with username: testuser
    When User fill login form:
      | field    | value              |
      | login    | testuser@gmain.com |
      | password | Qwerty123          |
    And User press signIn button
    Then User should see message "Login error. Please try again"

  Scenario: Successful login with username: test_it
    Given  User on login page
    When User fill login form:
      | field    | value             |
      | login    | test_it@gmail.com |
      | password | BNMWLZ2M          |
    And User press signIn button
    Then User should see "Job Search" form title
    Then User should see "Salir" button

  Scenario: Unsuccessful login with username: test_it
    When User fill login form:
      | field    | value             |
      | login    | test_it@gmail.com |
      | password | 123               |
    And User press signIn button
    Then User should see message "Login error. Please try again"