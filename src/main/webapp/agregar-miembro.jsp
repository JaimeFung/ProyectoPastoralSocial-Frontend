<%-- 
    Document   : agregar-miembro
    Created on : Dec 16, 2025
    Author     : Jaime
--%>

<%@page import="edu.ulatina.controller.*"%>
<%@page import="edu.ulatina.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Obtener el ID de la familia desde el parámetro
    String idFamiliaStr = request.getParameter("idFamilia");
    
    if (idFamiliaStr == null || idFamiliaStr.trim().isEmpty()) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    Integer idFamilia = null;
    try {
        idFamilia = Integer.parseInt(idFamiliaStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    // Verificar que la familia existe
    FamiliaController familiaController = new FamiliaController();
    Familia familia = familiaController.buscarPorId(idFamilia);
    
    if (familia == null) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    // Procesar formulario si es POST
    String mensaje = null;
    String tipoMensaje = null;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String nombre = request.getParameter("nombre");
            String primerApellido = request.getParameter("primerApellido");
            String segundoApellido = request.getParameter("segundoApellido");
            String identificacion = request.getParameter("identificacion");
            String fechaNacimiento = request.getParameter("fechaNacimiento");
            String genero = request.getParameter("genero");
            String estadoCivil = request.getParameter("estadoCivil");
            String telefono = request.getParameter("telefono");
            String email = request.getParameter("email");
            String parentesco = request.getParameter("parentesco");
            
            MiembroFamiliaController miembroController = new MiembroFamiliaController();
            MiembroFamilia nuevoMiembro = miembroController.registrarMiembro(
                idFamilia, nombre, primerApellido, segundoApellido,
                identificacion, fechaNacimiento, genero, estadoCivil,
                telefono, email, parentesco
            );
            
            if (nuevoMiembro != null) {
                // Buscar el expediente de la familia para redirigir
                ExpedienteController expedienteController = new ExpedienteController();
                Expediente expediente = expedienteController.buscarPorFamilia(idFamilia);
                
                if (expediente != null) {
                    response.sendRedirect("expediente-detalle.jsp?id=" + expediente.getIdExpediente());
                    return;
                } else {
                    mensaje = "Miembro agregado correctamente";
                    tipoMensaje = "success";
                }
            } else {
                mensaje = "Error al agregar el miembro";
                tipoMensaje = "error";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "error";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Miembro - Pastoral Social</title>
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
            max-width: 800px;
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
        .form-select {
            width: 100%;
            padding: 0.625rem 0.875rem;
            border: 1px solid var(--color-border);
            border-radius: 8px;
            font-size: 0.9rem;
            color: var(--color-text);
            transition: border-color 0.2s ease;
        }

        .form-input:focus,
        .form-select:focus {
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
                    ExpedienteController expedienteController = new ExpedienteController();
                    Expediente expediente = expedienteController.buscarPorFamilia(idFamilia);
                    String backUrl = "expedientes.jsp";
                    if (expediente != null) {
                        backUrl = "expediente-detalle.jsp?id=" + expediente.getIdExpediente();
                    }
                %>
                <a href="<%= backUrl %>" class="back-btn">Volver</a>
                <h1 class="page-title">Agregar Miembro</h1>
                <p class="page-subtitle">
                    Familia: <%= familia.getNumeroExpediente() %> - <%= familia.getNombreJefeFamilia() %>
                </p>
            </div>

            <% if (mensaje != null) { %>
            <div class="alert alert-<%= tipoMensaje %>">
                <%= mensaje %>
            </div>
            <% } %>

            <div class="card">
                <form method="POST" action="">
                    <input type="hidden" name="idFamilia" value="<%= idFamilia %>">

                    <div class="form-row-3">
                        <div class="form-group">
                            <label class="form-label required">Nombre</label>
                            <input type="text" name="nombre" class="form-input" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Primer Apellido</label>
                            <input type="text" name="primerApellido" class="form-input" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Segundo Apellido</label>
                            <input type="text" name="segundoApellido" class="form-input">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Identificación</label>
                            <input type="text" name="identificacion" class="form-input">
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Fecha de Nacimiento</label>
                            <input type="date" name="fechaNacimiento" class="form-input" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Género</label>
                            <select name="genero" class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option value="MASCULINO">Masculino</option>
                                <option value="FEMENINO">Femenino</option>
                                <option value="OTRO">Otro</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Parentesco</label>
                            <select name="parentesco" class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option value="HIJO">Hijo/a</option>
                                <option value="CONYUGE">Cónyuge</option>
                                <option value="PADRE">Padre/Madre</option>
                                <option value="HERMANO">Hermano/a</option>
                                <option value="ABUELO">Abuelo/a</option>
                                <option value="NIETO">Nieto/a</option>
                                <option value="TIO">Tío/a</option>
                                <option value="SOBRINO">Sobrino/a</option>
                                <option value="OTRO">Otro</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Estado Civil</label>
                            <input type="text" name="estadoCivil" class="form-input" 
                                   placeholder="Soltero, Casado, Unión libre, etc.">
                        </div>

                        <div class="form-group">
                            <label class="form-label">Teléfono</label>
                            <input type="tel" name="telefono" class="form-input">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-input">
                    </div>

                    <div class="btn-group">
                        <a href="<%= backUrl %>" class="btn btn-secondary">Cancelar</a>
                        <button type="submit" class="btn btn-primary">Guardar Miembro</button>
                    </div>
                </form>
            </div>

        </div>
    </main>

</body>
</html>