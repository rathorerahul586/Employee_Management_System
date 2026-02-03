package com.rahul.backend_assignment.controller;

import com.rahul.backend_assignment.models.EmployeeDTO;
import com.rahul.backend_assignment.models.common.ApiRequest;
import com.rahul.backend_assignment.models.common.ApiResponse;
import com.rahul.backend_assignment.service.EmployeeService;
import com.rahul.backend_assignment.utils.AppConstants;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/employees")
@RequiredArgsConstructor
public class EmployeeController {

    private final EmployeeService employeeService;

    // GET ALL
    @GetMapping
    public ResponseEntity<ApiResponse<List<EmployeeDTO>>> getAllEmployees() {
        return ResponseEntity.ok(
                ApiResponse.success(
                        employeeService.getAllEmployees(),
                        AppConstants.SUCCESS_MESSAGE
                )
        );
    }

    // GET ALL By Department id
    @GetMapping("departments/{id}")
    public ResponseEntity<ApiResponse<List<EmployeeDTO>>> getAllEmployeesByDept(@PathVariable String id) {
        return ResponseEntity.ok(
                ApiResponse.success(
                        employeeService.getEmployeesByDept(id),
                        AppConstants.SUCCESS_MESSAGE
                )
        );
    }


    // CREATE (Wraps Request & Response)
    @PostMapping
    public ResponseEntity<ApiResponse<EmployeeDTO>> createEmployee(
            @RequestBody ApiRequest<EmployeeDTO> requestWrapper) {

        // Extract payload from Generic Request
        EmployeeDTO requestData = requestWrapper.getPayload();

        EmployeeDTO newEmployee = employeeService.createEmployee(requestData);

        return ResponseEntity.status(HttpStatus.CREATED).body(
                ApiResponse.success(newEmployee, "Employee created successfully")
        );
    }

    // UPDATE
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<EmployeeDTO>> updateEmployee(
            @PathVariable String id,
            @RequestBody ApiRequest<EmployeeDTO> requestWrapper) {

        EmployeeDTO updatedEmployee = employeeService.updateEmployee(id, requestWrapper.getPayload());

        return ResponseEntity.ok(
                ApiResponse.success(updatedEmployee, "Employee updated successfully")
        );
    }

    // DELETE
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteEmployee(@PathVariable String id) {
        employeeService.deleteEmployee(id);
        return ResponseEntity.ok(
                ApiResponse.success(null, "Employee deleted successfully")
        );
    }
}