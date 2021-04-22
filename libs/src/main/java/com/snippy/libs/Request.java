package com.snippy.libs;


public class Request {
 
    private long incoming_timestamp;
    private long outgoing_timestamp;

    public Request(long incoming_timestamp, long outgoing_timestamp) {
        this.incoming_timestamp = incoming_timestamp;
        this.outgoing_timestamp = outgoing_timestamp;
    }

    public long getIncomingTime() {
        return this.incoming_timestamp;
    }

    public long getOutgoingTime() {
        return this.outgoing_timestamp;
    }
}