package com.rahul.backend_assignment.models;
import lombok.Data;

@Data
public class EmployeeRequestDTO {
    private String name;
    private String email;
    private String position;
    private Double salary;
    private String departmentId;
}