package com.rahul.backend_assignment.repository;

import com.rahul.backend_assignment.models.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, String> {
    // Spring automatically generates the SQL by the method name
    List<Employee> findByDepartmentId(String deptId);
}