@jobs
Feature: Segment IdentifyJob
  As a Resque Worker client
  In order to upsert user records based on segment identify events
  I want to process an api_request with a segment job

  Scenario: Process Segment job with valid arguments
    Given a Api Request with id "999" and paylod:
    """
    {
      "type": "identify",
      "userId": "6361edb5-9388-4413-bb64-18964da05ecb",
      "traits": {
        "email": "jimmy@jimmyjohns.com",
        "geo_city": "IL"
      }
    }
    """
    And I am a Worker processing a Segment identify job with api_request_id "999"
    Then a new user record should be created with uuid "6361edb5-9388-4413-bb64-18964da05ecb" and details:
    """
    {
      "userId": "6361edb5-9388-4413-bb64-18964da05ecb",
      "traits": {
        "email": "jimmy@jimmyjohns.com",
        "geo_city": "IL"
      }
    }
    """
