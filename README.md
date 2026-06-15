# Hospital Management System

A beautiful, premium web-based Hospital Management System (HMS) designed to manage doctors, patients, appointments, billing, and medical records. Built with JSP, HTML5/CSS3, and Java, backing onto a MySQL database.

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/vinayyy39/Hospital-System-App)

---

## Features

- **Doctor Portal**: Manage schedules, patient records, and appointments.
- **Patient Management**: Register patients, view medical histories, and track billing details.
- **Billing & Invoices**: Generate billing invoices dynamically.
- **Modern Responsive UI**: Clean aesthetics utilizing Google Fonts and custom styling.

---

## Deployment on Render

This project is configured with a `render.yaml` blueprint and a `Dockerfile` for seamless deployment.

### 1. Database Setup
The application requires a MySQL database. You can host one for free using services like [Railway](https://railway.app/), [Aiven](https://aiven.io/), or [Clever Cloud](https://www.clever-cloud.com/).
1. Spin up a MySQL database instance.
2. Import your database schema (tables for `doctor`, `patient`, `billing`, etc.).
3. Copy the database connection URL (e.g., `mysql://user:pass@host:port/dbname`).

### 2. Deploy in One Click
1. Click the **Deploy to Render** button above.
2. Render will automatically parse the `render.yaml` configuration.
3. In the environment configuration, set `DB_URL` to your MySQL connection URL.
4. Click **Deploy**.

---

## Local Development

### Prerequisites
- Java 8 or higher
- Maven 3.6+
- MySQL Server

### Building the Project
Run the following command in the project root:
```bash
mvn clean package -DskipTests
```

This will produce a `hospital-management-system.war` inside the `target/` directory, which can be deployed to any Tomcat 8.5+ servlet container.
