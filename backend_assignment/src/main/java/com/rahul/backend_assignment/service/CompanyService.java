package com.rahul.backend_assignment.service;

import com.rahul.backend_assignment.models.Department;
import com.rahul.backend_assignment.models.Employee;
import com.rahul.backend_assignment.repository.DepartmentRepository;
import com.rahul.backend_assignment.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CompanyService {

    @Autowired
    private DepartmentRepository deptRepo;

    @Autowired
    private EmployeeRepository empRepo;

    // --- READ Operations ---
    public List<Department> getAllDepartments() {
        return deptRepo.findAll();
    }

    public List<Employee> getAllEmployees() {
        return empRepo.findAll();
    }

    public List<Employee> getEmployeesByDept(String deptId) {
        return empRepo.findByDepartmentId(deptId);
    }

    // --- WRITE Operations ---

    @Transactional // Ensures if one part fails, the whole DB rolls back
    public Employee addEmployeeToDept(String deptId, Employee employee) {
        Department dept = deptRepo.findById(deptId)
                .orElseThrow(() -> new RuntimeException("Department not found with ID: " + deptId));

        // Link the employee to the department
        employee.setDepartment(dept);
        return empRepo.save(employee);
    }

    @Transactional
    public Employee updateEmployee(String empId, Employee updatedData) {
        return empRepo.findById(empId).map(employee -> {
            employee.setName(updatedData.getName());
            employee.setEmail(updatedData.getEmail());
            employee.setPosition(updatedData.getPosition());
            employee.setSalary(updatedData.getSalary());
            return empRepo.save(employee);
        }).orElseThrow(() -> new RuntimeException("Employee not found"));
    }

    public void deleteEmployee(String empId) {
        empRepo.deleteById(empId);
    }
}