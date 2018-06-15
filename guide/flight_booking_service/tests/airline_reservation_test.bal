import ballerina/http;
import ballerina/test;
import ballerina/io;

// Create an endpoint with employee db service
endpoint http:Client httpEndpoint {
    url: "http://localhost:9090/airline"
};

// Before suite function
@test:BeforeSuite
function beforeFunc() {
    // Start employee database service
    _ = test:startServices("flight_booking_service");
}

// After suite function
@test:AfterSuite
function afterFunc() {
    // Stop employee database service
    test:stopServices("flight_booking_service");
}

@test:Config
function testReservation() {
    // Initialize the empty http request and response
    http:Request req;
    json sampleRequest = { "Name": "Alice", "ID": 123456789 };
    req.setJsonPayload(sampleRequest);
    string expectedResponse = "Your booking was successful";
    var resp = check httpEndpoint->post("/reservation", req);
    test:assertEquals(resp.getTextPayload(), expectedResponse, msg = "Reservation failed");
}

@test:Config
function testCancellation() {
    // Initialize the empty http request and response
    http:Request req;
    json sampleRequest = { "Name": "Alice", "ID": 123456789 };
    req.setJsonPayload(sampleRequest);
    string expectedResponse = "You have successfully canceled your booking";
    var resp = check httpEndpoint->post("/cancellation", req);
    test:assertEquals(resp.getTextPayload(), expectedResponse, msg = "Cancellation
    failed");
}
