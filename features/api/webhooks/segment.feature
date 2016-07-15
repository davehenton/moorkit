@api
Feature: Segment Webhook
  As an API client
  In order to send Segment.com data to you
  I want to submit data to a segment webhook

  Scenario: submit Segment data with invalid bearer_token
    Given I have an INVALID access token
    And I send and accept JSON
    When I send a POST request to "/api/v1/webhooks/segment" with the following:
    """
    {
      "type": "identify",
      "userId": "6f251c7d-49bd-4e0a-a12d-477b8b2f1532",
      "traits": {
        "email": "jimmy@jimmyjohns.com",
        "geo_state": "IL"
      }
    }
    """
    Then the response status should be "401"

  Scenario: submit Segment data with valid bearer_token
    Given I have a VALID access token
    And I send and accept JSON
    When I send a POST request to "/api/v1/webhooks/segment" with the following:
    """
    {
      "type": "identify",
      "userId": "6f251c7d-49bd-4e0a-a12d-477b8b2f1532",
      "traits": {
        "email": "jimmy@jimmyjohns.com",
        "geo_state": "IL"
      }
    }
    """
    Then the response status should be "201"
    And the background job should create a member with uuid "6f251c7d-49bd-4e0a-a12d-477b8b2f1532"
    And the JSON response should have "success"
