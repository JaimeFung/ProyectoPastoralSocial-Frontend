<%-- 
    Document   : ver-addendum
    Created on : Dec 16, 2025
    Author     : Jaime
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="edu.ulatina.controller.*"%>
<%@page import="edu.ulatina.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Obtener el ID del addendum
    String idAddendumStr = request.getParameter("id");
    
    if (idAddendumStr == null || idAddendumStr.trim().isEmpty()) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    Integer idAddendum = Integer.parseInt(idAddendumStr);
    
    // Cargar el addendum
    AddendumController addendumController = new AddendumController();
    Addendum addendum = addendumController.buscarPorId(idAddendum);
    
    if (addendum == null) {
        response.sendRedirect("expedientes.jsp");
        return;
    }
    
    Expediente expediente = addendum.getExpediente();
    Familia familia = expediente.getFamilia();
    
    // Formatear fechas y montos
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    NumberFormat moneyFormat = NumberFormat.getCurrencyInstance(new Locale("es", "CR"));
    
    
    
%>




<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ver Addendum - Sistema Pastoral Social</title>
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
            margin-bottom: 0.8rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--color-border);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th,
        .data-table td {
            padding: 0.6rem;
            text-align: left;
            border-bottom: 1px solid #E5E7EB;
            font-size: 0.875rem;
        }

        .data-table th {
            background: #F9FAFB;
            font-weight: 600;
            color: #4B5563;
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-row {
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 1rem;
            padding: 0.5rem 0;
            border-bottom: 1px solid #F3F4F6;
        }

        .data-label {
            font-weight: 600;
            color: #4B5563;
            font-size: 0.875rem;
        }

        .data-value {
            color: var(--color-text);
            font-size: 0.875rem;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            padding: 0.65rem 1.3rem;
            border-radius: 999px;
            border: none;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: var(--color-primary);
            color: #FFFFFF;
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.25);
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

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-yes {
            background: #DCFCE7;
            color: #166534;
            border: 1px solid #BBF7D0;
        }

        .status-no {
            background: #FEE2E2;
            color: #DC2626;
            border: 1px solid #FECACA;
        }

        @media (max-width: 768px) {
            .data-row {
                grid-template-columns: 1fr;
                gap: 0.25rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Addendum al Expediente</h1>
            <p class="page-subtitle">
                Expediente <%= familia.getNumeroExpediente() %> - <%= familia.getNombreJefeFamilia()%>
            </p>
            <p class="page-subtitle">
                Registrado: <%= sdf.format(addendum.getFechaRegistro()) %>
            </p>
        </div>

        <!-- Servicios Públicos -->
        <div class="card">
            <h2 class="section-title">Servicios Públicos</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Servicio</th>
                        <th>Monto</th>
                        <th>Fecha 1</th>
                        <th>Fecha 2</th>
                        <th>Fecha 3</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Electricidad</strong></td>
                        <td><%= formatMonto(addendum.getElectricidadMonto()) %></td>
                        <td><%= formatFecha(addendum.getElectricidadFecha1()) %></td>
                        <td><%= formatFecha(addendum.getElectricidadFecha2()) %></td>
                        <td><%= formatFecha(addendum.getElectricidadFecha3()) %></td>
                    </tr>
                    <tr>
                        <td><strong>Agua</strong></td>
                        <td><%= formatMonto(addendum.getAguaMonto()) %></td>
                        <td><%= formatFecha(addendum.getAguaFecha1()) %></td>
                        <td><%= formatFecha(addendum.getAguaFecha2()) %></td>
                        <td><%= formatFecha(addendum.getAguaFecha3()) %></td>
                    </tr>
                    <tr>
                        <td><strong>Teléfono</strong></td>
                        <td><%= formatMonto(addendum.getTelefonoMonto()) %></td>
                        <td><%= formatFecha(addendum.getTelefonoFecha1()) %></td>
                        <td><%= formatFecha(addendum.getTelefonoFecha2()) %></td>
                        <td><%= formatFecha(addendum.getTelefonoFecha3()) %></td>
                    </tr>
                    <tr>
                        <td><strong>Internet</strong></td>
                        <td><%= formatMonto(addendum.getInternetMonto()) %></td>
                        <td><%= formatFecha(addendum.getInternetFecha1()) %></td>
                        <td><%= formatFecha(addendum.getInternetFecha2()) %></td>
                        <td><%= formatFecha(addendum.getInternetFecha3()) %></td>
                    </tr>
                    <tr>
                        <td><strong>Cable</strong></td>
                        <td><%= formatMonto(addendum.getCableMonto()) %></td>
                        <td><%= formatFecha(addendum.getCableFecha1()) %></td>
                        <td><%= formatFecha(addendum.getCableFecha2()) %></td>
                        <td><%= formatFecha(addendum.getCableFecha3()) %></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Gasto de Vivienda -->
        <div class="card">
            <h2 class="section-title">Gasto de Vivienda</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Concepto</th>
                        <th>Monto</th>
                        <th>Fecha 1</th>
                        <th>Fecha 2</th>
                        <th>Fecha 3</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Alquiler o Préstamo</strong></td>
                        <td><%= formatMonto(addendum.getAlquilerMonto()) %></td>
                        <td><%= formatFecha(addendum.getAlquilerFecha1()) %></td>
                        <td><%= formatFecha(addendum.getAlquilerFecha2()) %></td>
                        <td><%= formatFecha(addendum.getAlquilerFecha3()) %></td>
                    </tr>
                    <tr>
                        <td><strong>Alimentación</strong></td>
                        <td><%= formatMonto(addendum.getAlimentacionMonto()) %></td>
                        <td><%= formatFecha(addendum.getAlimentacionFecha1()) %></td>
                        <td><%= formatFecha(addendum.getAlimentacionFecha2()) %></td>
                        <td><%= formatFecha(addendum.getAlimentacionFecha3()) %></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Gasto de Salud -->
        <div class="card">
            <h2 class="section-title">Gasto de Salud</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Concepto</th>
                        <th>Monto</th>
                        <th>Fecha 1</th>
                        <th>Fecha 2</th>
                        <th>Fecha 3</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Medicamento Mensual</strong></td>
                        <td><%= formatMonto(addendum.getMedicamentoMonto()) %></td>
                        <td><%= formatFecha(addendum.getMedicamentoFecha1()) %></td>
                        <td><%= formatFecha(addendum.getMedicamentoFecha2()) %></td>
                        <td><%= formatFecha(addendum.getMedicamentoFecha3()) %></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Otros Gastos -->
        <% if ((addendum.getOtroGasto1Nombre() != null && !addendum.getOtroGasto1Nombre().trim().isEmpty()) || 
               (addendum.getOtroGasto2Nombre() != null && !addendum.getOtroGasto2Nombre().trim().isEmpty())) { %>
        <div class="card">
            <h2 class="section-title">Otros Gastos</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Concepto</th>
                        <th>Monto</th>
                        <th>Fecha 1</th>
                        <th>Fecha 2</th>
                        <th>Fecha 3</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (addendum.getOtroGasto1Nombre() != null && !addendum.getOtroGasto1Nombre().trim().isEmpty()) { %>
                    <tr>
                        <td><strong><%= addendum.getOtroGasto1Nombre() %></strong></td>
                        <td><%= formatMonto(addendum.getOtroGasto1Monto()) %></td>
                        <td><%= formatFecha(addendum.getOtroGasto1Fecha1()) %></td>
                        <td><%= formatFecha(addendum.getOtroGasto1Fecha2()) %></td>
                        <td><%= formatFecha(addendum.getOtroGasto1Fecha3()) %></td>
                    </tr>
                    <% } %>
                    <% if (addendum.getOtroGasto2Nombre() != null && !addendum.getOtroGasto2Nombre().trim().isEmpty()) { %>
                    <tr>
                        <td><strong><%= addendum.getOtroGasto2Nombre() %></strong></td>
                        <td><%= formatMonto(addendum.getOtroGasto2Monto()) %></td>
                        <td><%= formatFecha(addendum.getOtroGasto2Fecha1()) %></td>
                        <td><%= formatFecha(addendum.getOtroGasto2Fecha2()) %></td>
                        <td><%= formatFecha(addendum.getOtroGasto2Fecha3()) %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } %>

        <!-- Observaciones y Recomendación -->
        <div class="card">
            <h2 class="section-title">Observaciones y Recomendación</h2>
            
            <% if (addendum.getObservaciones() != null && !addendum.getObservaciones().trim().isEmpty()) { %>
            <div class="data-row">
                <div class="data-label">Observaciones:</div>
                <div class="data-value"><%= addendum.getObservaciones() %></div>
            </div>
            <% } %>
            
            <div class="data-row">
                <div class="data-label">¿Se recomienda la ayuda?</div>
                <div class="data-value">
                    <% if (addendum.getRecomiendaAyuda() != null && addendum.getRecomiendaAyuda()) { %>
                        <span class="status-badge status-yes">SÍ</span>
                    <% } else { %>
                        <span class="status-badge status-no">NO</span>
                    <% } %>
                </div>
            </div>
            
            <% if (addendum.getRecomendacionFecha() != null) { %>
            <div class="data-row">
                <div class="data-label">Fecha de Recomendación:</div>
                <div class="data-value"><%= sdf.format(addendum.getRecomendacionFecha()) %></div>
            </div>
            <% } %>
        </div>

        <!-- Botones de Acción -->
        <div class="btn-group">
            <a href="expediente-detalle.jsp?id=<%= expediente.getIdExpediente() %>" class="btn btn-secondary">
                Volver al Expediente
            </a>
            <a href="editar-addendum.jsp?id=<%= addendum.getIdAddendum() %>" class="btn btn-primary">
                Editar Addendum
            </a>
        </div>
    </div>

    <%!
        // Métodos helper para formatear
        String formatMonto(Double monto) {
            if (monto == null) return "-";
            NumberFormat moneyFormat = NumberFormat.getCurrencyInstance(new Locale("es", "CR"));
            return moneyFormat.format(monto);
        }
        
        String formatFecha(java.util.Date fecha) {
            if (fecha == null) return "-";
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            return sdf.format(fecha);
        }
    %>
</body>
</html>