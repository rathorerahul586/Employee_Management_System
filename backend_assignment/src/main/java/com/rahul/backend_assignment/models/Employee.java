package com.rahul.backend_assignment.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    private String name;
    private String email;
    private String position;
    private Double salary;

    // Many Employees belong to One Department
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dept_id") // Foreign Key
    @JsonIgnore // Prevents infinite JSON recursion
    private Department department;

}