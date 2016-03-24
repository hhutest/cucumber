Feature: Searching in jobFile
  In order to use Search tools user should be authenticated as a consultant
  Consultant should be able to see all vacancy after empty search request
  Consultant should be able to create small search request
  Consultant should be able to use wildcards in the all fields of search request
  Consultant should be able to use all fields for search request:  title, industry, employer, workload, industry, region,
  location, agency, and type(only temporary)
  Consultant shouldn't use industry input  field in italian locale
  Consultant should see info message if search request is wrong
  Consultant should see info message if there are no vacancy for the provided search request

  Background:
    Given User on search page

  @userAuthenticatedAs_tuser
  Scenario: Searching job with help window - Default search
    When User open help window
    And User select search syntax - "business consultant"
    Then User should see result table with message with total is "1 - 20 from 130"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with help window - Search for an exact word or phrase
    When User open help window
    And User select search syntax - ""business consultant""
    Then User should see result table with message with total is "13"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with help window - Exclude a word or phrase
    When User open help window
    And User select search syntax - "consultant -analyst"
    Then User should see result table with message with total is "1 - 20 from 322"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with help window - Search for either word
    When User open help window
    And User select search syntax - "consultant ;analyst"
    Then User should see result table with message with total is "1 - 20 from 502"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with help window - Fill in the blank
    When User open help window
    And User select search syntax - "Manage*"
    Then User should see result table with message with total is "1 - 20 from 3631"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with help window - Fill in the blank single letter
    When User open help window
    And User select the blank
    Then User should see result table with message with total is "1 - 20 from 415"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with help window - Junior "business consultant" -Financ* ;Business Analyst
    When User open help window
    And User select search syntax - "Junior "business consultant" -Financ* ;Business Analyst"
    Then User should see result table with message with total is "1 - 20 from 157"

  @userAuthenticatedAs_test_DE
  Scenario: Searching job with help window - "Und" Suche
    When User open help window
    And User select german search syntax - "Java Entwickler"
    Then User should see result table with message with total is "18"

  @userAuthenticatedAs_test_DE
  Scenario: Searching job with help window - "Oder" Suche
    When User open help window
    And User select german search syntax - "java ;Entwickler"
    Then User should see result table with message with total is "1 - 20 from 255"

  @userAuthenticatedAs_test_DE
  Scenario: Searching job with help window - "Excluding" Suche
    When User open help window
    And User select german search syntax - "java -Entwickler"
    Then User should see result table with message with total is "1 - 20 from 159"

  @userAuthenticatedAs_test_DE
  Scenario: Searching job with help window - Genaue Reihenfolge
    When User open help window
    And User select german search syntax - ""IT Supporter""
    Then User should see result table with message with total is "20"

  @userAuthenticatedAs_test_DE
  Scenario: Searching job with help window - Wildcard search
    When User open help window
    And User select german search syntax - "kaufm*"
    Then User should see result table with message with total is "1 - 20 from 1120"

  @userAuthenticatedAs_test_DE
  Scenario: Searching job with help window - Wildcard/"Und" Suche
    When User open help window
    And User select german search syntax - "jav* App*"
    Then User should see result table with message with total is "1 - 20 from 164"

  @userAuthenticatedAs_test_DE
  Scenario: Searching job with help window - Wildcard/"Oder" Suche
    When User open help window
    And User select german search syntax - "jav* ;App*"
    Then User should see result table with message with total is "1 - 20 from 3832"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with negative radius criteria
    When User enters the search data:
      | field    | value |
      | location | true  |
      | zipList  | 1000  |
      | radius   | -10   |
    And User press "Search" button
    Then User should see message "Search criterias are not valid. Please, check and try again." after action

  @userAuthenticatedAs_tuser
  Scenario: Searching job with use ZIP-code
    When User enters the search data:
      | field              | value |
      | keyword            | java  |
      | recruitingAgencies | true  |
      | temporary          | true  |
      | employer           | Epam  |
      | industry           | IT    |
      | minWorkload        | 90%   |
      | maxWorkload        | 90%   |
      | location           | true  |
      | zipList            | 8002  |
      | radius             | 100   |
    And User press "Search" button
    Then User should see result message "No items to show"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with title
    And Change text search to Advanced
    When User enters the search data:
      | field | value |
      | title | java  |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 48"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with description
    And Change text search to Advanced
    When User enters the search data:
      | field       | value |
      | description | java  |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 175"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with title and description
    And Change text search to Advanced
    When User enters the search data:
      | field       | value |
      | title       | java  |
      | description | java  |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 48"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with title and description and employer
    And Change text search to Advanced
    When User enters the search data:
      | field       | value |
      | title       | java  |
      | description | java  |
      | employer    | Epam  |
      | industry    | IT    |
      | maxWorkload | 100%  |
    And User press "Search" button
    Then User should see result table with message with total is "4"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with title and description with *
    And Change text search to Advanced
    When User enters the search data:
      | field              | value |
      | title              | *     |
      | description        | *     |
      | recruitingAgencies | true  |
      | temporary          | true  |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 1977"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with title and description with number
    And Change text search to Advanced
    When User enters the search data:
      | field       | value |
      | title       | 123   |
      | description | 123   |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 12380"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with keyword with number
    When User enters the search data:
      | field   | value |
      | keyword | 123   |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 12380"

  @userAuthenticatedAs_tuser
  Scenario: Searching by job type
    When User enters the search data:
      | field              | value |
      | recruitingAgencies | true  |
      | temporary          | true  |
      | includeInternships | true  |
      | onlyLeading        | true  |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 166"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with use region
    When User enters the search data:
      | field              | value                    |
      | keyword            | C#                       |
      | recruitingAgencies | true                     |
      | temporary          | true                     |
      | employer           | Stamford Consultants     |
      | industry           | IT                       |
      | region             | Northwestern Switzerland |
    And User press "Search" button
    Then User should see result table with message with total is "1"

  @userAuthenticatedAs_tuser
  Scenario: Simple search without keyword
    When User enters the search data:
      | field       | value                  |
      | keyword     |                        |
      | employer    | CSS Versicherung; Epam |
      | region      | Central Switzerland    |
      | maxWorkload | 100%                   |
    And User press "Search" button
    Then User should see result table with message with total is "15"

  @userAuthenticatedAs_tuser
  Scenario: Simple search with same min and max workload
    When User enters the search data:
      | field       | value |
      | minWorkload | 90%   |
      | maxWorkload | 90%   |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 25"

  @userAuthenticatedAs_tuser
  Scenario: Simple search with incorrect workload
    When User enters the search data:
      | field              | value                |
      | keyword            | C#                   |
      | recruitingAgencies | true                 |
      | temporary          | true                 |
      | employer           | Stamford Consultants |
      | industry           | IT                   |
      | minWorkload        | 90%                  |
      | maxWorkload        | 10%                  |
    And User press "Search" button
    Then User should see message "Search criterias are not valid. Please, check and try again." after action

  @userAuthenticatedAs_tuser
  Scenario: Searching job with only min workload
    When User enters the search data:
      | field       | value |
      | minWorkload | 90%   |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 2177"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with only max workload
    When User enters the search data:
      | field       | value |
      | maxWorkload | 50%   |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 839"

  @userAuthenticatedAs_tuser
  Scenario: Searching jobs with all region
    When User enters the search data:
      | field   | value                                                                                                   |
      | keyword | Freileitungsmonteur (M/W)                                                                               |
      | region  | Eastern Switzerland; Northwestern Switzerland; Western Switzerland; Ticino; Zurich; Central Switzerland |
    And User press "Search" button
    Then User should see result table with message with total is "2"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with all industry
    When User enters the search data:
      | field    | value                                                                               |
      | keyword  | Produkt Manager                                                                     |
      | industry | Food; Health; Technology; Logistics; Bank; Construction; IT; Industry; Kaufmännisch |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 30"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with defunct companies
    When User enters the search data:
      | field    | value           |
      | employer | Defunct company |
    And User press "Search" button
    Then User should see result message "No items to show"

  @userAuthenticatedAs_tuser
  Scenario: Searching job with literal radius criteria
    When User enters the search data:
      | field    | value |
      | location | true  |
      | zipList  | 1000  |
      | radius   | abc   |
    And User press "Search" button
    Then User should see message "Search criterias are not valid. Please, check and try again." after action

  @userAuthenticatedAs_tuser
  Scenario: Searching job with maximum permissible value in radius field
    When User enters the search data:
      | field    | value           |
      | keyword  | Produkt Manager |
      | location | true            |
      | zipList  | 1000            |
      | radius   | 9999999999999   |
    And User press "Search" button
    Then User should see message "Search criterias are not valid. Please, check and try again." after action

  @userAuthenticatedAs_tuser
  Scenario: Searching jobs with several employer
    When User enters the search data:
      | field    | value                                                                                             |
      | employer | Stamford Consultants; ABB; Helvetia; Dorigo; Esprit; IKEA; HEKS; ETA SA; SIG; BACKbAR; ADVANIS AG |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 197"

  @userAuthenticatedAs_tuser
  Scenario: Searching jobs with "*"
    When User enters the search data:
      | field   | value |
      | keyword | *     |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 12380"

  @userAuthenticatedAs_tuser
  Scenario: Searching jobs with "?"
    When User enters the search data:
      | field   | value |
      | keyword | ?     |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 12380"

  @userAuthenticatedAs_tuser
  Scenario: Search job for "*java"
    When User enters the search data:
      | field   | value |
      | keyword | *java |
    And User press "Search" button
    Then User should see result table with message with total is "1 - 20 from 175"
