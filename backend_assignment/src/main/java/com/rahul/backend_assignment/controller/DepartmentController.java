package com.rahul.backend_assignment.controller;

import com.rahul.backend_assignment.models.DepartmentDTO;
import com.rahul.backend_assignment.models.common.ApiResponse;
import com.rahul.backend_assignment.service.DepartmentService;
import com.rahul.backend_assignment.utils.AppConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController // Tells Spring this class handles REST API requests
@RequestMapping("/api") // Base URL for all endpoints
public class DepartmentController {

    @Autowired
    private DepartmentService service;

    // GET /departments
    @GetMapping("/departments")
    public ResponseEntity<ApiResponse<List<DepartmentDTO>>> getDepartments() {
        // Wraps the list inside a key named "departments"
        List<DepartmentDTO> departments = service.getAllDepartments();
        return ResponseEntity.ok(
                ApiResponse.success(departments, AppConstants.SUCCESS_MESSAGE)
        );
    }

    // GET /departments/{deptId}
    @GetMapping("/departments/{deptId}")
    public ResponseEntity<ApiResponse<DepartmentDTO>> getDepartmentById(@PathVariable String deptId) {
        DepartmentDTO department = service.getDepartmentById(deptId);
        return ResponseEntity.ok(
                ApiResponse.success(department, AppConstants.SUCCESS_MESSAGE)
        );
    }
}