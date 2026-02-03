package com.rahul.backend_assignment.service;

import com.rahul.backend_assignment.models.Department;
import com.rahul.backend_assignment.models.DepartmentResponseDTO;
import com.rahul.backend_assignment.repository.DepartmentRepository;
import com.rahul.backend_assignment.utils.AppConstants;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DepartmentService {

    private final DepartmentRepository deptRepo;

    public List<DepartmentResponseDTO> getAllDepartments() {
        return deptRepo.findAll().stream().map(this::mapToDTO).collect(Collectors.toList());
    }

    public DepartmentResponseDTO getDepartmentById(String id) {
        Department department = deptRepo.findById(id)
                .orElseThrow(() -> new RuntimeException(AppConstants.DEPT_NOT_FOUND + id));
        return mapToDTO(department);
    }

    private DepartmentResponseDTO mapToDTO(Department dept) {
        return DepartmentResponseDTO.builder()
                .id(dept.getId())
                .name(dept.getName())
                .location(dept.getLocation())
                .employees(dept.getEmployees())
                .build();
    }
}
