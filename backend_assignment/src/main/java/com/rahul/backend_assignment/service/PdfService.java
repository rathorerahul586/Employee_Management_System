package com.rahul.backend_assignment.service;

import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.rahul.backend_assignment.models.DepartmentResponseDTO;
import com.rahul.backend_assignment.models.Employee;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.List;

@Service
public class PdfService {

    public ByteArrayInputStream generateEmployeeReport(List<DepartmentResponseDTO> departments) {
        Document document = new Document();
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Loop through each department
            for (DepartmentResponseDTO dept : departments) {
                // Department Header
                Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
                Paragraph title = new Paragraph("Department: " + dept.getName(), titleFont);
                title.setAlignment(Element.ALIGN_CENTER);
                document.add(title);

                document.add(new Paragraph("Location: " + dept.getLocation()));
                document.add(Chunk.NEWLINE);

                // Employee Table
                PdfPTable table = new PdfPTable(4); // 4 Columns
                table.setWidthPercentage(100);

                // Table Headers
                addHeader(table, "ID");
                addHeader(table, "Name");
                addHeader(table, "Position");
                addHeader(table, "Salary");

                // Table Data
                for (Employee emp : dept.getEmployees()) {
                    table.addCell(emp.getId());
                    table.addCell(emp.getName());
                    table.addCell(emp.getPosition());
                    table.addCell("$" + emp.getSalary());
                }

                document.add(table);

                // Page Break for One Department per Page Requirement
                document.newPage();
            }

            document.close();

        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return new ByteArrayInputStream(out.toByteArray());
    }

    private void addHeader(PdfPTable table, String text) {
        PdfPCell header = new PdfPCell();
        header.setPhrase(new Phrase(text));
        header.setBackgroundColor(java.awt.Color.LIGHT_GRAY);
        header.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(header);
    }
}