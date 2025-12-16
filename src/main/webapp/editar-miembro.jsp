<%-- 
    Document   : editar-miembro
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
    
    // Buscar expediente para navegación
    ExpedienteController expedienteController = new ExpedienteController();
    Expediente expediente = expedienteController.buscarPorFamilia(familia.getIdFamilia());
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    // Procesar formulario si es POST
    String mensaje = null;
    String tipoMensaje = null;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String accion = request.getParameter("accion");
        
        // Si es eliminar
        if ("eliminar".equals(accion)) {
            try {
                miembroController.eliminarMiembro(idMiembro);
                
                // Redirigir al expediente
                if (expediente != null) {
                    response.sendRedirect("expediente-detalle.jsp?id=" + expediente.getIdExpediente() + "&mensaje=eliminado");
                } else {
                    response.sendRedirect("expedientes.jsp");
                }
                return;
            } catch (Exception e) {
                mensaje = "Error al eliminar el miembro: " + e.getMessage();
                tipoMensaje = "error";
                e.printStackTrace();
            }
        } else {
            // Actualizar datos
            try {
                // Actualizar datos básicos
                miembro.setNombre(request.getParameter("nombre"));
                miembro.setPrimerApellido(request.getParameter("primerApellido"));
                miembro.setSegundoApellido(request.getParameter("segundoApellido"));
                miembro.setIdentificacion(request.getParameter("identificacion"));
                
                // Fecha de nacimiento
                String fechaNacimientoStr = request.getParameter("fechaNacimiento");
                if (fechaNacimientoStr != null && !fechaNacimientoStr.trim().isEmpty()) {
                    SimpleDateFormat sdfParse = new SimpleDateFormat("yyyy-MM-dd");
                    miembro.setFechaNacimiento(sdfParse.parse(fechaNacimientoStr));
                }
                
                // Género
                String generoStr = request.getParameter("genero");
                if (generoStr != null && !generoStr.trim().isEmpty()) {
                    MiembroFamilia.Genero genero = MiembroFamilia.Genero.valueOf(generoStr.toUpperCase());
                    miembro.setGenero(genero);
                }
                
                // Parentesco
                String parentescoStr = request.getParameter("parentesco");
                if (parentescoStr != null && !parentescoStr.trim().isEmpty()) {
                    MiembroFamilia.Parentesco parentesco = MiembroFamilia.Parentesco.valueOf(parentescoStr.toUpperCase());
                    miembro.setParentesco(parentesco);
                }
                
                // Datos opcionales
                miembro.setEstadoCivil(request.getParameter("estadoCivil"));
                miembro.setTelefono(request.getParameter("telefono"));
                miembro.setEmail(request.getParameter("email"));
                
                // Guardar cambios
                MiembroFamilia actualizado = miembroController.actualizarMiembro(miembro);
                
                if (actualizado != null) {
                    mensaje = "Miembro actualizado correctamente";
                    tipoMensaje = "success";
                    // Recargar miembro con datos actualizados
                    miembro = actualizado;
                } else {
                    mensaje = "Error al actualizar el miembro";
                    tipoMensaje = "error";
                }
            } catch (Exception e) {
                mensaje = "Error: " + e.getMessage();
                tipoMensaje = "error";
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Miembro - Pastoral Social</title>
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
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-size: 1.15rem;
            font-weight: 600;
            color: #111827;
            margin-bottom: 0.5rem;
        }

        .card-description {
            font-size: 0.875rem;
            color: var(--color-muted);
            margin-bottom: 1.5rem;
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

        .btn-danger {
            background: #DC2626;
            color: #FFFFFF;
            box-shadow: 0 5px 18px rgba(220, 38, 38, 0.25);
        }

        .btn-danger:hover {
            background: #B91C1C;
            box-shadow: 0 7px 22px rgba(220, 38, 38, 0.3);
            transform: translateY(-1px);
        }

        .section-divider {
            height: 1px;
            background: var(--color-border);
            margin: 1.5rem 0;
        }

        .danger-zone {
            border: 1px solid #FCA5A5;
            border-radius: 8px;
            padding: 1.25rem;
            background: #FEF2F2;
        }

        .danger-zone-title {
            font-size: 0.875rem;
            font-weight: 600;
            color: #991B1B;
            margin-bottom: 0.5rem;
        }

        .danger-zone-text {
            font-size: 0.8rem;
            color: #DC2626;
            margin-bottom: 0.75rem;
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

            .btn-group {
                flex-direction: column;
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
                <a href="expediente-detalle.jsp?id=<%= miembro.getIdMiembro() %>" class="back-btn">Volver</a>
                <h1 class="page-title">Editar Miembro</h1>
                <p class="page-subtitle">
                    <%= miembro.getNombreCompleto() %> - Familia <%= familia.getNumeroExpediente() %>
                </p>
            </div>

            <% if (mensaje != null) { %>
            <div class="alert alert-<%= tipoMensaje %>">
                <%= mensaje %>
            </div>
            <% } %>

            <div class="card">
                <h2 class="card-title">Información Personal</h2>
                <p class="card-description">Actualiza los datos del miembro de la familia</p>

                <form method="POST" action="">
                    <input type="hidden" name="id" value="<%= miembro.getIdMiembro() %>">

                    <div class="form-row-3">
                        <div class="form-group">
                            <label class="form-label required">Nombre</label>
                            <input type="text" name="nombre" class="form-input" 
                                   value="<%= miembro.getNombre() %>" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Primer Apellido</label>
                            <input type="text" name="primerApellido" class="form-input" 
                                   value="<%= miembro.getPrimerApellido() %>" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Segundo Apellido</label>
                            <input type="text" name="segundoApellido" class="form-input" 
                                   value="<%= miembro.getSegundoApellido() != null ? miembro.getSegundoApellido() : "" %>">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Identificación</label>
                            <input type="text" name="identificacion" class="form-input" 
                                   value="<%= miembro.getIdentificacion() != null ? miembro.getIdentificacion() : "" %>">
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Fecha de Nacimiento</label>
                            <input type="date" name="fechaNacimiento" class="form-input" 
                                   value="<%= sdf.format(miembro.getFechaNacimiento()) %>" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Género</label>
                            <select name="genero" class="form-select" required>
                                <option value="MASCULINO" <%= miembro.getGenero() == MiembroFamilia.Genero.MASCULINO ? "selected" : "" %>>Masculino</option>
                                <option value="FEMENINO" <%= miembro.getGenero() == MiembroFamilia.Genero.FEMENINO ? "selected" : "" %>>Femenino</option>
                                <option value="OTRO" <%= miembro.getGenero() == MiembroFamilia.Genero.OTRO ? "selected" : "" %>>Otro</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Parentesco</label>
                            <select name="parentesco" class="form-select" required>
                                <option value="JEFE" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.JEFE ? "selected" : "" %>>Jefe de Familia</option>
                                <option value="HIJO" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.HIJO ? "selected" : "" %>>Hijo/a</option>
                                <option value="CONYUGE" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.CONYUGE ? "selected" : "" %>>Cónyuge</option>
                                <option value="PADRE" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.PADRE ? "selected" : "" %>>Padre/Madre</option>
                                <option value="HERMANO" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.HERMANO ? "selected" : "" %>>Hermano/a</option>
                                <option value="ABUELO" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.ABUELO ? "selected" : "" %>>Abuelo/a</option>
                                <option value="NIETO" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.NIETO ? "selected" : "" %>>Nieto/a</option>
                                <option value="TIO" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.TIO ? "selected" : "" %>>Tío/a</option>
                                <option value="SOBRINO" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.SOBRINO ? "selected" : "" %>>Sobrino/a</option>
                                <option value="OTRO" <%= miembro.getParentesco() == MiembroFamilia.Parentesco.OTRO ? "selected" : "" %>>Otro</option>
                            </select>
                        </div>
                    </div>

                    <div class="section-divider"></div>

                    <h3 class="card-title" style="font-size: 1rem; margin-bottom: 1rem;">Información de Contacto</h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Estado Civil</label>
                            <input type="text" name="estadoCivil" class="form-input" 
                                   value="<%= miembro.getEstadoCivil() != null ? miembro.getEstadoCivil() : "" %>"
                                   placeholder="Soltero, Casado, Unión libre, etc.">
                        </div>

                        <div class="form-group">
                            <label class="form-label">Teléfono</label>
                            <input type="tel" name="telefono" class="form-input" 
                                   value="<%= miembro.getTelefono() != null ? miembro.getTelefono() : "" %>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-input" 
                               value="<%= miembro.getEmail() != null ? miembro.getEmail() : "" %>">
                    </div>

                    <div class="btn-group">
                        <a href="ver-miembro.jsp?id=<%= miembro.getIdMiembro() %>" 
                           class="btn btn-secondary">Cancelar</a>
                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    </div>
                </form>
            </div>

            <!-- Zona de peligro -->
            <div class="card" style="margin-top: 2rem;">
                <div class="danger-zone">
                    <h3 class="danger-zone-title">⚠️ Zona de Peligro</h3>
                    <p class="danger-zone-text">
                        Eliminar este miembro es una acción permanente. El registro se eliminará de la base de datos y no se podrá recuperar.
                    </p>
                    <form method="POST" action="" 
                          onsubmit="return confirm('¿Está seguro de que desea eliminar este miembro? Esta acción no se puede deshacer.');">
                        <input type="hidden" name="accion" value="eliminar">
                        <button type="submit" class="btn btn-danger">Eliminar Miembro</button>
                    </form>
                </div>
            </div>

        </div>
    </main>

</body>
</html>