import ballerina/mb;
import ballerina/log;

@Description{value:"Queue receiver endpoint for new flight bookings"}
endpoint mb:SimpleQueueReceiver queueReceiverBooking {
    host:"localhost",
    port:5672,
    queueName:"NewBookingsQueue"
};

@Description{value:"Queue receiver endpoint for cancellation of flight bookings"}
endpoint mb:SimpleQueueReceiver queueReceiverCancelling {
    host:"localhost",
    port:5672,
    queueName:"BookingCancellationQueue"
};

@Description{value:"Service to receive messages for new booking message queue"}
service<mb:Consumer> FlightBooking bind queueReceiverBooking {
    @Description{value:"Resource handler for new messages from queue"}
    onMessage(endpoint consumer, mb:Message message) {
        // Get the new message as the string
        string messageText = check message.getTextMessageContent();
        // Mock the processing of the message for new booking
        log:printInfo("[NEW BOOKING] Details : " + messageText);
    }
}

@Description{value:"Service to receive messages for booking cancellation message queue"}
service<mb:Consumer> FlightCancellation bind queueReceiverCancelling {
    @Description{value:"Resource handler for new messages from queue"}
    onMessage(endpoint consumer, mb:Message message) {
        // Get the new message as the string
        string messageText = check message.getTextMessageContent();
        // Mock the processing of the message for cancellation of bookings
        log:printInfo("[CANCEL BOOKING] : " + messageText);
    }
}
