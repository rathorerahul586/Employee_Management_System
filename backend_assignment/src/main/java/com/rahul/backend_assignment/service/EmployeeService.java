package com.rahul.backend_assignment.service;

import com.rahul.backend_assignment.exception.ResourceNotFoundException;
import com.rahul.backend_assignment.models.Department;
import com.rahul.backend_assignment.models.Employee;
import com.rahul.backend_assignment.models.EmployeeRequestDTO;
import com.rahul.backend_assignment.models.EmployeeResponseDTO;
import com.rahul.backend_assignment.repository.DepartmentRepository;
import com.rahul.backend_assignment.repository.EmployeeRepository;
import com.rahul.backend_assignment.utils.AppConstants;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class EmployeeService {

    private final EmployeeRepository empRepo;
    private final DepartmentRepository deptRepo;

    // READ: Return DTOs, not Entities
    public List<EmployeeResponseDTO> getAllEmployees() {
        return empRepo.findAll().stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    public List<EmployeeResponseDTO> getEmployeesByDept(String deptId) {
        return empRepo.findByDepartmentId(deptId).stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    // WRITE: Accept DTO, Return DTO
    @Transactional
    public EmployeeResponseDTO createEmployee(EmployeeRequestDTO request) {
        Department dept = deptRepo.findById(request.getDepartmentId())
                .orElseThrow(() -> new RuntimeException(AppConstants.DEPT_NOT_FOUND + request.getDepartmentId()));

        Employee emp = new Employee();
        emp.setName(request.getName());
        emp.setEmail(request.getEmail());
        emp.setPosition(request.getPosition());
        emp.setSalary(request.getSalary());
        emp.setDepartment(dept);

        Employee savedEmp = empRepo.save(emp);

        return mapToDTO(savedEmp);
    }

    @Transactional
    public EmployeeResponseDTO updateEmployee(String empId, EmployeeRequestDTO request) {
        Employee emp = empRepo.findById(empId)
                .orElseThrow(() -> new ResourceNotFoundException(AppConstants.EMPLOYEE_NOT_FOUND + empId));

        emp.setName(request.getName());
        emp.setEmail(request.getEmail());
        emp.setPosition(request.getPosition());
        emp.setSalary(request.getSalary());

        // Update Dept if changed
        if (request.getDepartmentId() != null) {
            Department dept = deptRepo.findById(request.getDepartmentId())
                    .orElseThrow(() -> new ResourceNotFoundException(AppConstants.DEPT_NOT_FOUND));
            emp.setDepartment(dept);
        }

        return mapToDTO(empRepo.save(emp));
    }

    public void deleteEmployee(String empId) {
        if (!empRepo.existsById(empId)) {
            throw new ResourceNotFoundException(AppConstants.EMPLOYEE_NOT_FOUND + empId);
        }
        empRepo.deleteById(empId);
    }

    // Helper: Entity -> DTO
    private EmployeeResponseDTO mapToDTO(Employee emp) {
        return EmployeeResponseDTO.builder()
                .id(emp.getId())
                .name(emp.getName())
                .email(emp.getEmail())
                .position(emp.getPosition())
                .salary(emp.getSalary())
                .departmentName(emp.getDepartment() != null ? emp.getDepartment().getName() : "N/A")
                .build();
    }
}