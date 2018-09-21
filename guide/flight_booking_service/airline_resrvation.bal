import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mb;

# Define the message queue endpoint for new reservations.
endpoint mb:SimpleQueueSender queueSenderBooking {
    host: "localhost",
    port: 5672,
    queueName: "NewBookingsQueue"
};

# Define the message queue endpoint to cancel reservations.
endpoint mb:SimpleQueueSender queueSenderCancelling {
    host: "localhost",
    port: 5672,
    queueName: "BookingCancellationQueue"
};

# Attributes associated with the service endpoint.
endpoint http:Listener airlineReservationEP {
    port: 9090
};

# Airline reservation service exposed via HTTP/1.1.
@http:ServiceConfig {
    basePath: "/airline"
}
service<http:Service> airlineReservationService bind airlineReservationEP {

    # Resource for reserving seats on a flight
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/reservation"
    }
    bookFlight(endpoint conn, http:Request req) {
        http:Response res = new;
        // Get the reservation details from the request
        json requestMessage = check req.getJsonPayload();
        string booking = requestMessage.toString();

        // Create a message to send to the flight reservation system
        mb:Message message = check queueSenderBooking.createTextMessage(booking);
        // Send the message to the message queue
        _ = queueSenderBooking->send(message);

        // Set the string payload when reservation is successful.
        res.setPayload("Your booking was successful");

        // Send the response back to the client.
        _ = conn->respond(res);
    }

    # Resource for canceling already reserved seats on a flight
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/cancellation"
    }
    cancelBooking(endpoint conn, http:Request req) {
        http:Response res = new;
        // Get the reservation details from the request
        json requestMessage = check req.getJsonPayload();
        string cancelBooking = requestMessage.toString();

        // Create a message to send to the flight reservation system
        mb:Message message = check queueSenderCancelling.createTextMessage(cancelBooking);
        // Send the message to the message queue
        _ = queueSenderCancelling->send(message);

        // Set the string payload when the reservation is successful.
        res.setPayload("You have successfully canceled your booking");

        // Send the response back to the client.
        _ = conn->respond(res);
    }
}
