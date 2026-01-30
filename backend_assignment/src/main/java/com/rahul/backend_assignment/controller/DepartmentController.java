package com.rahul.backend_assignment.controller;

import com.rahul.backend_assignment.models.Employee;
import com.rahul.backend_assignment.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;


@RestController // Tells Spring this class handles REST API requests
@RequestMapping("/api") // Base URL for all endpoints
public class DepartmentController {

    @Autowired
    private CompanyService service;

    // GET /departments
    @GetMapping("/departments")
    public Map<String, Object> getDepartments() {
        // Wraps the list inside a key named "departments"
        return Collections.singletonMap("departments", service.getAllDepartments());
    }

    // GET /employees
    @GetMapping("/employees")
    public List<Employee> getEmployees() {
        return service.getAllEmployees();
    }

    // GET /departments/{deptId}/employees
    @GetMapping("/departments/{deptId}/employees")
    public List<Employee> getEmployeesByDept(@PathVariable String deptId) {
        return service.getEmployeesByDept(deptId);
    }

    // POST /departments/{deptId}/employees (Add new)
    @PostMapping("/departments/{deptId}/employees")
    public Employee addEmployee(@PathVariable String deptId, @RequestBody Employee employee) {
        return service.addEmployeeToDept(deptId, employee);
    }

    // PUT /departments/{deptId}/employees/{empId} (Update)
    @PutMapping("/departments/{deptId}/employees/{empId}")
    public Employee updateEmployee(@PathVariable String empId, @RequestBody Employee employee) {
        return service.updateEmployee(empId, employee);
    }

    // 6. DELETE /departments/{deptId}/employees/{empId} (Delete)
    @DeleteMapping("/departments/{deptId}/employees/{empId}")
    public String deleteEmployee(@PathVariable String empId) {
        service.deleteEmployee(empId);
        return "Employee deleted successfully";
    }
}