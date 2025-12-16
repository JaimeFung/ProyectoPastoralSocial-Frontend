<%-- 
    Document   : expediente-detalle
    Created on : Dec 15, 2025, 5:16:21 PM
    Author     : Jaime
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="edu.ulatina.controller.*"%>
<%@page import="edu.ulatina.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Obtener el ID del expediente desde el parámetro
    String idExpedienteStr = request.getParameter("id");

    if (idExpedienteStr == null || idExpedienteStr.trim().isEmpty()) {
        response.sendRedirect("expedientes.jsp");
        return;
    }

    Integer idExpediente = null;
    try {
        idExpediente = Integer.parseInt(idExpedienteStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("expedientes.jsp");
        return;
    }

    // Controladores
    ExpedienteController expedienteController = new ExpedienteController();
    AddendumController addendumController = new AddendumController();
    SeguimientoController seguimientoController = new SeguimientoController();
    MiembroFamiliaController miembroController = new MiembroFamiliaController();
    AyudaEntregadaController ayudaController = new AyudaEntregadaController();
    // Cargar datos del expediente
    Expediente expediente = expedienteController.buscarPorId(idExpediente);

    if (expediente == null) {
        response.sendRedirect("expedientes.jsp");
        return;
    }

    // Obtener familia asociada
    Familia familia = expediente.getFamilia();

    // Obtener jefe de familia
    MiembroFamilia jefeFamilia = miembroController.buscarJefeFamilia(familia.getIdFamilia());

    // Obtener miembros de la familia
    List<MiembroFamilia> miembrosFamilia = miembroController.listarPorFamilia(familia.getIdFamilia());

    // Obtener addendums
    List<Addendum> addendums = addendumController.listarPorExpediente(idExpediente);

    // Obtener seguimientos
    List<Seguimiento> seguimientos = seguimientoController.listarPorExpediente(idExpediente);

    List<AyudaEntregada> ayudasEntregadas = ayudaController.listarPorExpediente(idExpediente);
    // Formato de fecha
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat sdfLargo = new SimpleDateFormat("dd/MM/yyyy HH:mm");

    // Estado del expediente
    String estadoClase = "pill-success";
    String estadoTexto = "Abierto";

    if (expediente.getEstado() == Expediente.Estado.CERRADO) {
        estadoClase = "pill";
        estadoTexto = "Cerrado";
    }

%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Detalle de expediente - Pastoral Social</title>
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
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
                    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
                background: var(--color-bg);
                display: flex;
                min-height: 100vh;
                color: var(--color-text);
                line-height: 1.5;
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
                color: #FFFFFF;
                font-size: 24px;
                font-weight: bold;
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
                margin: 0;
                letter-spacing: 0.02em;
            }

            .brand-text p {
                font-size: 0.75rem;
                color: var(--color-muted);
                margin: 0;
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
                box-shadow: 0 0 0 1px rgba(201, 165, 104, 0.6);
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
                align-items: center;
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
                transition: color 0.2s ease, text-decoration 0.2s ease;
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
                max-width: 1150px;
                margin: 0 auto;
                padding: 2rem 1.5rem 2.4rem;
            }

            .page-header {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 2rem;
                flex-wrap: wrap;
            }

            .page-title {
                font-size: 1.9rem;
                color: #111827;
                margin-bottom: 0.2rem;
                letter-spacing: 0.02em;
            }

            .page-subtitle {
                color: var(--color-muted);
                font-size: 0.9rem;
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
                transition: background-color 0.2s ease, box-shadow 0.2s ease, transform 0.1s ease;
                text-decoration: none;
            }

            .back-btn::before {
                content: "←";
                font-size: 0.9rem;
            }

            .back-btn:hover {
                background: #D6E3F1;
                box-shadow: 0 8px 18px rgba(15, 23, 42, 0.16);
                transform: translateY(-1px);
            }

            .card {
                background: #FFFFFF;
                border-radius: 12px;
                padding: 1.5rem 1.4rem 1.4rem;
                box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06);
                border: 1px solid var(--color-border);
                margin-bottom: 1.4rem;
            }

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                gap: 1rem;
                margin-bottom: 0.8rem;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #111827;
            }

            .card-description {
                font-size: 0.88rem;
                color: var(--color-muted);
            }

            .pill-row {
                display: flex;
                gap: 0.5rem;
                flex-wrap: wrap;
            }

            .pill {
                font-size: 0.78rem;
                padding: 0.25rem 0.7rem;
                border-radius: 999px;
                border: 1px solid var(--color-border);
                background: #F9FAFB;
                color: #4B5563;
            }

            .pill-success {
                border-color: #BBF7D0;
                background: #DCFCE7;
                color: #166534;
            }

            .pill-warning {
                border-color: #FEF3C7;
                background: #FFFBEB;
                color: #92400E;
            }

            .two-column-grid {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 1.4rem;
                margin-bottom: 1.4rem;
            }

            .btn-row {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                margin-top: 0.2rem;
            }

            .btn {
                padding: 0.5rem 0.9rem;
                border-radius: 999px;
                border: none;
                font-size: 0.85rem;
                font-weight: 500;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.35rem;
                transition: background-color 0.2s ease, color 0.2s ease,
                    box-shadow 0.2s ease, transform 0.1s ease;
                text-decoration: none;
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

            .table-simple {
                width: 100%;
                border-collapse: collapse;
                margin-top: 0.6rem;
            }

            .table-simple th,
            .table-simple td {
                font-size: 0.82rem;
                padding: 0.4rem 0.3rem;
                border-bottom: 1px solid #E5E7EB;
                text-align: left;
            }

            .table-simple th {
                font-weight: 600;
                color: #4B5563;
            }

            .table-simple tr:last-child td {
                border-bottom: none;
            }

            .acciones-cell {
                white-space: nowrap;
            }

            .link-inline {
                border: none;
                background: transparent;
                color: var(--color-primary);
                font-size: 0.8rem;
                cursor: pointer;
                text-decoration: underline;
                padding: 0;
            }

            .timeline {
                margin-top: 0.6rem;
            }

            .timeline-item {
                border-left: 2px solid var(--color-border);
                padding-left: 0.75rem;
                margin-bottom: 0.7rem;
                position: relative;
            }

            .timeline-item::before {
                content: "";
                width: 8px;
                height: 8px;
                border-radius: 999px;
                background: var(--color-primary);
                position: absolute;
                left: -5px;
                top: 0.25rem;
            }

            .timeline-title {
                font-size: 0.85rem;
                font-weight: 500;
            }

            .timeline-meta {
                font-size: 0.75rem;
                color: var(--color-muted);
            }

            .timeline-text {
                font-size: 0.8rem;
                color: #374151;
            }

            .info-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
                margin-top: 1rem;
            }

            .info-item {
                display: flex;
                flex-direction: column;
                gap: 0.25rem;
            }

            .info-label {
                font-size: 0.75rem;
                font-weight: 600;
                color: var(--color-muted);
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

            .info-value {
                font-size: 0.9rem;
                color: var(--color-text);
            }

            .empty-state {
                text-align: center;
                padding: 2rem 1rem;
                color: var(--color-muted);
                font-size: 0.875rem;
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

                .container {
                    padding: 1.5rem 1.2rem 2rem;
                }

                .two-column-grid, .info-grid {
                    grid-template-columns: 1fr;
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
                    <a href="expedientes.jsp" class="back-btn">Volver a expedientes</a>
                    <div>
                        <h1 class="page-title">Expediente <%= familia.getNumeroExpediente()%></h1>
                        <p class="page-subtitle">
                            Beneficiario: <%= familia.getNombreJefeFamilia()%> &middot; 
                            <%= familia.getParroquia().getNombre()%>
                        </p>
                    </div>
                </div>

                <!-- Datos generales + modificar expediente -->
                <section class="card">
                    <div class="card-header">
                        <div>
                            <h2 class="card-title">Datos del expediente</h2>
                            <p class="card-description">
                                Información básica del solicitante y estado general del caso.
                            </p>
                        </div>
                        <div class="btn-row">
                            <a href="editar-expediente.jsp?id=<%= expediente.getIdExpediente()%>" 
                               class="btn btn-primary">Modificar expediente</a>
                        </div>
                    </div>

                    <div class="pill-row">
                        <span class="pill <%= estadoClase%>">Estado: <%= estadoTexto%></span>
                        <span class="pill">Fecha de apertura: <%= sdf.format(expediente.getFechaApertura())%></span>
                        <span class="pill">Situación: <%= familia.getSituacionEconomica()%></span>
                    </div>

                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Cédula</span>
                            <span class="info-value"><%= familia.getIdentificacionJefe()%></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Teléfono</span>
                            <span class="info-value"><%= familia.getTelefono() != null ? familia.getTelefono() : "No especificado"%></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Dirección</span>
                            <span class="info-value"><%= familia.getDireccion()%></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Miembros en la familia</span>
                            <span class="info-value"><%= familia.getCantidadMiembros()%> personas</span>
                        </div>
                    </div>

                    <% if (expediente.getNotasGenerales() != null && !expediente.getNotasGenerales().trim().isEmpty()) {%>
                    <div style="margin-top: 1rem; padding: 0.75rem; background: #F9FAFB; border-radius: 8px; border: 1px solid var(--color-border);">
                        <div class="info-label" style="margin-bottom: 0.5rem;">Notas Generales</div>
                        <div class="info-value"><%= expediente.getNotasGenerales()%></div>
                    </div>
                    <% } %>
                </section>

                <!-- Información del Jefe de Familia -->
                <% if (jefeFamilia != null) {%>
                <section class="card">
                    <div class="card-header">
                        <div>
                            <h2 class="card-title">Información del Jefe de Familia</h2>
                            <p class="card-description">
                                Datos personales del responsable del hogar.
                            </p>
                        </div>
                    </div>

                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Nombre Completo</span>
                            <span class="info-value"><%= jefeFamilia.getNombreCompleto()%></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Fecha de Nacimiento</span>
                            <span class="info-value"><%= sdf.format(jefeFamilia.getFechaNacimiento())%></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Género</span>
                            <span class="info-value"><%= jefeFamilia.getGenero()%></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Estado Civil</span>
                            <span class="info-value"><%= jefeFamilia.getEstadoCivil() != null ? jefeFamilia.getEstadoCivil() : "No especificado"%></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Email</span>
                            <span class="info-value"><%= jefeFamilia.getEmail() != null ? jefeFamilia.getEmail() : "No especificado"%></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Teléfono</span>
                            <span class="info-value"><%= jefeFamilia.getTelefono() != null ? jefeFamilia.getTelefono() : "No especificado"%></span>
                        </div>
                    </div>
                </section>
                <% }%>

                <!-- Miembros de la Familia -->
                <section class="card">
                    <div class="card-header">
                        <div>
                            <h2 class="card-title">Miembros de la Familia</h2>
                            <p class="card-description">
                                Todas las personas que conforman el núcleo familiar.
                            </p>
                        </div>
                        <a href="agregar-miembro.jsp?idFamilia=<%= familia.getIdFamilia()%>" 
                           class="btn btn-primary">Agregar miembro</a>
                    </div>

                    <% if (miembrosFamilia != null && !miembrosFamilia.isEmpty()) { %>
                    <table class="table-simple">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Parentesco</th>
                                <th>Fecha Nac.</th>
                                <th>Género</th>
                                <th class="acciones-cell">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (MiembroFamilia miembro : miembrosFamilia) {%>
                            <tr>
                                <td><%= miembro.getNombreCompleto()%></td>
                                <td><%= miembro.getParentesco()%></td>
                                <td><%= sdf.format(miembro.getFechaNacimiento())%></td>
                                <td><%= miembro.getGenero()%></td>
                                <td class="acciones-cell">
                                    <a href="ver-miembro.jsp?id=<%= miembro.getIdMiembro()%>" class="link-inline">Ver</a>
                                    &middot;
                                    <a href="editar-miembro.jsp?id=<%= miembro.getIdMiembro()%>" class="link-inline">Editar</a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <% } else { %>
                    <div class="empty-state">
                        No hay miembros registrados en esta familia.
                    </div>
                    <% }%>
                </section>

                <!-- Addendum y Seguimiento -->
                <section class="two-column-grid">
                    <!-- Addendum -->
                    <section class="card">
                        <div class="card-header">
                            <div>
                                <h2 class="card-title">Addendum del expediente</h2>
                                <p class="card-description">
                                    Notas formales que complementan o actualizan la información del expediente.
                                </p>
                            </div>
                            <a href="agregar-addendum.jsp?id=<%= expediente.getIdExpediente()%>" 
                               class="btn btn-primary">Agregar</a>
                        </div>

                        <% if (addendums != null && !addendums.isEmpty()) { %>
                        <table class="table-simple">
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>Descripción</th>
                                    <th class="acciones-cell">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Addendum addendum : addendums) {%>
                                <tr>
                                    <td><%= sdf.format(addendum.getFechaRegistro())%></td>
                                    <td><%= addendum.getObservaciones()%></td>
                                    <td class="acciones-cell">
                                        <a href="ver-addendum.jsp?id=<%= addendum.getIdAddendum()%>" class="link-inline">Ver</a>
                                        &middot;
                                        <a href="editar-addendum.jsp?id=<%= addendum.getIdAddendum()%>" class="link-inline">Editar</a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <% } else { %>
                        <div class="empty-state">
                            No hay addendums registrados.
                        </div>
                        <% }%>
                    </section>

                    <!-- Seguimiento y notas -->
                    <section class="card">
                        <div class="card-header">
                            <div>
                                <h2 class="card-title">Seguimiento y notas</h2>
                                <p class="card-description">
                                    Observaciones pastorales, visitas y acuerdos de seguimiento.
                                </p>
                            </div>
                            <a href="agregar-seguimiento.jsp?id=<%= expediente.getIdExpediente()%>" 
                               class="btn btn-primary">Agregar</a>
                        </div>

                        <% if (seguimientos != null && !seguimientos.isEmpty()) { %>
                        <div class="timeline">
                            <% for (Seguimiento seg : seguimientos) {%>
                            <div class="timeline-item">
                                <p class="timeline-title"><%= seg.getTitulo()%></p>
                                <p class="timeline-meta">
                                    <%= sdfLargo.format(seg.getFechaRegistro())%>
                                    <% if (seg.getResponsable() != null) {%>
                                    &middot; <%= seg.getResponsable()%>
                                    <% }%>
                                </p>
                                <p class="timeline-text"><%= seg.getDescripcion()%></p>
                            </div>
                            <% } %>
                        </div>
                        <% } else { %>
                        <div class="empty-state">
                            No hay seguimientos registrados.
                        </div>
                        <% }%>
                    </section>
                </section>

                <section class="one-column-grid">
                    <section class="card">
                        <div class="card-header">
                            <div>
                                <h2 class="card-title">Entregas asociadas a la ayuda</h2>
                                <p class="card-description">
                                    Registro de las ayudas entregadas al beneficiario dentro de este expediente.
                                </p>
                            </div>
                            <a href="registrar-ayuda.jsp?id=<%= expediente.getIdExpediente()%>" 
                               class="btn btn-primary">Registrar entrega</a>
                        </div>

                        <% if (ayudasEntregadas != null && !ayudasEntregadas.isEmpty()) { %>
                        <table class="table-simple">
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>Tipo de ayuda</th>
                                    <th>Entregado por</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (AyudaEntregada ayuda : ayudasEntregadas) {%>
                                <tr>
                                    <td><%= sdf.format(ayuda.getFechaEntrega())%></td>
                                    <td><%= ayuda.getTipoAyuda().getNombre()%></td>
                                    <td><%= ayuda.getUsuario().getNombreCompleto()%></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <% } else { %>
                        <div class="empty-state">
                            No hay ayudas registradas.
                        </div>
                        <% }%>
                    </section>

                    
                </section>

                

            </div>
        </main>
    </body>
</html>