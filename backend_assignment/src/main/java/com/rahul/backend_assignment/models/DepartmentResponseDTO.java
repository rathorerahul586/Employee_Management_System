package com.rahul.backend_assignment.models;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class DepartmentResponseDTO {
    private String id;
    private String name;
    private String location;
    private List<Employee> employees;
}