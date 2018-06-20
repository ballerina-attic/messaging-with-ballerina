import ballerina/mb;
import ballerina/log;

documentation { Queue receiver endpoint for new flight reservations. }
endpoint mb:SimpleQueueReceiver queueReceiverBooking {
    host: "localhost",
    port: 5672,
    queueName: "NewBookingsQueue"
};

documentation { Queue receiver endpoint for cancelation of flight reservations. }
endpoint mb:SimpleQueueReceiver queueReceiverCancelling {
    host: "localhost",
    port: 5672,
    queueName: "BookingCancellationQueue"
};

documentation { Service to receive messages to the new reservation message queue. }
service<mb:Consumer> bookingListener bind queueReceiverBooking {

    documentation { Resource handler for new messages from queue. }
    onMessage(endpoint consumer, mb:Message message) {
        // Get the new message as the string
        string messageText = check message.getTextMessageContent();
        // Mock the processing of the message for a new reservation.
        log:printInfo("[NEW BOOKING] Details : " + messageText);
    }
}

documentation { Service to receive messages to the cancelation message queue. }
service<mb:Consumer> cancellingListener bind queueReceiverCancelling {

    documentation { Resource handler for new messages from queue. }
    onMessage(endpoint consumer, mb:Message message) {
        // Get the new message as the string
        string messageText = check message.getTextMessageContent();
        // Mock the processing of the message to cancel a reservation
        log:printInfo("[CANCEL BOOKING] : " + messageText);
    }
}
