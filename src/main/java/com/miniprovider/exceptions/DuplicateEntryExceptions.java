package com.miniprovider.exceptions;

public class DuplicateEntryExceptions extends RuntimeException {
    public DuplicateEntryExceptions(String message, Throwable cause) {
        super(message, cause);
    }
    public DuplicateEntryExceptions(String message) {
        super(message);
    }
    public DuplicateEntryExceptions(Throwable cause) {
        super(cause);
    }


}
