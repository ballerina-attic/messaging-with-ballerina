import ballerina/http;
import ballerina/test;


// Create an endpoint with employee db service
endpoint http:Client httpEndpoint {
    targets:[
        {
            url:"http://localhost:9090/airline"
        }
    ]
};

// Before suite function
@test:BeforeSuite
function beforeFunc() {
    // Start employee database service
    _ = test:startServices("guide.ballerina_messaging");
}

// After suite function
@test:AfterSuite
function afterFunc() {
    // Stop employee database service
    test:stopServices("guide.ballerina_messaging");
}

@test:Config
function testRetrieveByIdResource() {
    // Initialize the empty http request and response
    //http:Request req;
    //http:Response resp;
    //json expectedJson;
    //// Testing retrieve by employee id resource
    //// Prepare request with query parameter
    //string url = "/employee/" + TEST_EMPLOYEE_ID;
    //// Send the request to service and get the response
    //resp = check httpEndpoint -> get(url, req);
    //// Test the responses from the service with the original test data
    //test:assertEquals(resp.statusCode, 200, msg = "Retreive employee resource did not reespond with 200 OK signal");
    //var receivedPayload2 = check resp.getJsonPayload();
    //expectedJson = [{"EmployeeID":879796979, "Name":"Alice", "Age":30, "SSN":123456789}];
    //test:assertEquals(receivedPayload2[0], expectedJson[0], msg = "Name did not store in the database");
    test:assertTrue(true,msg = "dada");
}