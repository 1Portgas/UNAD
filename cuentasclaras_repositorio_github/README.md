# CuentasClaras - Sistema Web Transaccional para Gestión de Cartera Retail (TRL 5)

[![Java 21](https://img.shields.io/badge/Java-21%20LTS-orange.svg)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.4-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16%20ACID-blue.svg)](https://www.postgresql.org/)
[![React](https://img.shields.io/badge/React-18.3-cyan.svg)](https://react.dev/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind-3.4-38B2AC.svg)](https://tailwindcss.com/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED.svg)](https://www.docker.com/)
[![UNAD](https://img.shields.io/badge/UNAD-ECBTI%202026-003366.svg)](https://www.unad.edu.co/)

---

## 📌 Descripción del Proyecto
**CuentasClaras** es una solución tecnológica tipo Micro-SaaS diseñada para digitalizar, controlar y mitigar el riesgo en la gestión de créditos comerciales informales («fiados») en tiendas de barrio y microempresas del sector retail de **El Peñón, Santander**. 

Desarrollado como Proyecto Aplicado de Grado en la **Universidad Nacional Abierta y a Distancia (UNAD)**, el sistema alcanza un nivel de madurez tecnológica **TRL 5**, validado mediante pruebas de concurrencia y un piloto en 5 tiendas reales del municipio.

### 👥 Autores (Grupo #36)
* **Jhorman Felipe Fuentes Martínez** — C.C. 1005230700 (Product Owner & Backend Lead)
* **Nelson Daniel Carrasquilla Ariza** — C.C. 1098170181 (Scrum Master & Frontend Lead)
* **Tutor:** Daniel Andrés Guzmán Arevalo
* **Curso:** Proyecto de Grado (202016907) — Fase 4 Componente Práctico

---

## 🏗️ Arquitectura del Sistema
El sistema se organiza en tres capas desacopladas bajo principios de arquitectura empresarial:
1. **Frontend (Capa de Presentación):** Single Page Application (SPA) en React 18, empaquetada con Vite y servida en Nginx. Flujo operativo optimizado para registrar transacciones en menos de 15 segundos y máximo 3 toques con diseño de alto contraste.
2. **Backend (Lógica de Negocio):** API RESTful construida en Java 21 LTS con Spring Boot 3.3. Implementa gestión declarativa de transacciones (`@Transactional`), tipo de dato de precisión estricta (`BigDecimal`) y seguridad sin estado con tokens JWT y cifrado BCrypt.
3. **Base de Datos (Persistencia Relacional):** PostgreSQL 16 normalizado en Tercera Forma Normal (3FN), con soporte completo para transacciones ACID, bloqueo de filas concurrente y restricciones CHECK de integridad financiera.

---

## 🚀 Despliegue Rápido con Docker Compose

### Prerrequisitos
* [Docker Desktop](https://www.docker.com/products/docker-desktop/) (v24 o superior) y Docker Compose.

### Instrucciones de Ejecución
1. Clonar el repositorio:
   ```bash
   git clone https://github.com/jhorman-fuentes/cuentasclaras-transaccional-retail.git
   cd cuentasclaras-transaccional-retail
   ```
2. Iniciar los contenedores:
   ```bash
   docker compose up -d --build
   ```
3. Acceder a las plataformas:
   * **Aplicación Web (Frontend):** `http://localhost:80`
   * **API RESTful Backend:** `http://localhost:8080/api/v1`
   * **Base de Datos PostgreSQL:** `localhost:5432` (Usuario: `admin_cuentas`, BD: `cuentasclaras_prod`)

---

## 🔌 Endpoints RESTful Troncales

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| `POST` | `/api/v1/auth/login` | Autenticación del tendero y emisión de JWT firmado |
| `GET` | `/api/v1/clientes` | Directorio de clientes con balance y semáforo de mora |
| `POST` | `/api/v1/clientes` | Registro de deudor con verificación legal de Habeas Data |
| `POST` | `/api/v1/transacciones/fiado` | Cargo atómico de nuevo fiado con validación de cupo |
| `POST` | `/api/v1/transacciones/abono` | Registro atómico de abono parcial o total |
| `GET` | `/api/v1/cartera/resumen-dashboard` | Métricas consolidadas de cartera, recaudo y morosidad |

---

## 🧪 Pruebas Unitarias y de Integración
Para ejecutar la batería automatizada de pruebas unitarias y de concurrencia con JUnit 5 y Mockito:
```bash
cd backend
./mvnw clean test
```
