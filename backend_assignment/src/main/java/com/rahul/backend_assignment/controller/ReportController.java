package com.rahul.backend_assignment.controller;

import com.rahul.backend_assignment.models.DepartmentDTO;
import com.rahul.backend_assignment.service.DepartmentService;
import com.rahul.backend_assignment.service.PdfService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.ByteArrayInputStream;
import java.util.List;

@RestController
@RequestMapping("/api")
public class ReportController {
    @Autowired
    private PdfService pdfService; // Inject the new service

    @Autowired
    private DepartmentService service;

    @GetMapping("/reports/employees")
    public ResponseEntity<InputStreamResource> downloadReport() {
        // 1. Fetch Data
        List<DepartmentDTO> departments = service.getAllDepartments();

        // 2. Generate PDF
        ByteArrayInputStream pdf = pdfService.generateEmployeeReport(departments);

        // 3. Return as Downloadable File
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=employees_report.pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(new InputStreamResource(pdf));
    }
}
