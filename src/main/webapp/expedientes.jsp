<%-- 
    Document   : expedientes
    Created on : Dec 15, 2025, 5:16:32 PM
    Author     : Jaime
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="edu.ulatina.controller.FamiliaController"%>
<%@page import="edu.ulatina.controller.ExpedienteController"%>
<%@page import="edu.ulatina.controller.ParroquiaController"%>
<%@page import="edu.ulatina.model.Usuario"%>
<%@page import="edu.ulatina.model.Familia"%>
<%@page import="edu.ulatina.model.Expediente"%>
<%@page import="edu.ulatina.model.Parroquia"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    // Verificar sesión
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Cargar datos del backend
    FamiliaController familiaController = new FamiliaController();
    ExpedienteController expedienteController = new ExpedienteController();
    ParroquiaController parroquiaController = new ParroquiaController();
    
    List<Familia> familias = familiaController.listarActivas();
    List<Expediente> expedientes = expedienteController.listarTodos();
    List<Parroquia> parroquias = parroquiaController.listarActivas();
    
    // Formato de fecha
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Expedientes - Pastoral Social</title>
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

            /* SIDEBAR */
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
                font-size: 0.9rem;
                transition: all 0.2s ease;
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

            /* TOP NAVBAR */
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
                justify-content: space-between;
                align-items: center;
                z-index: 10;
            }

            .user-info {
                font-size: 0.875rem;
                color: var(--color-muted);
            }

            .user-info strong {
                color: var(--color-primary);
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

            /* MAIN LAYOUT */
            .main-content {
                margin-left: 280px;
                flex: 1;
                padding-top: 80px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 2rem;
            }

            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 2rem;
                flex-wrap: wrap;
                gap: 1rem;
            }

            .page-title {
                font-size: 1.9rem;
                color: #111827;
                margin-bottom: 0.4rem;
                letter-spacing: 0.02em;
            }

            .page-subtitle {
                color: var(--color-muted);
                font-size: 0.95rem;
            }

            .btn {
                padding: 0.6rem 1.1rem;
                background: var(--color-primary);
                color: #FFFFFF;
                border: none;
                border-radius: 999px;
                font-size: 0.85rem;
                font-weight: 500;
                cursor: pointer;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                transition: background-color 0.2s ease, box-shadow 0.2s ease, transform 0.1s ease;
                box-shadow: 0 6px 14px rgba(15, 23, 42, 0.18);
            }

            .btn:hover {
                background: var(--color-primary-dark);
                box-shadow: 0 8px 18px rgba(15, 23, 42, 0.24);
                transform: translateY(-1px);
            }

            /* CARDS */
            .card {
                background: #FFFFFF;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 10px 25px rgba(15, 23, 42, 0.06);
                border: 1px solid var(--color-border);
                margin-bottom: 1.5rem;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #111827;
                margin-bottom: 0.25rem;
            }

            .card-description {
                font-size: 0.9rem;
                color: var(--color-muted);
                margin-bottom: 1.1rem;
            }

            /* BÚSQUEDA + FILTROS */
            .filters-row {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 1rem;
                align-items: flex-end;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 0.35rem;
                font-size: 0.85rem;
            }

            .filter-group label {
                color: var(--color-muted);
                font-weight: 500;
            }

            .filter-input,
            .filter-select {
                width: 100%;
                padding: 0.5rem 0.8rem;
                border-radius: 999px;
                border: 1px solid #D1D5DB;
                font-size: 0.85rem;
                background: #FDFBF7;
                transition: border-color 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease;
            }

            .filter-input:focus,
            .filter-select:focus {
                outline: none;
                border-color: var(--color-primary);
                box-shadow: 0 0 0 2px rgba(35, 65, 90, 0.16);
                background: #FFFFFF;
            }

            /* TABLA */
            .table-container {
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: #FFFFFF;
                border-radius: 0.75rem;
                overflow: hidden;
            }

            thead {
                background: #EDE7DA;
            }

            th {
                text-align: left;
                padding: 0.75rem 1rem;
                font-size: 0.85rem;
                font-weight: 600;
                color: #4B5563;
                border-bottom: 1px solid var(--color-border);
            }

            td {
                padding: 0.9rem 1rem;
                font-size: 0.875rem;
                color: #374151;
                border-bottom: 1px solid #E5E7EB;
                background: #FFFFFF;
            }

            tr:hover td {
                background: #F7F4EE;
            }

            .beneficiary-name {
                color: #111827;
                font-weight: 500;
            }

            .beneficiary-phone {
                font-size: 0.75rem;
                color: var(--color-muted);
            }

            .badge {
                padding: 0.25rem 0.7rem;
                border-radius: 999px;
                font-size: 0.75rem;
                font-weight: 500;
            }

            .badge-active {
                background: #DCFCE7;
                color: #166534;
            }

            .badge-inactive {
                background: #F3F4F6;
                color: #6B7280;
            }

            .badge-cerrado {
                background: #FEE2E2;
                color: #991B1B;
            }

            .acciones-cell {
                white-space: nowrap;
            }

            .link-acciones {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 0.35rem 0.8rem;
                border-radius: 999px;
                font-size: 0.8rem;
                font-weight: 500;
                text-decoration: none;
                border: 1px solid var(--color-border);
                color: var(--color-primary);
                background: #FFFFFF;
                transition: background-color 0.2s ease, color 0.2s ease, box-shadow 0.2s ease;
            }

            .link-acciones:hover {
                background: var(--color-primary);
                color: #FFFFFF;
                box-shadow: 0 8px 18px rgba(15, 23, 42, 0.18);
            }

            .empty-state {
                text-align: center;
                padding: 3rem 1rem;
                color: var(--color-muted);
            }

            .empty-state p {
                margin-bottom: 1rem;
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
                    padding: 1.5rem 1.25rem 2rem;
                }

                .filters-row {
                    grid-template-columns: 1fr;
                }

                table {
                    font-size: 0.75rem;
                }

                th,
                td {
                    padding: 0.6rem;
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
                <a href="dashboard.jsp" class="nav-item">
                    <span>Panel principal</span>
                </a>
                <a href="expedientes.jsp" class="nav-item active">
                    <span>Expedientes</span>
                </a>
                <a href="usuarios.jsp" class="nav-item">
                    <span>Usuarios y seguridad</span>
                </a>
            </nav>
        </aside>

        <!-- Top navbar -->
        <header class="top-navbar">
            <div class="user-info">
                <strong><%= usuarioLogueado.getNombreCompleto() %></strong> 
                (<%= usuarioLogueado.getRol() %>)
            </div>
            <div class="nav-actions">
                <a href="usuarios.jsp">Configurar cuenta</a>
                <a href="logout.jsp">Cerrar sesión</a>
            </div>
        </header>

        <!-- Main content -->
        <main class="main-content">
            <div class="container">

                <div class="page-header">
                    <div>
                        <h1 class="page-title">Expedientes de beneficiarios</h1>
                        <p class="page-subtitle">
                            Gestión y seguimiento de <%= familias.size() %> familias beneficiarias.
                        </p>
                    </div>
                    <a href="crear-expediente.jsp" class="btn">+ Crear expediente</a>
                </div>

                <!-- Búsqueda y filtros -->
                <section class="card">
                    <h2 class="card-title">Búsqueda y filtros</h2>
                    <p class="card-description">
                        Buscar por nombre, cédula o número de expediente, y filtrar por estado o parroquia.
                    </p>

                    <div class="filters-row">
                        <div class="filter-group">
                            <label for="searchInput">Buscar</label>
                            <input
                                type="text"
                                id="searchInput"
                                class="filter-input"
                                placeholder="Nombre, cédula o código de expediente…">
                        </div>

                        <div class="filter-group">
                            <label for="filtroEstado">Estado del expediente</label>
                            <select id="filtroEstado" class="filter-select">
                                <option value="">Todos</option>
                                <option value="ACTIVO">Activo</option>
                                <option value="INACTIVO">Inactivo</option>
                                <option value="CERRADO">Cerrado</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="filtroParroquia">Parroquia</label>
                            <select id="filtroParroquia" class="filter-select">
                                <option value="">Todas</option>
                                <% for (Parroquia p : parroquias) { %>
                                    <option value="<%= p.getIdParroquia() %>">
                                        <%= p.getNombre() %>
                                    </option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                </section>

                <!-- Lista de expedientes -->
                <section class="card">
                    <h2 class="card-title">Lista de expedientes</h2>
                    <p class="card-description">
                        <span id="resultCount"><%= familias.size() %></span> expediente(s) encontrado(s)
                    </p>

                    <div class="table-container">
                        <% if (familias.isEmpty()) { %>
                            <div class="empty-state">
                                <p>No hay expedientes registrados en el sistema.</p>
                                <a href="crear-expediente.jsp" class="btn">Crear primer expediente</a>
                            </div>
                        <% } else { %>
                            <table id="expedientesTable">
                                <thead>
                                    <tr>
                                        <th>Código</th>
                                        <th>Jefe de Familia</th>
                                        <th>Cédula</th>
                                        <th>Parroquia</th>
                                        <th>Estado</th>
                                        <th>Fecha</th>
                                        <th>Ayudas</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    for (Familia f : familias) {
                                        // Buscar expediente de esta familia
                                        Expediente exp = null;
                                        for (Expediente e : expedientes) {
                                            if (e.getFamilia().getIdFamilia().equals(f.getIdFamilia())) {
                                                exp = e;
                                                break;
                                            }
                                        }
                                        
                                        String estadoBadge = "badge-active";
                                        String estadoTexto = "Activo";
                                        
                                        if (exp != null) {
                                            switch(exp.getEstado()) {
                                                case ACTIVO:
                                                    estadoBadge = "badge-active";
                                                    estadoTexto = "Activo";
                                                    break;
                                                case INACTIVO:
                                                    estadoBadge = "badge-inactive";
                                                    estadoTexto = "Inactivo";
                                                    break;
                                                case CERRADO:
                                                    estadoBadge = "badge-cerrado";
                                                    estadoTexto = "Cerrado";
                                                    break;
                                            }
                                        }
                                    %>
                                    <tr data-estado="<%= exp != null ? exp.getEstado() : "SIN_EXPEDIENTE" %>" 
                                        data-parroquia="<%= f.getParroquia().getIdParroquia() %>">
                                        <td><%= f.getNumeroExpediente() %></td>
                                        <td>
                                            <div class="beneficiary-name"><%= f.getNombreJefeFamilia() %></div>
                                            <% if (f.getTelefono() != null && !f.getTelefono().isEmpty()) { %>
                                                <div class="beneficiary-phone"><%= f.getTelefono() %></div>
                                            <% } %>
                                        </td>
                                        <td><%= f.getIdentificacionJefe() %></td>
                                        <td><%= f.getParroquia().getNombre() %></td>
                                        <td>
                                            <span class="badge <%= estadoBadge %>">
                                                <%= estadoTexto %>
                                            </span>
                                        </td>
                                        <td><%= dateFormat.format(f.getFechaRegistro()) %></td>
                                        <td>
                                            <% if (exp != null) { %>
                                                <%= exp.getTotalAyudasRecibidas() %>
                                            <% } else { %>
                                                0
                                            <% } %>
                                        </td>
                                        <td class="acciones-cell">
                                            <a href="expediente-detalle.jsp?id=<%= f.getIdFamilia() %>" 
                                               class="link-acciones">Ver detalle</a>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        <% } %>
                    </div>
                </section>

            </div>
        </main>

        <script>
            // Referencias a filtros
            const searchInput = document.getElementById('searchInput');
            const filtroEstado = document.getElementById('filtroEstado');
            const filtroParroquia = document.getElementById('filtroParroquia');

            const table = document.getElementById('expedientesTable');
            const tbody = table ? table.querySelector('tbody') : null;
            const resultCount = document.getElementById('resultCount');

            if (tbody) {
                const rows = Array.from(tbody.querySelectorAll('tr'));

                function aplicarFiltros() {
                    const texto = searchInput.value.trim().toLowerCase();
                    const estadoSeleccionado = filtroEstado.value;
                    const parroquiaSeleccionada = filtroParroquia.value;

                    let visibles = 0;

                    rows.forEach(row => {
                        const contenido = row.textContent.toLowerCase();
                        const estadoRow = row.dataset.estado || "";
                        const parroquiaRow = row.dataset.parroquia || "";

                        const coincideTexto = !texto || contenido.includes(texto);
                        const coincideEstado = !estadoSeleccionado || estadoRow === estadoSeleccionado;
                        const coincideParroquia = !parroquiaSeleccionada || parroquiaRow === parroquiaSeleccionada;

                        if (coincideTexto && coincideEstado && coincideParroquia) {
                            row.style.display = "";
                            visibles++;
                        } else {
                            row.style.display = "none";
                        }
                    });

                    resultCount.textContent = visibles;
                }

                // Eventos
                searchInput.addEventListener('input', aplicarFiltros);
                filtroEstado.addEventListener('change', aplicarFiltros);
                filtroParroquia.addEventListener('change', aplicarFiltros);

                // Aplicar filtros al cargar
                aplicarFiltros();
            }
        </script>
    </body>
</html>