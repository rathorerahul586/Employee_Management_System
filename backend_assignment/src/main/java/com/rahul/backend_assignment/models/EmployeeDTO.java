package com.rahul.backend_assignment.models;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeDTO {
    private String id;
    private String name;
    private String email;
    private String position;
    private Double salary;
    private String departmentId;
    private String departmentName;
}