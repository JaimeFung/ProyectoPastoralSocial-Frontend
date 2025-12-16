<%-- 
    Document   : registrar-ayuda
    Created on : Dec 16, 2025
    Author     : Jaime
--%>

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
    
    // Verificar que el expediente existe
    ExpedienteController expedienteController = new ExpedienteController();
    Expediente expediente = expedienteController.buscarPorId(idExpediente);
    
    if (expediente == null) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    Familia familia = expediente.getFamilia();
    
    // Cargar tipos de ayuda y usuarios
    TipoAyudaController tipoAyudaController = new TipoAyudaController();
    List<TipoAyuda> tiposAyuda = tipoAyudaController.listarActivos();
    
    // TODO: Obtener usuario actual de la sesión
    // Por ahora usaremos un usuario fijo o el primero disponible
    UsuarioController usuarioController = new UsuarioController();
    List<Usuario> usuarios = usuarioController.listarActivos();
    
    // Procesar formulario si es POST
    String mensaje = null;
    String tipoMensaje = null;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String idTipoAyudaStr = request.getParameter("idTipoAyuda");
            String idUsuarioStr = request.getParameter("idUsuario");
            String fechaEntrega = request.getParameter("fechaEntrega");
            String descripcion = request.getParameter("descripcion");
            String cantidad = request.getParameter("cantidad");
            String valorEstimado = request.getParameter("valorEstimado");
            String observaciones = request.getParameter("observaciones");
            
            Integer idTipoAyuda = Integer.parseInt(idTipoAyudaStr);
            Integer idUsuario = Integer.parseInt(idUsuarioStr);
            
            AyudaEntregadaController ayudaController = new AyudaEntregadaController();
            AyudaEntregada nuevaAyuda = ayudaController.registrarAyuda(
                idExpediente, idTipoAyuda, idUsuario, fechaEntrega,
                descripcion, cantidad, valorEstimado, observaciones
            );
            
            if (nuevaAyuda != null) {
                response.sendRedirect("expediente-detalle.jsp?id=" + idExpediente);
                return;
            } else {
                mensaje = "Error al registrar la ayuda";
                tipoMensaje = "error";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "error";
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Ayuda - Pastoral Social</title>
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
            padding: 2rem;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06);
            border: 1px solid var(--color-border);
        }

        .alert {
            padding: 0.875rem 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.875rem;
        }

        .alert-success {
            background: #DCFCE7;
            border: 1px solid #BBF7D0;
            color: #166534;
        }

        .alert-error {
            background: #FEE2E2;
            border: 1px solid #FECACA;
            color: #991B1B;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
        }

        .form-label.required::after {
            content: " *";
            color: #DC2626;
        }

        .form-input,
        .form-select,
        .form-textarea {
            width: 100%;
            padding: 0.625rem 0.875rem;
            border: 1px solid var(--color-border);
            border-radius: 8px;
            font-size: 0.9rem;
            color: var(--color-text);
            font-family: inherit;
            transition: border-color 0.2s ease;
        }

        .form-textarea {
            min-height: 100px;
            resize: vertical;
        }

        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
            outline: none;
            border-color: var(--color-primary);
            box-shadow: 0 0 0 3px rgba(35, 65, 90, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .form-row-3 {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
        }

        .form-hint {
            font-size: 0.8rem;
            color: var(--color-muted);
            margin-top: 0.25rem;
        }

        .btn-group {
            display: flex;
            gap: 0.75rem;
            margin-top: 2rem;
            justify-content: flex-end;
        }

        .btn {
            padding: 0.625rem 1.5rem;
            border-radius: 999px;
            border: none;
            font-size: 0.9rem;
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

            .form-row,
            .form-row-3 {
                grid-template-columns: 1fr;
            }
        }
    </style>
    <script>
        // Auto-fill fecha actual
        window.addEventListener('DOMContentLoaded', function() {
            const fechaInput = document.querySelector('input[name="fechaEntrega"]');
            if (fechaInput && !fechaInput.value) {
                const today = new Date().toISOString().split('T')[0];
                fechaInput.value = today;
            }
        });
    </script>
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
                <a href="expediente-detalle.jsp?id=<%= idExpediente %>" class="back-btn">Volver al expediente</a>
                <h1 class="page-title">Registrar Ayuda Entregada</h1>
                <p class="page-subtitle">
                    Expediente <%= familia.getNumeroExpediente() %> - <%= familia.getNombreJefeFamilia() %>
                </p>
            </div>

            <% if (mensaje != null) { %>
            <div class="alert alert-<%= tipoMensaje %>">
                <%= mensaje %>
            </div>
            <% } %>

            <div class="card">
                <form method="POST" action="">
                    <input type="hidden" name="id" value="<%= idExpediente %>">

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Tipo de Ayuda</label>
                            <select name="idTipoAyuda" class="form-select" required>
                                <option value="">Seleccione...</option>
                                <% if (tiposAyuda != null) {
                                    for (TipoAyuda tipo : tiposAyuda) { %>
                                        <option value="<%= tipo.getIdTipoAyuda() %>">
                                            <%= tipo.getNombre() %> (<%= tipo.getCategoria() %>)
                                        </option>
                                    <% }
                                } %>
                            </select>
                            <div class="form-hint">Seleccione el tipo de ayuda entregada</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Fecha de Entrega</label>
                            <input type="date" name="fechaEntrega" class="form-input" required>
                            <div class="form-hint">Fecha en que se entregó la ayuda</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label required">Entregado por</label>
                        <select name="idUsuario" class="form-select" required>
                            <option value="">Seleccione...</option>
                            <% if (usuarios != null) {
                                for (Usuario usuario : usuarios) { %>
                                    <option value="<%= usuario.getIdUsuario() %>">
                                        <%= usuario.getNombreCompleto() %>
                                    </option>
                                <% }
                            } %>
                        </select>
                        <div class="form-hint">Usuario que realizó la entrega</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label required">Descripción</label>
                        <textarea name="descripcion" class="form-textarea" required
                                  placeholder="Ej: Paquete de alimentos con arroz, frijoles, aceite, azúcar y productos enlatados"></textarea>
                        <div class="form-hint">Describa detalladamente lo que se entregó</div>
                    </div>

                    <div class="form-row-3">
                        <div class="form-group">
                            <label class="form-label">Cantidad</label>
                            <input type="text" name="cantidad" class="form-input" 
                                   placeholder="Ej: 1 paquete, 5 kg, etc.">
                            <div class="form-hint">Cantidad entregada</div>
                        </div>

                        <div class="form-group" style="grid-column: span 2;">
                            <label class="form-label">Valor Estimado (₡)</label>
                            <input type="number" name="valorEstimado" class="form-input" 
                                   step="0.01" min="0" placeholder="Ej: 25000.00">
                            <div class="form-hint">Valor estimado en colones (opcional)</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Observaciones Adicionales</label>
                        <textarea name="observaciones" class="form-textarea"
                                  placeholder="Cualquier observación adicional sobre la entrega"></textarea>
                        <div class="form-hint">Información complementaria (opcional)</div>
                    </div>

                    <div class="btn-group">
                        <a href="expediente-detalle.jsp?id=<%= idExpediente %>" class="btn btn-secondary">Cancelar</a>
                        <button type="submit" class="btn btn-primary">Registrar Ayuda</button>
                    </div>
                </form>
            </div>

        </div>
    </main>

</body>
</html>