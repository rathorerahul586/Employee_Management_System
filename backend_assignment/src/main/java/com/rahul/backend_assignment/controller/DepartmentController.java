package com.rahul.backend_assignment.controller;

import com.rahul.backend_assignment.models.DepartmentResponseDTO;
import com.rahul.backend_assignment.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Map;


@RestController // Tells Spring this class handles REST API requests
@RequestMapping("/api") // Base URL for all endpoints
public class DepartmentController {

    @Autowired
    private DepartmentService service;

    // GET /departments
    @GetMapping("/departments")
    public Map<String, Object> getDepartments() {
        // Wraps the list inside a key named "departments"
        return Collections.singletonMap("departments", service.getAllDepartments());
    }

    // GET /departments/{deptId}
    @GetMapping("/departments/{deptId}")
    public DepartmentResponseDTO getEmployeesByDept(@PathVariable String deptId) {
        return service.getDepartmentById(deptId);
    }
}