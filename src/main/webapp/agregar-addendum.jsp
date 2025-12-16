<%-- 
    Document   : agregar-addendum
    Created on : Dec 16, 2025
    Author     : Jaime
--%>

<%@page import="edu.ulatina.controller.*"%>
<%@page import="edu.ulatina.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Obtener el ID del expediente
    String idExpedienteStr = request.getParameter("id");
    
    if (idExpedienteStr == null || idExpedienteStr.trim().isEmpty()) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    Integer idExpediente = Integer.parseInt(idExpedienteStr);
    
    // Cargar el expediente para mostrar información
    ExpedienteController expedienteController = new ExpedienteController();
    Expediente expediente = expedienteController.buscarPorId(idExpediente);
    
    if (expediente == null) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    Familia familia = expediente.getFamilia();
    
    String mensajeExito = null;
    String mensajeError = null;
    
    // Procesar formulario si es POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            AddendumController addendumController = new AddendumController();
            
            Addendum addendum = addendumController.crearAddendumCompleto(
                idExpediente,
                // Electricidad
                request.getParameter("electricidadMonto"),
                request.getParameter("electricidadFecha1"),
                request.getParameter("electricidadFecha2"),
                request.getParameter("electricidadFecha3"),
                // Agua
                request.getParameter("aguaMonto"),
                request.getParameter("aguaFecha1"),
                request.getParameter("aguaFecha2"),
                request.getParameter("aguaFecha3"),
                // Teléfono
                request.getParameter("telefonoMonto"),
                request.getParameter("telefonoFecha1"),
                request.getParameter("telefonoFecha2"),
                request.getParameter("telefonoFecha3"),
                // Internet
                request.getParameter("internetMonto"),
                request.getParameter("internetFecha1"),
                request.getParameter("internetFecha2"),
                request.getParameter("internetFecha3"),
                // Cable
                request.getParameter("cableMonto"),
                request.getParameter("cableFecha1"),
                request.getParameter("cableFecha2"),
                request.getParameter("cableFecha3"),
                // Alquiler
                request.getParameter("alquilerMonto"),
                request.getParameter("alquilerFecha1"),
                request.getParameter("alquilerFecha2"),
                request.getParameter("alquilerFecha3"),
                // Alimentación
                request.getParameter("alimentacionMonto"),
                request.getParameter("alimentacionFecha1"),
                request.getParameter("alimentacionFecha2"),
                request.getParameter("alimentacionFecha3"),
                // Medicamento
                request.getParameter("medicamentoMonto"),
                request.getParameter("medicamentoFecha1"),
                request.getParameter("medicamentoFecha2"),
                request.getParameter("medicamentoFecha3"),
                // Otros gastos
                request.getParameter("otroGasto1Nombre"),
                request.getParameter("otroGasto1Monto"),
                request.getParameter("otroGasto1Fecha1"),
                request.getParameter("otroGasto1Fecha2"),
                request.getParameter("otroGasto1Fecha3"),
                request.getParameter("otroGasto2Nombre"),
                request.getParameter("otroGasto2Monto"),
                request.getParameter("otroGasto2Fecha1"),
                request.getParameter("otroGasto2Fecha2"),
                request.getParameter("otroGasto2Fecha3"),
                // Observaciones
                request.getParameter("observaciones"),
                // Recomendación
                request.getParameter("recomiendaAyuda"),
                request.getParameter("recomendacionFecha")
            );
            
            if (addendum != null) {
                response.sendRedirect("expediente-detalle.jsp?id=" + idExpediente);
                return;
            } else {
                mensajeError = "Error al crear el addendum. Intente nuevamente.";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            mensajeError = "Error del sistema: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Addendum - Sistema Pastoral Social</title>
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
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto',
                'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans',
                'Helvetica Neue', sans-serif;
            background: var(--color-bg);
            padding: 2rem;
            color: var(--color-text);
            line-height: 1.5;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.9rem;
            color: #111827;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: var(--color-muted);
            font-size: 0.95rem;
        }

        .card {
            background: #FFFFFF;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06);
            border: 1px solid var(--color-border);
            margin-bottom: 1.5rem;
        }

        .section-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #111827;
            margin-bottom: 0.3rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--color-border);
        }

        .section-description {
            font-size: 0.875rem;
            color: var(--color-muted);
            margin-bottom: 1.2rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 0.8rem;
            margin-bottom: 0.8rem;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-size: 0.85rem;
            font-weight: 500;
            color: #374151;
            margin-bottom: 0.35rem;
        }

        input, textarea, select {
            width: 100%;
            padding: 0.55rem 0.8rem;
            border: 1px solid #D1D5DB;
            border-radius: 8px;
            font-size: 0.875rem;
            font-family: inherit;
            background: #FDFBF7;
            transition: all 0.2s ease;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: var(--color-primary);
            box-shadow: 0 0 0 3px rgba(35, 65, 90, 0.1);
            background: #FFFFFF;
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            flex: 1;
            padding: 0.75rem 1.5rem;
            border-radius: 999px;
            border: none;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: var(--color-primary);
            color: #FFFFFF;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.25);
        }

        .btn-primary:hover {
            background: var(--color-primary-dark);
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

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        .alert-error {
            background: #FEE2E2;
            border: 1px solid #EF4444;
            color: #DC2626;
        }

        .radio-group {
            display: flex;
            gap: 2rem;
            margin-top: 0.5rem;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .radio-option input[type="radio"] {
            width: auto;
            margin: 0;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Agregar Addendum</h1>
            <p class="page-subtitle">
                Expediente <%= familia.getNumeroExpediente() %> - <%= familia.getNombreJefeFamilia()%>
            </p>
        </div>

        <% if (mensajeError != null) { %>
            <div class="alert alert-error">
                ❌ <%= mensajeError %>
            </div>
        <% } %>

        <form method="post">
            <!-- Servicios Públicos -->
            <div class="card">
                <h2 class="section-title">Pagos Mensuales Actuales - Servicios Públicos</h2>
                <p class="section-description">Registre los montos y fechas de pago de los servicios básicos</p>

                <div class="form-row">
                    <div class="form-group">
                        <label>Electricidad (Monto ₡)</label>
                        <input type="number" step="0.01" name="electricidadMonto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="electricidadFecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="electricidadFecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="electricidadFecha3">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Agua (Monto ₡)</label>
                        <input type="number" step="0.01" name="aguaMonto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="aguaFecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="aguaFecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="aguaFecha3">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Teléfono (Monto ₡)</label>
                        <input type="number" step="0.01" name="telefonoMonto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="telefonoFecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="telefonoFecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="telefonoFecha3">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Internet (Monto ₡)</label>
                        <input type="number" step="0.01" name="internetMonto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="internetFecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="internetFecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="internetFecha3">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Cable (Monto ₡)</label>
                        <input type="number" step="0.01" name="cableMonto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="cableFecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="cableFecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="cableFecha3">
                    </div>
                </div>
            </div>

            <!-- Gasto de Vivienda -->
            <div class="card">
                <h2 class="section-title">Gasto de Vivienda</h2>
                <p class="section-description">Costos relacionados con la vivienda y alimentación</p>

                <div class="form-row">
                    <div class="form-group">
                        <label>Alquiler o Préstamo (Monto ₡)</label>
                        <input type="number" step="0.01" name="alquilerMonto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="alquilerFecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="alquilerFecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="alquilerFecha3">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Alimentación (Monto ₡)</label>
                        <input type="number" step="0.01" name="alimentacionMonto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="alimentacionFecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="alimentacionFecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="alimentacionFecha3">
                    </div>
                </div>
            </div>

            <!-- Gasto de Salud -->
            <div class="card">
                <h2 class="section-title">Gasto de Salud</h2>
                <p class="section-description">Gastos médicos y medicamentos</p>

                <div class="form-row">
                    <div class="form-group">
                        <label>Medicamento Mensual (Monto ₡)</label>
                        <input type="number" step="0.01" name="medicamentoMonto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="medicamentoFecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="medicamentoFecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="medicamentoFecha3">
                    </div>
                </div>
            </div>

            <!-- Otros Gastos -->
            <div class="card">
                <h2 class="section-title">Otros Gastos</h2>
                <p class="section-description">Gastos adicionales no contemplados arriba</p>

                <div class="form-group" style="margin-bottom: 1rem;">
                    <label>Nombre del Gasto 1</label>
                    <input type="text" name="otroGasto1Nombre" placeholder="Ej: Transporte, Educación, etc.">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Monto ₡</label>
                        <input type="number" step="0.01" name="otroGasto1Monto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="otroGasto1Fecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="otroGasto1Fecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="otroGasto1Fecha3">
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 1rem; margin-top: 1.5rem;">
                    <label>Nombre del Gasto 2</label>
                    <input type="text" name="otroGasto2Nombre" placeholder="Ej: Transporte, Educación, etc.">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Monto ₡</label>
                        <input type="number" step="0.01" name="otroGasto2Monto" placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="otroGasto2Fecha1">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="otroGasto2Fecha2">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="otroGasto2Fecha3">
                    </div>
                </div>
            </div>

            <!-- Observaciones y Recomendación -->
            <div class="card">
                <h2 class="section-title">Otras Observaciones y Recomendación</h2>
                
                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label>Otras observaciones determinadas al momento de la entrevista</label>
                    <textarea name="observaciones" placeholder="Describa cualquier información adicional relevante observada durante la entrevista..."></textarea>
                </div>

                <div class="form-group">
                    <label>¿De acuerdo a lo indagado y observado durante la entrevista, se recomienda la ayuda?</label>
                    <div class="radio-group">
                        <div class="radio-option">
                            <input type="radio" id="recomiendaSi" name="recomiendaAyuda" value="si" required>
                            <label for="recomiendaSi" style="margin: 0;">Sí</label>
                        </div>
                        <div class="radio-option">
                            <input type="radio" id="recomiendaNo" name="recomiendaAyuda" value="no" required>
                            <label for="recomiendaNo" style="margin: 0;">No</label>
                        </div>
                    </div>
                </div>

                <div class="form-group" style="margin-top: 1rem;">
                    <label>Fecha de Recomendación</label>
                    <input type="date" name="recomendacionFecha" style="max-width: 200px;">
                </div>
            </div>

            <!-- Botones -->
            <div class="btn-group">
                <a href="expediente-detalle.jsp?id=<%= idExpediente %>" class="btn btn-secondary" style="text-decoration: none; text-align: center; line-height: 1.5;">
                    Cancelar
                </a>
                <button type="submit" class="btn btn-primary">
                    Guardar Addendum
                </button>
            </div>
        </form>
    </div>
</body>
</html>