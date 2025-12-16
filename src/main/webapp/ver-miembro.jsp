<%-- 
    Document   : ver-miembro
    Created on : Dec 16, 2025
    Author     : Jaime
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="edu.ulatina.controller.*"%>
<%@page import="edu.ulatina.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Obtener el ID del miembro desde el parámetro
    String idMiembroStr = request.getParameter("id");
    
    if (idMiembroStr == null || idMiembroStr.trim().isEmpty()) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    Integer idMiembro = null;
    try {
        idMiembro = Integer.parseInt(idMiembroStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    // Buscar el miembro
    MiembroFamiliaController miembroController = new MiembroFamiliaController();
    MiembroFamilia miembro = miembroController.buscarPorId(idMiembro);
    
    if (miembro == null) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    Familia familia = miembro.getFamilia();
    
    // Buscar expediente para el botón de volver
    ExpedienteController expedienteController = new ExpedienteController();
    Expediente expediente = expedienteController.buscarPorFamilia(familia.getIdFamilia());
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    
    // Calcular edad
    java.util.Date hoy = new java.util.Date();
    long diferencia = hoy.getTime() - miembro.getFechaNacimiento().getTime();
    int edad = (int) (diferencia / (1000L * 60 * 60 * 24 * 365));
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ver Miembro - Pastoral Social</title>
    <style>
        :root {
            --color-bg: #F7F4EE;
            --color-primary: #23415A;
            --color-primary-dark: #1B3146;
            --color-accent: #C9A568;
            --color-border: #E5DED0;
            --color-text: #1F2933;
            --color-muted: #6B7280;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: var(--color-bg);
            display: flex;
            min-height: 100vh;
            color: var(--color-text);
        }

        .sidebar {
            width: 280px;
            background: #FFFFFF;
            padding: 1.5rem 1rem;
            border-right: 1px solid var(--color-border);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
            position: fixed;
            height: 100vh;
            left: 0;
            top: 0;
            overflow-y: auto;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.6rem;
            padding: 0.5rem 0.5rem 1rem;
            border-bottom: 1px solid var(--color-border);
        }

        .logo {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, var(--color-primary), var(--color-accent));
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.22);
        }

        .logo::before,
        .logo::after {
            content: "";
            position: absolute;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 999px;
        }

        .logo::before {
            width: 4px;
            height: 24px;
        }

        .logo::after {
            width: 20px;
            height: 4px;
        }

        .brand-text h1 {
            font-size: 1.125rem;
            font-weight: 600;
            color: #111827;
        }

        .brand-text p {
            font-size: 0.75rem;
            color: var(--color-muted);
        }

        .nav-menu {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            margin-top: 1.1rem;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.7rem 1rem;
            color: #4B5563;
            text-decoration: none;
            border-radius: 999px;
            transition: all 0.2s ease;
            font-size: 0.9rem;
        }

        .nav-item:hover {
            background: #E3EDF5;
            color: var(--color-primary);
        }

        .nav-item.active {
            background: var(--color-primary);
            color: #FFFFFF;
            font-weight: 600;
        }

        .top-navbar {
            position: fixed;
            top: 0;
            right: 0;
            left: 280px;
            background: rgba(255, 255, 255, 0.96);
            backdrop-filter: blur(6px);
            border-bottom: 1px solid var(--color-border);
            padding: 0.9rem 2rem;
            display: flex;
            justify-content: flex-end;
            z-index: 10;
        }

        .nav-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .nav-actions a {
            color: #4B5563;
            text-decoration: none;
            font-size: 0.875rem;
            transition: color 0.2s ease;
        }

        .nav-actions a:hover {
            color: var(--color-primary);
            text-decoration: underline;
        }

        .main-content {
            margin-left: 280px;
            flex: 1;
            padding-top: 80px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem 1.5rem;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .back-btn {
            padding: 0.45rem 1rem;
            border-radius: 999px;
            border: none;
            background: #E3EDF5;
            color: var(--color-primary);
            font-size: 0.8rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            box-shadow: 0 6px 14px rgba(15, 23, 42, 0.12);
            transition: all 0.2s ease;
            text-decoration: none;
            margin-bottom: 1rem;
        }

        .back-btn::before {
            content: "←";
        }

        .back-btn:hover {
            background: #D6E3F1;
            box-shadow: 0 8px 18px rgba(15, 23, 42, 0.16);
            transform: translateY(-1px);
        }

        .page-title {
            font-size: 1.9rem;
            color: #111827;
            margin-bottom: 0.3rem;
        }

        .page-subtitle {
            color: var(--color-muted);
            font-size: 0.9rem;
        }

        .card {
            background: #FFFFFF;
            border-radius: 12px;
            padding: 1.8rem;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06);
            border: 1px solid var(--color-border);
            margin-bottom: 1.5rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--color-border);
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #111827;
            margin-bottom: 0.25rem;
        }

        .card-description {
            font-size: 0.875rem;
            color: var(--color-muted);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 0.35rem;
        }

        .info-label {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--color-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .info-value {
            font-size: 1rem;
            color: var(--color-text);
        }

        .pill {
            display: inline-block;
            font-size: 0.8rem;
            padding: 0.35rem 0.85rem;
            border-radius: 999px;
            border: 1px solid var(--color-border);
            background: #F9FAFB;
            color: #4B5563;
        }

        .pill-primary {
            border-color: #BFDBFE;
            background: #DBEAFE;
            color: #1E40AF;
        }

        .btn-row {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .btn {
            padding: 0.625rem 1.25rem;
            border-radius: 999px;
            border: none;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: var(--color-primary);
            color: #FFFFFF;
            box-shadow: 0 5px 18px rgba(15, 23, 42, 0.25);
        }

        .btn-primary:hover {
            background: var(--color-primary-dark);
            box-shadow: 0 7px 22px rgba(15, 23, 42, 0.3);
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: #FFFFFF;
            color: var(--color-primary);
            border: 1px solid var(--color-border);
        }

        .btn-secondary:hover {
            background: #F3F4F6;
        }

        .btn-danger {
            background: #FFFFFF;
            color: #DC2626;
            border: 1px solid #FCA5A5;
        }

        .btn-danger:hover {
            background: #FEE2E2;
        }

        .section-divider {
            height: 1px;
            background: var(--color-border);
            margin: 1.5rem 0;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                height: auto;
            }

            .top-navbar {
                left: 0;
                position: relative;
            }

            .main-content {
                margin-left: 0;
                padding-top: 0;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .card-header {
                flex-direction: column;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="logo-container">
            <div class="logo"></div>
            <div class="brand-text">
                <h1>Pastoral Social</h1>
                <p>Diócesis de Cartago</p>
            </div>
        </div>

        <nav class="nav-menu">
            <a href="dashboard.jsp" class="nav-item">Panel principal</a>
            <a href="expedientes.jsp" class="nav-item active">Expedientes</a>
        </nav>
    </aside>

    <!-- Top navbar -->
    <header class="top-navbar">
        <div class="nav-actions">
            <a href="usuarios.jsp">Configurar cuenta</a>
            <a href="login.jsp">Cerrar sesión</a>
        </div>
    </header>

    <!-- Main -->
    <main class="main-content">
        <div class="container">

            <div class="page-header">
                <%
                    String backUrl = "expedientes.jsp";
                    if (expediente != null) {
                        backUrl = "expediente-detalle.jsp?id=" + expediente.getIdExpediente();
                    }
                %>
                <a href="<%= backUrl %>" class="back-btn">Volver al expediente</a>
                <h1 class="page-title"><%= miembro.getNombreCompleto() %></h1>
                <p class="page-subtitle">
                    Miembro de la familia <%= familia.getNumeroExpediente() %>
                </p>
            </div>

            <!-- Información Personal -->
            <section class="card">
                <div class="card-header">
                    <div>
                        <h2 class="card-title">Información Personal</h2>
                        <p class="card-description">Datos básicos del miembro de la familia</p>
                    </div>
                    <div class="btn-row">
                        <a href="editar-miembro.jsp?id=<%= miembro.getIdMiembro() %>" 
                           class="btn btn-primary">Editar</a>
                    </div>
                </div>

                <div style="margin-bottom: 1.25rem;">
                    <span class="pill pill-primary"><%= miembro.getParentesco() %></span>
                    <span class="pill"><%= edad %> años</span>
                </div>

                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Nombre Completo</span>
                        <span class="info-value"><%= miembro.getNombreCompleto() %></span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Identificación</span>
                        <span class="info-value">
                            <%= miembro.getIdentificacion() != null ? miembro.getIdentificacion() : "No especificada" %>
                        </span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Fecha de Nacimiento</span>
                        <span class="info-value"><%= sdf.format(miembro.getFechaNacimiento()) %></span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Género</span>
                        <span class="info-value"><%= miembro.getGenero() %></span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Estado Civil</span>
                        <span class="info-value">
                            <%= miembro.getEstadoCivil() != null ? miembro.getEstadoCivil() : "No especificado" %>
                        </span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Parentesco</span>
                        <span class="info-value"><%= miembro.getParentesco() %></span>
                    </div>
                </div>
            </section>

            <!-- Información de Contacto -->
            <section class="card">
                <div class="card-header">
                    <div>
                        <h2 class="card-title">Información de Contacto</h2>
                        <p class="card-description">Datos de contacto del miembro</p>
                    </div>
                </div>

                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Teléfono</span>
                        <span class="info-value">
                            <%= miembro.getTelefono() != null ? miembro.getTelefono() : "No especificado" %>
                        </span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Email</span>
                        <span class="info-value">
                            <%= miembro.getEmail() != null ? miembro.getEmail() : "No especificado" %>
                        </span>
                    </div>
                </div>
            </section>

            <!-- Información de la Familia -->
            <section class="card">
                <div class="card-header">
                    <div>
                        <h2 class="card-title">Familia Asociada</h2>
                        <p class="card-description">Información de la familia a la que pertenece</p>
                    </div>
                </div>

                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Número de Expediente</span>
                        <span class="info-value"><%= familia.getNumeroExpediente() %></span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Jefe de Familia</span>
                        <span class="info-value"><%= familia.getNombreJefeFamilia() %></span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Parroquia</span>
                        <span class="info-value"><%= familia.getParroquia().getNombre() %></span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Total de Miembros</span>
                        <span class="info-value"><%= familia.getCantidadMiembros() %> personas</span>
                    </div>
                </div>

                <div class="section-divider"></div>

                <div class="btn-row">
                    <% if (expediente != null) { %>
                    <a href="expediente-detalle.jsp?id=<%= expediente.getIdExpediente() %>" 
                       class="btn btn-secondary">Ver expediente completo</a>
                    <% } %>
                    <a href="editar-miembro.jsp?id=<%= miembro.getIdMiembro() %>" 
                       class="btn btn-primary">Editar miembro</a>
                </div>
            </section>

        </div>
    </main>

</body>
</html>