package com.rahul.backend_assignment.models.common;

import com.rahul.backend_assignment.utils.AppConstants;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ApiResponse<T> {
    private String status;
    private String message;
    private T data;
    private String errorDetails;
    private LocalDateTime timestamp;

    // Helper method for Success
    public static <T> ApiResponse<T> success(T data, String message) {
        return ApiResponse.<T>builder()
                .status(AppConstants.STATUS_SUCCESS)
                .message(message)
                .data(data)
                .timestamp(LocalDateTime.now())
                .build();
    }

    // Helper method for Error
    public static <T> ApiResponse<T> error(String message, String errorDetails) {
        return ApiResponse.<T>builder()
                .status(AppConstants.STATUS_ERROR)
                .message(message)
                .errorDetails(errorDetails)
                .timestamp(LocalDateTime.now())
                .build();
    }
}