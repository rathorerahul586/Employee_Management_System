package com.rahul.backend_assignment.models;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class EmployeeResponseDTO {
    private String id;
    private String name;
    private String email;
    private String position;
    private Double salary;
    private String departmentName;
}