package com.rahul.backend_assignment.models.common;

import lombok.Data;

@Data
public class ApiRequest<T> {
    private String requestId;
    private String source;
    private T payload;
}