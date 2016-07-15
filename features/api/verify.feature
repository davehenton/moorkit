@api
Feature: Verify Authentication
  As an API client
  In order to verify my authentication
  I want to make a request to the verify endpoint

  Scenario: Verify request with valid bearer token
    Given I am a valid API user with Bearer token "b1c2bc9c-a590-4734-97c7-6d9405500307:secret"
    And I send and accept JSON
    When I send a GET request to "/api/v1/verify"
    Then the response status should be "200"
    And the JSON response should have "success"

  Scenario: Verify request with invalid bearer token
    Given I am a invalid API user with Bearer token "b1c2bc9c-a590-4734-97c7-6d9405500307:bad_secret"
    And I send and accept JSON
    When I send a GET request to "/api/v1/verify"
    Then the response status should be "401"
