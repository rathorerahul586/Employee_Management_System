# Employee Management System

A full-stack application with a Spring Boot backend and a Flutter mobile app for managing employee records and attendance.

## 🛠 Tech Stack

**Backend**
* **Framework:** Spring Boot (Java 17)
* **Database:** H2 (In-memory)
* **Reporting:** OpenPDF (Dynamic PDF generation)
* **Build Tool:** Maven

**Mobile App**
* **Framework:** Flutter (Dart)
* **State Management:** Bloc / Cubit
* **Architecture:** Clean Architecture (Data, Domain, Presentation)
* **Networking:** Dio with Interceptors
* **UI:** Custom Glassmorphism Theme & Animations

---

## 🚀 How to Run

### 1. Backend (Spring Boot)
The backend must be running first.

1.  Open the `backend_assignment` folder.
2.  Run the application:
    ```bash
    mvn spring-boot:run
    ```
    *(Or run `BackendAssignmentApplication.java` from your IDE)*
3.  **Verify:** Open `http://localhost:8080/api/departments` in your browser.

### 2. Mobile App (Flutter)
1.  Open the `mobile_assignment` folder.
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Run the app:
    ```bash
    flutter run
    ```

> **Note:** For Android Emulators, the app connects to `10.0.2.2`. If running on a physical device, update `api_client.dart` with your machine's IP address.

---

## 🔐 Login Credentials

The app uses standard validation (Email Regex & Min 6 chars password). You can use any valid email, or use these sample credentials:

* **Email:** `admin@company.com`
* **Password:** `123456`

---

## 🔌 API Endpoints & Request Structure

The application uses a **Standardized Request/Response Wrapper** to ensure consistent API communication and metadata tracking.

### **Generic Request Format**
For `POST` and `PUT` requests, wrap your data inside the `payload` key:
```json
{
    "requestId": "uuid-string",
    "source": "MOBILE_APP",
    "payload": {
        "name": "Rahul",
        "email": "rahul@example.com",
        "position": "SDE 2",
        "salary": 1200000,
        "departmentId": "dept01"
    }
}
```

#### The backend exposes the following RESTful endpoints:

### **Employees**
| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/employees` | Fetch a list of all employees. |
| `GET` | `/api/employees/departments/{id}` | Fetch employees by Department ID. |
| `POST` | `/api/employees` | Create a new employee (Requires ApiRequest wrapper). |
| `GET` | `/api/employees/{id}` | Get details of a specific employee by ID. |
| `PUT` | `/api/employees/{id}` | Update an existing employee's details. |
| `DELETE` | `/api/employees/{id}` | Remove an employee from the database. |

### **Departments**
| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/departments` | Fetch all departments with their employees. |
| `POST` | `/departments/{deptId}` | Fetch department by ID. |

### **Reports**
| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/reports/employees` | Generates and downloads a PDF report of all employees, organized by department. |

---

## ✨ Key Features
* **Dashboard:** Attendance "Punch In" with ripple animation.
* **Employees:** View and filter employee lists by department.
* **Reporting:** Download Department-wise PDF reports.
* **Profile:** Camera/Gallery integration for profile photos.
* **Validation:** Login form with regex validation.
* **Notifications:** Android 13+ Permission handling & local alerts.
* **Standardized API:** Implementation of `ApiRequest<T>` and `ApiResponse<T>` to encapsulate metadata, status, and payload.
* **Global Exception Handling:** Centralized `@RestControllerAdvice` to catch errors and return structured JSON responses.
