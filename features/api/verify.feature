@api
Feature: Verify Authentication
  As an API client
  In order to verify my authentication
  I want to make a request to the verify endpoint

  Scenario: Verify request with valid bearer token
    Given I have a VALID access token
    And I send and accept JSON
    When I send a GET request to "/api/v1/verify"
    Then the response status should be "200"
    And the JSON response should have "success"

  Scenario: Verify request with invalid bearer token
    Given I have an INVALID access token
    And I send and accept JSON
    When I send a GET request to "/api/v1/verify"
    Then the response status should be "401"
