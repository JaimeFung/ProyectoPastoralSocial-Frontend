<%-- 
    Document   : usuarios
    Created on : Dec 15, 2025, 5:17:37 PM
    Author     : Jaime
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="edu.ulatina.controller.UsuarioController"%>
<%@page import="edu.ulatina.model.Usuario"%>
<%@page import="java.util.List"%>

<%
    // Verificar sesión
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Cargar lista de usuarios
    UsuarioController controller = new UsuarioController();
    List<Usuario> usuarios = controller.listarTodos();
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Usuarios y seguridad - Pastoral Social</title>
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
                max-width: 1300px;
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
                padding: 0.8rem 1.1rem;
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

            .btn-secondary {
                background: #FFFFFF;
                color: var(--color-primary);
                border: 1px solid var(--color-border);
                box-shadow: none;
            }

            .btn-secondary:hover {
                background: #F3F4F6;
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

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                gap: 1rem;
                margin-bottom: 1.1rem;
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
            }

            /* FILTROS USUARIOS */
            .filters-row {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 1rem;
                align-items: flex-end;
                margin-bottom: 1.1rem;
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

            /* TABLA USUARIOS */
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

            .user-name {
                font-weight: 500;
                color: #111827;
            }

            .user-meta {
                font-size: 0.78rem;
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

            .badge-role {
                background: #E0ECF9;
                color: #1D4ED8;
                white-space: nowrap;
            }

            .badge-admin {
                background: #FEE2E2;
                color: #991B1B;
            }

            .badge-coordinador {
                background: #DBEAFE;
                color: #1E40AF;
            }

            .badge-voluntario {
                background: #E0E7FF;
                color: #4338CA;
            }

            .acciones-cell {
                white-space: nowrap;
            }

            .btn-table {
                padding: 0.25rem 0.65rem;
                border-radius: 999px;
                border: 1px solid var(--color-border);
                background: #FFFFFF;
                font-size: 0.75rem;
                cursor: pointer;
                color: var(--color-primary);
                margin-right: 0.25rem;
                transition: background-color 0.2s ease, color 0.2s ease, box-shadow 0.2s ease;
            }

            .btn-table:hover {
                background: var(--color-primary);
                color: #FFFFFF;
                box-shadow: 0 4px 10px rgba(15, 23, 42, 0.18);
            }

            /* FORMULARIO */
            .form-group {
                margin-bottom: 1rem;
            }

            .form-group label {
                font-size: 0.85rem;
                font-weight: 500;
                color: #374151;
                margin-bottom: 0.4rem;
                display: block;
            }

            .form-input {
                width: 100%;
                padding: 0.55rem 0.9rem;
                border-radius: 10px;
                border: 1px solid #D1D5DB;
                font-size: 0.87rem;
                background: #FDFBF7;
                transition: border-color 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease;
            }

            .form-input:focus {
                outline: none;
                border-color: var(--color-primary);
                box-shadow: 0 0 0 2px rgba(35, 65, 90, 0.16);
                background: #FFFFFF;
            }

            .help-text {
                font-size: 0.8rem;
                color: var(--color-muted);
                margin-top: 0.15rem;
            }

            .two-column-grid {
                display: grid;
                grid-template-columns: minmax(0, 2.2fr) minmax(0, 0.9fr);
                gap: 1.5rem;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 1rem;
                color: var(--color-muted);
            }

            @media (max-width: 900px) {
                .two-column-grid {
                    grid-template-columns: 1fr;
                }
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
                <a href="expedientes.jsp" class="nav-item">
                    <span>Expedientes</span>
                </a>
                <a href="usuarios.jsp" class="nav-item active">
                    <span>Usuarios y seguridad</span>
                </a>
                <a href="privacidad.jsp" class="nav-item">
                    <span>Privacidad y datos</span>
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
                        <h1 class="page-title">Usuarios y seguridad</h1>
                        <p class="page-subtitle">
                            Administración de cuentas de acceso al sistema. Total de usuarios: <strong><%= usuarios.size() %></strong>
                        </p>
                    </div>
                    <button class="btn btn-secondary" type="button" onclick="alert('Funcionalidad de crear usuario próximamente')">
                        + Crear usuario
                    </button>
                </div>

                <div class="two-column-grid">

                    <!-- ADMINISTRAR USUARIOS -->
                    <section class="card">
                        <div class="card-header">
                            <div>
                                <h2 class="card-title">Administrar usuarios</h2>
                                <p class="card-description">
                                    Revise los usuarios registrados, sus roles y su estado. Puede activar o inactivar cuentas.
                                </p>
                            </div>
                        </div>

                        <div class="filters-row">
                            <div class="filter-group">
                                <label for="buscarUsuario">Buscar usuario</label>
                                <input
                                    type="text"
                                    id="buscarUsuario"
                                    class="filter-input"
                                    placeholder="Nombre o usuario…">
                            </div>
                            <div class="filter-group">
                                <label for="filtroRol">Rol</label>
                                <select id="filtroRol" class="filter-select">
                                    <option value="">Todos</option>
                                    <option value="ADMIN">Administrador</option>
                                    <option value="COORDINADOR">Coordinador</option>
                                    <option value="VOLUNTARIO">Voluntario</option>
                                </select>
                            </div>
                            <div class="filter-group">
                                <label for="filtroEstadoUsuario">Estado</label>
                                <select id="filtroEstadoUsuario" class="filter-select">
                                    <option value="">Todos</option>
                                    <option value="true">Activo</option>
                                    <option value="false">Inactivo</option>
                                </select>
                            </div>
                        </div>

                        <div class="table-container">
                            <% if (usuarios.isEmpty()) { %>
                                <div class="empty-state">
                                    <p>No hay usuarios registrados en el sistema.</p>
                                </div>
                            <% } else { %>
                                <table id="tablaUsuarios">
                                    <thead>
                                        <tr>
                                            <th>Usuario</th>
                                            <th>Correo</th>
                                            <th>Rol</th>
                                            <th>Parroquia</th>
                                            <th>Estado</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Usuario u : usuarios) { 
                                            String badgeRol = "";
                                            switch(u.getRol()) {
                                                case ADMIN:
                                                    badgeRol = "badge-admin";
                                                    break;
                                                case COORDINADOR:
                                                    badgeRol = "badge-coordinador";
                                                    break;
                                                case VOLUNTARIO:
                                                    badgeRol = "badge-voluntario";
                                                    break;
                                            }
                                        %>
                                        <tr
                                            data-rol="<%= u.getRol() %>"
                                            data-estado="<%= u.getActivo() %>">
                                            <td>
                                                <div class="user-name"><%= u.getNombreCompleto() %></div>
                                                <div class="user-meta">Usuario: <%= u.getNombreUsuario() %></div>
                                            </td>
                                            <td><%= u.getEmail() != null ? u.getEmail() : "Sin email" %></td>
                                            <td>
                                                <span class="badge <%= badgeRol %>">
                                                    <%= u.getRol() %>
                                                </span>
                                            </td>
                                            <td>Catedral</td>
                                            <td>
                                                <span class="badge <%= u.getActivo() ? "badge-active" : "badge-inactive" %> estado-badge">
                                                    <%= u.getActivo() ? "Activo" : "Inactivo" %>
                                                </span>
                                            </td>
                                            
                                            <td class="acciones-cell">
                                            <button class="btn-table btn-toggle-estado" type="button">Inactivar</button>
                                            <button class="btn-table btn-reset-pass" type="button">Restablecer clave</button>
                                            </td>
                                            
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            <% } %>
                        </div>
                    </section>

                    <!-- CAMBIAR CONTRASEÑA -->
                    <section class="card">
                        <div class="card-header">
                            <div>
                                <h2 class="card-title">Cambiar contraseña</h2>
                                <p class="card-description">
                                    Actualice su contraseña personal de acceso al sistema. Por seguridad, se recomienda
                                    cambiarla periódicamente.
                                </p>
                            </div>
                        </div>

                        <form id="formCambiarClave" onsubmit="return validarCambioPassword(event)">
                            <div class="form-group">
                                <label for="claveActual">Contraseña actual</label>
                                <input
                                    type="password"
                                    id="claveActual"
                                    name="claveActual"
                                    class="form-input"
                                    required>
                            </div>

                            <div class="form-group">
                                <label for="nuevaClave">Nueva contraseña</label>
                                <input
                                    type="password"
                                    id="nuevaClave"
                                    name="nuevaClave"
                                    class="form-input"
                                    required>
                                <p class="help-text">
                                    Use al menos 8 caracteres, combinando letras y números.
                                </p>
                            </div>

                            <div class="form-group">
                                <label for="confirmarClave">Confirmar nueva contraseña</label>
                                <input
                                    type="password"
                                    id="confirmarClave"
                                    name="confirmarClave"
                                    class="form-input"
                                    required>
                            </div>

                            <button type="submit" class="btn">
                                Guardar cambios
                            </button>
                        </form>
                    </section>
                </div>

            </div>
        </main>

        <script>
            // --- FILTRO DE USUARIOS ---
            const buscarUsuario = document.getElementById('buscarUsuario');
            const filtroRol = document.getElementById('filtroRol');
            const filtroEstadoUsuario = document.getElementById('filtroEstadoUsuario');
            const filasUsuarios = Array.from(document.querySelectorAll('#tablaUsuarios tbody tr'));

            function aplicarFiltrosUsuarios() {
                const texto = buscarUsuario.value.trim().toLowerCase();
                const rol = filtroRol.value;
                const estado = filtroEstadoUsuario.value;

                filasUsuarios.forEach(fila => {
                    const contenido = fila.textContent.toLowerCase();
                    const rolFila = fila.getAttribute('data-rol');
                    const estadoFila = fila.getAttribute('data-estado');

                    const coincideTexto = contenido.includes(texto);
                    const coincideRol = !rol || rol === rolFila;
                    const coincideEstado = !estado || estado === estadoFila;

                    if (coincideTexto && coincideRol && coincideEstado) {
                        fila.style.display = '';
                    } else {
                        fila.style.display = 'none';
                    }
                });
            }

            buscarUsuario.addEventListener('input', aplicarFiltrosUsuarios);
            filtroRol.addEventListener('change', aplicarFiltrosUsuarios);
            filtroEstadoUsuario.addEventListener('change', aplicarFiltrosUsuarios);

            // --- VALIDAR CAMBIO DE CONTRASEÑA ---
            function validarCambioPassword(e) {
                e.preventDefault();

                const actual = document.getElementById('claveActual').value;
                const nueva = document.getElementById('nuevaClave').value;
                const confirmar = document.getElementById('confirmarClave').value;

                if (!actual || !nueva || !confirmar) {
                    alert('Por favor complete todos los campos.');
                    return false;
                }

                if (nueva.length < 8) {
                    alert('La nueva contraseña debe tener al menos 8 caracteres.');
                    return false;
                }

                if (nueva !== confirmar) {
                    alert('La nueva contraseña y la confirmación no coinciden.');
                    return false;
                }

                alert('Funcionalidad de cambio de contraseña próximamente.\n\nDatos ingresados correctamente.');
                document.getElementById('formCambiarClave').reset();
                return false;
            }
        </script>
    </body>
</html>