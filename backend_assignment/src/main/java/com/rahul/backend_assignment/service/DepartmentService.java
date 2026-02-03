package com.rahul.backend_assignment.service;

import com.rahul.backend_assignment.models.Department;
import com.rahul.backend_assignment.models.DepartmentDTO;
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

    public List<DepartmentDTO> getAllDepartments() {
        return deptRepo.findAll().stream().map(this::mapToDTO).collect(Collectors.toList());
    }

    public DepartmentDTO getDepartmentById(String id) {
        Department department = deptRepo.findById(id)
                .orElseThrow(() -> new RuntimeException(AppConstants.DEPT_NOT_FOUND + id));
        return mapToDTO(department);
    }

    private DepartmentDTO mapToDTO(Department dept) {
        return DepartmentDTO.builder()
                .id(dept.getId())
                .name(dept.getName())
                .location(dept.getLocation())
                .employees(dept.getEmployees())
                .build();
    }
}
