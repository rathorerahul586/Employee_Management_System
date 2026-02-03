package com.rahul.backend_assignment.controller;

import com.rahul.backend_assignment.models.EmployeeRequestDTO;
import com.rahul.backend_assignment.models.EmployeeResponseDTO;
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
    public ResponseEntity<ApiResponse<List<EmployeeResponseDTO>>> getAllEmployees() {
        return ResponseEntity.ok(
                ApiResponse.success(
                        employeeService.getAllEmployees(),
                        AppConstants.SUCCESS_MESSAGE
                )
        );
    }

    // GET ALL By Department id
    @GetMapping("departments/{id}")
    public ResponseEntity<ApiResponse<List<EmployeeResponseDTO>>> getAllEmployeesByDept(@PathVariable String id) {
        return ResponseEntity.ok(
                ApiResponse.success(
                        employeeService.getEmployeesByDept(id),
                        AppConstants.SUCCESS_MESSAGE
                )
        );
    }


    // CREATE (Wraps Request & Response)
    @PostMapping
    public ResponseEntity<ApiResponse<EmployeeResponseDTO>> createEmployee(
            @RequestBody ApiRequest<EmployeeRequestDTO> requestWrapper) {

        // Extract payload from Generic Request
        EmployeeRequestDTO requestData = requestWrapper.getPayload();

        EmployeeResponseDTO newEmployee = employeeService.createEmployee(requestData);

        return ResponseEntity.status(HttpStatus.CREATED).body(
                ApiResponse.success(newEmployee, "Employee created successfully")
        );
    }

    // UPDATE
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<EmployeeResponseDTO>> updateEmployee(
            @PathVariable String id,
            @RequestBody ApiRequest<EmployeeRequestDTO> requestWrapper) {

        EmployeeResponseDTO updatedEmployee = employeeService.updateEmployee(id, requestWrapper.getPayload());

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