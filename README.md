# 📊 DXC Platform — Enterprise Project Management System
*Application de Gestion des Projets d'Entreprise*

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.11-6DB33F?style=for-the-badge&logo=springboot&logoColor=white)](https://spring.io/projects/spring-boot)
[![Angular](https://img.shields.io/badge/Angular-21.1.0-DD0031?style=for-the-badge&logo=angular&logoColor=white)](https://angular.dev/)
[![Java](https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![NVIDIA AI](https://img.shields.io/badge/NVIDIA%20AI-NIM%20LLM-76B900?style=for-the-badge&logo=nvidia&logoColor=white)](https://www.nvidia.com/)
[![WebAuthn](https://img.shields.io/badge/WebAuthn-Passkeys-007ACC?style=for-the-badge&logo=fido&logoColor=white)](https://webauthn.io/)

A modern, full-stack enterprise project management platform featuring **Role-Based Access Control (RBAC)**, **AI-powered Risk Assessment**, **WebAuthn Biometric Authentication (Passkeys)**, **Real-Time WebSocket Chat**, and **Automated Multi-Format Reporting (PDF/Excel)**.

---

## 🌟 Key Features

### 🔐 1. Multi-Role RBAC & Advanced Security
- **5 Tailored Roles & Workspaces**:
  - 🛡️ **Administrator (`ADMIN`)**: User management, roles & permissions, profile definitions, client directory, security audit logs.
  - 📋 **Project Manager (`CHEF_DE_PROJET`)**: Project planning, sprint & task delegation, team allocations, workload balancing.
  - 👔 **Manager (`MANAGER`)**: Executive overview, project reviews, validation/rejection workflows, manager feedback.
  - 💻 **Team Member (`MEMBRE_EQUIPE`)**: Assigned task board, personal workload tracking, calendar events, internal messaging.
  - 💼 **Contract Manager (`RESPONSABLE_CONTRAT`)**: Client contracting, project billing status, TJM (*Taux Journalier Moyen*) calculation.
- **Dual Authentication**:
  - Stateless **JWT (JSON Web Tokens)** with encrypted password hashing.
  - **FIDO2 / WebAuthn Biometrics**: Log in with Fingerprint, Face ID, Windows Hello, or Touch ID via Passkeys.

---

### 🧠 2. AI-Powered Project Intelligence (NVIDIA NIM)
- **Automated Risk Scoring**: Real-time evaluation of project health, milestone progress, and task delay patterns.
- **AI Recommendations**: Predictive insights on bottlenecks, resource allocation, and mitigation suggestions powered by **NVIDIA NIM LLM integration**.
- **Automated Background Scheduler**: Recurring risk evaluations and anomaly alerts.

---

### 💬 3. Real-Time Collaboration & Messaging
- **WebSocket STOMP & SockJS**: Instant messaging channels for teams, private 1-on-1 conversations, message reactions, and unread badges.
- **In-App Notifications**: Real-time popups and bell indicators for task assignments, approvals, deadline reminders, and system alerts.

---

### 📊 4. Reporting & Multi-Format Exports
- **Interactive Dashboards**: Real-time KPI cards, progress bars, workload charts (Chart.js), and team member distributions.
- **Automated Excel Export**: Formatted `.xlsx` spreadsheets powered by **Apache POI** for projects, tasks, user audits, and overdue items.
- **Automated PDF Export**: Executive `.pdf` reports generated with **OpenPDF / jsPDF** featuring customized layouts, tables, and metrics.

---

### 📅 5. Shared Calendar & Meeting Management
- Interactive calendar synchronized with task deadlines, project milestones, and meeting invitations with RSVP statuses.

---

## 🏗️ Architecture & Project Structure

```
Application-de-gestion-des-projets-d-entreprise/
│
├── Backend/                         # Spring Boot 3 REST API & Business Logic
│   ├── pom.xml                      # Maven Dependencies (Spring Data, Security, Flyway, POI, OpenPDF)
│   └── src/main/
│       ├── java/com/dxc/dxc_platform/
│       │   ├── config/              # Security, CORS, WebSocket, WebAuthn & Upload configs
│       │   ├── controller/          # 20 REST & WebSocket Controllers
│       │   ├── dto/                 # 33 Data Transfer Objects
│       │   ├── entity/              # 14 JPA Database Entities
│       │   ├── enums/               # Status, Priority, RiskLevel, Genre
│       │   ├── mapper/              # MapStruct Entity-DTO Mappers
│       │   ├── repository/          # Spring Data JPA Repositories
│       │   ├── security/            # JWT Filters, UserDetails & WebAuthn services
│       │   ├── service/             # 22 Interfaces & Service Implementations
│       │   └── shared/              # Exception Handling, Excel & PDF generators
│       └── resources/
│           ├── application.properties # Server, Database & SMTP configs
│           └── templates/           # Thymeleaf email templates
│
└── Frontend/                        # Angular 21 Single Page Application (SPA)
    ├── angular.json                 # Angular build & budget configurations
    ├── package.json                 # Angular dependencies, Chart.js, jsPDF, STOMP
    └── src/app/
        ├── app.routes.ts            # Role-based route definitions
        ├── auth/                    # Login, Password change & Biometric registration
        ├── core/                    # Auth interceptor & 25 Angular services
        ├── features/                # Role-specific modules (Admin, Chef, Manager, Membre, RC)
        └── shared/components/       # Dashboard, Calendar, Messaging, Reporting & Audit
```

---

## 🛠️ Technology Stack

| Layer | Technologies |
| :--- | :--- |
| **Backend Framework** | Spring Boot 3.5.11, Spring Security 6, Spring Data JPA |
| **Language & Runtime** | Java 17 |
| **Database & Migration** | PostgreSQL 18.1, Flyway |
| **Frontend Framework** | Angular 21 (Standalone Components, Signals) |
| **Styling & Charts** | Vanilla CSS3, Chart.js |
| **Security & Auth** | JWT (`io.jsonwebtoken`), WebAuthn / Yubico FIDO2 |
| **Real-time Protocol** | WebSocket (STOMP over SockJS) |
| **AI Integration** | NVIDIA NIM API (`meta/llama-3.3-70b-instruct`) |
| **Document Generation** | Apache POI (`.xlsx`), OpenPDF / jsPDF (`.pdf`) |
| **API Documentation** | SpringDoc OpenAPI 3 / Swagger UI |

---

## 🚀 Getting Started

### 📋 Prerequisites
Make sure you have the following installed on your machine:
- **Java JDK 17** (or compatible)
- **Node.js** (v20.x or v24.x) & **npm** (v10+)
- **PostgreSQL 14+** running on `localhost:5432`

---

### 🗄️ 1. Database Setup
Create a PostgreSQL database named `gestion_projet`:
```sql
CREATE DATABASE gestion_projet;
```

---

### ⚙️ 2. Backend Setup & Run

1. Navigate to the `Backend` directory:
   ```bash
   cd Backend
   ```
2. Verify or update `src/main/resources/application.properties` with your database credentials:
   ```properties
   spring.datasource.url=jdbc:postgresql://localhost:5432/gestion_projet
   spring.datasource.username=postgres
   spring.datasource.password=root
   ```
3. Run the Spring Boot application using Maven:
   ```bash
   ./mvnw spring-boot:run
   ```
   *The backend will start at: **`http://localhost:8080`***
   *Swagger API Documentation: **`http://localhost:8080/swagger-ui/index.html`***

---

### 💻 3. Frontend Setup & Run

1. Navigate to the `Frontend` directory:
   ```bash
   cd Frontend
   ```
2. Install npm dependencies:
   ```bash
   npm install
   ```
3. Start the Angular development server:
   ```bash
   npm start
   ```
   *The frontend will start at: **`http://localhost:4200`***

---

## 📡 Main REST API Endpoints

| Category | Endpoint | Method | Description |
| :--- | :--- | :--- | :--- |
| **Authentication** | `/api/auth/login` | `POST` | User login with email/password (returns JWT) |
| | `/api/auth/register-biometric` | `POST` | Register WebAuthn Passkey credential |
| | `/api/auth/login-biometric` | `POST` | Authenticate with WebAuthn Passkey |
| **Projects** | `/api/projects` | `GET` / `POST` | List or create projects |
| | `/api/projects/{id}` | `GET` / `PUT` / `DELETE` | Retrieve, update or soft-delete a project |
| | `/api/projects/{id}/review` | `POST` | Manager approval or rejection review |
| **Tasks** | `/api/tasks` | `GET` / `POST` | List or create tasks |
| | `/api/tasks/{id}/status` | `PUT` | Update task progress status |
| **AI Predictions** | `/api/predictions/project/{id}` | `GET` | Generate NVIDIA AI risk scoring & prediction |
| **Reporting** | `/api/reporting/projects` | `GET` | Filtered project reports |
| | `/api/reporting/projects/export` | `GET` | Export project report to Excel (`.xlsx`) |
| | `/api/reporting/projects/export/pdf` | `GET` | Export project report to PDF (`.pdf`) |
| **Messages** | `/api/messages/conversations` | `GET` / `POST` | Retrieve or create chat conversations |
| **Calendar** | `/api/calendar/invitations` | `GET` / `POST` | Manage calendar meetings & invitations |

---

## 👥 Roles & Workspace Overview

| Role | Default Landing Route | Key Capabilities |
| :--- | :--- | :--- |
| **`ADMIN`** | `/admin/dashboard` | Manage users, roles, clients, profiles, view audit logs |
| **`CHEF_DE_PROJET`** | `/chef-projet/dashboard` | Manage projects, tasks, teams, calendar, instant messaging |
| **`MANAGER`** | `/manager/dashboard` | Review & approve projects, validate progress, monitor KPIs |
| **`MEMBRE_EQUIPE`** | `/membre-equipe/dashboard` | Update task states, track deliverables, collaborate with team |
| **`RESPONSABLE_CONTRAT`** | `/responsable-contrat/dashboard` | Calculate TJM rates, manage client project billing |

---

## 📄 License
This project is developed for DXC enterprise project management and internal governance.
