package com.rahul.backend_assignment.repository;

import com.rahul.backend_assignment.models.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, String> {
    // No extra methods needed, basic CRUD is built-in
}