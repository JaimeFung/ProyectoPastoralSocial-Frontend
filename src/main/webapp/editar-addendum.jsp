<%-- 
    Document   : editar-addendum
    Created on : Dec 16, 2025
    Author     : Jaime
--%>

<%@page import="java.text.SimpleDateFormat"%>
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
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    String mensajeExito = null;
    String mensajeError = null;
    
    // Procesar formulario si es POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // Actualizar todos los campos del addendum
            
            // Electricidad
            String electricidadMonto = request.getParameter("electricidadMonto");
            if (electricidadMonto != null && !electricidadMonto.trim().isEmpty()) {
                addendum.setElectricidadMonto(Double.parseDouble(electricidadMonto));
            } else {
                addendum.setElectricidadMonto(null);
            }
            
            String electricidadFecha1 = request.getParameter("electricidadFecha1");
            if (electricidadFecha1 != null && !electricidadFecha1.trim().isEmpty()) {
                addendum.setElectricidadFecha1(sdf.parse(electricidadFecha1));
            } else {
                addendum.setElectricidadFecha1(null);
            }
            
            String electricidadFecha2 = request.getParameter("electricidadFecha2");
            if (electricidadFecha2 != null && !electricidadFecha2.trim().isEmpty()) {
                addendum.setElectricidadFecha2(sdf.parse(electricidadFecha2));
            } else {
                addendum.setElectricidadFecha2(null);
            }
            
            String electricidadFecha3 = request.getParameter("electricidadFecha3");
            if (electricidadFecha3 != null && !electricidadFecha3.trim().isEmpty()) {
                addendum.setElectricidadFecha3(sdf.parse(electricidadFecha3));
            } else {
                addendum.setElectricidadFecha3(null);
            }
            
            // Agua
            String aguaMonto = request.getParameter("aguaMonto");
            if (aguaMonto != null && !aguaMonto.trim().isEmpty()) {
                addendum.setAguaMonto(Double.parseDouble(aguaMonto));
            } else {
                addendum.setAguaMonto(null);
            }
            
            String aguaFecha1 = request.getParameter("aguaFecha1");
            if (aguaFecha1 != null && !aguaFecha1.trim().isEmpty()) {
                addendum.setAguaFecha1(sdf.parse(aguaFecha1));
            } else {
                addendum.setAguaFecha1(null);
            }
            
            String aguaFecha2 = request.getParameter("aguaFecha2");
            if (aguaFecha2 != null && !aguaFecha2.trim().isEmpty()) {
                addendum.setAguaFecha2(sdf.parse(aguaFecha2));
            } else {
                addendum.setAguaFecha2(null);
            }
            
            String aguaFecha3 = request.getParameter("aguaFecha3");
            if (aguaFecha3 != null && !aguaFecha3.trim().isEmpty()) {
                addendum.setAguaFecha3(sdf.parse(aguaFecha3));
            } else {
                addendum.setAguaFecha3(null);
            }
            
            // Teléfono
            String telefonoMonto = request.getParameter("telefonoMonto");
            if (telefonoMonto != null && !telefonoMonto.trim().isEmpty()) {
                addendum.setTelefonoMonto(Double.parseDouble(telefonoMonto));
            } else {
                addendum.setTelefonoMonto(null);
            }
            
            String telefonoFecha1 = request.getParameter("telefonoFecha1");
            if (telefonoFecha1 != null && !telefonoFecha1.trim().isEmpty()) {
                addendum.setTelefonoFecha1(sdf.parse(telefonoFecha1));
            } else {
                addendum.setTelefonoFecha1(null);
            }
            
            String telefonoFecha2 = request.getParameter("telefonoFecha2");
            if (telefonoFecha2 != null && !telefonoFecha2.trim().isEmpty()) {
                addendum.setTelefonoFecha2(sdf.parse(telefonoFecha2));
            } else {
                addendum.setTelefonoFecha2(null);
            }
            
            String telefonoFecha3 = request.getParameter("telefonoFecha3");
            if (telefonoFecha3 != null && !telefonoFecha3.trim().isEmpty()) {
                addendum.setTelefonoFecha3(sdf.parse(telefonoFecha3));
            } else {
                addendum.setTelefonoFecha3(null);
            }
            
            // Internet
            String internetMonto = request.getParameter("internetMonto");
            if (internetMonto != null && !internetMonto.trim().isEmpty()) {
                addendum.setInternetMonto(Double.parseDouble(internetMonto));
            } else {
                addendum.setInternetMonto(null);
            }
            
            String internetFecha1 = request.getParameter("internetFecha1");
            if (internetFecha1 != null && !internetFecha1.trim().isEmpty()) {
                addendum.setInternetFecha1(sdf.parse(internetFecha1));
            } else {
                addendum.setInternetFecha1(null);
            }
            
            String internetFecha2 = request.getParameter("internetFecha2");
            if (internetFecha2 != null && !internetFecha2.trim().isEmpty()) {
                addendum.setInternetFecha2(sdf.parse(internetFecha2));
            } else {
                addendum.setInternetFecha2(null);
            }
            
            String internetFecha3 = request.getParameter("internetFecha3");
            if (internetFecha3 != null && !internetFecha3.trim().isEmpty()) {
                addendum.setInternetFecha3(sdf.parse(internetFecha3));
            } else {
                addendum.setInternetFecha3(null);
            }
            
            // Cable
            String cableMonto = request.getParameter("cableMonto");
            if (cableMonto != null && !cableMonto.trim().isEmpty()) {
                addendum.setCableMonto(Double.parseDouble(cableMonto));
            } else {
                addendum.setCableMonto(null);
            }
            
            String cableFecha1 = request.getParameter("cableFecha1");
            if (cableFecha1 != null && !cableFecha1.trim().isEmpty()) {
                addendum.setCableFecha1(sdf.parse(cableFecha1));
            } else {
                addendum.setCableFecha1(null);
            }
            
            String cableFecha2 = request.getParameter("cableFecha2");
            if (cableFecha2 != null && !cableFecha2.trim().isEmpty()) {
                addendum.setCableFecha2(sdf.parse(cableFecha2));
            } else {
                addendum.setCableFecha2(null);
            }
            
            String cableFecha3 = request.getParameter("cableFecha3");
            if (cableFecha3 != null && !cableFecha3.trim().isEmpty()) {
                addendum.setCableFecha3(sdf.parse(cableFecha3));
            } else {
                addendum.setCableFecha3(null);
            }
            
            // Alquiler
            String alquilerMonto = request.getParameter("alquilerMonto");
            if (alquilerMonto != null && !alquilerMonto.trim().isEmpty()) {
                addendum.setAlquilerMonto(Double.parseDouble(alquilerMonto));
            } else {
                addendum.setAlquilerMonto(null);
            }
            
            String alquilerFecha1 = request.getParameter("alquilerFecha1");
            if (alquilerFecha1 != null && !alquilerFecha1.trim().isEmpty()) {
                addendum.setAlquilerFecha1(sdf.parse(alquilerFecha1));
            } else {
                addendum.setAlquilerFecha1(null);
            }
            
            String alquilerFecha2 = request.getParameter("alquilerFecha2");
            if (alquilerFecha2 != null && !alquilerFecha2.trim().isEmpty()) {
                addendum.setAlquilerFecha2(sdf.parse(alquilerFecha2));
            } else {
                addendum.setAlquilerFecha2(null);
            }
            
            String alquilerFecha3 = request.getParameter("alquilerFecha3");
            if (alquilerFecha3 != null && !alquilerFecha3.trim().isEmpty()) {
                addendum.setAlquilerFecha3(sdf.parse(alquilerFecha3));
            } else {
                addendum.setAlquilerFecha3(null);
            }
            
            // Alimentación
            String alimentacionMonto = request.getParameter("alimentacionMonto");
            if (alimentacionMonto != null && !alimentacionMonto.trim().isEmpty()) {
                addendum.setAlimentacionMonto(Double.parseDouble(alimentacionMonto));
            } else {
                addendum.setAlimentacionMonto(null);
            }
            
            String alimentacionFecha1 = request.getParameter("alimentacionFecha1");
            if (alimentacionFecha1 != null && !alimentacionFecha1.trim().isEmpty()) {
                addendum.setAlimentacionFecha1(sdf.parse(alimentacionFecha1));
            } else {
                addendum.setAlimentacionFecha1(null);
            }
            
            String alimentacionFecha2 = request.getParameter("alimentacionFecha2");
            if (alimentacionFecha2 != null && !alimentacionFecha2.trim().isEmpty()) {
                addendum.setAlimentacionFecha2(sdf.parse(alimentacionFecha2));
            } else {
                addendum.setAlimentacionFecha2(null);
            }
            
            String alimentacionFecha3 = request.getParameter("alimentacionFecha3");
            if (alimentacionFecha3 != null && !alimentacionFecha3.trim().isEmpty()) {
                addendum.setAlimentacionFecha3(sdf.parse(alimentacionFecha3));
            } else {
                addendum.setAlimentacionFecha3(null);
            }
            
            // Medicamento
            String medicamentoMonto = request.getParameter("medicamentoMonto");
            if (medicamentoMonto != null && !medicamentoMonto.trim().isEmpty()) {
                addendum.setMedicamentoMonto(Double.parseDouble(medicamentoMonto));
            } else {
                addendum.setMedicamentoMonto(null);
            }
            
            String medicamentoFecha1 = request.getParameter("medicamentoFecha1");
            if (medicamentoFecha1 != null && !medicamentoFecha1.trim().isEmpty()) {
                addendum.setMedicamentoFecha1(sdf.parse(medicamentoFecha1));
            } else {
                addendum.setMedicamentoFecha1(null);
            }
            
            String medicamentoFecha2 = request.getParameter("medicamentoFecha2");
            if (medicamentoFecha2 != null && !medicamentoFecha2.trim().isEmpty()) {
                addendum.setMedicamentoFecha2(sdf.parse(medicamentoFecha2));
            } else {
                addendum.setMedicamentoFecha2(null);
            }
            
            String medicamentoFecha3 = request.getParameter("medicamentoFecha3");
            if (medicamentoFecha3 != null && !medicamentoFecha3.trim().isEmpty()) {
                addendum.setMedicamentoFecha3(sdf.parse(medicamentoFecha3));
            } else {
                addendum.setMedicamentoFecha3(null);
            }
            
            // Otros gastos
            addendum.setOtroGasto1Nombre(request.getParameter("otroGasto1Nombre"));
            
            String otroGasto1Monto = request.getParameter("otroGasto1Monto");
            if (otroGasto1Monto != null && !otroGasto1Monto.trim().isEmpty()) {
                addendum.setOtroGasto1Monto(Double.parseDouble(otroGasto1Monto));
            } else {
                addendum.setOtroGasto1Monto(null);
            }
            
            String otroGasto1Fecha1 = request.getParameter("otroGasto1Fecha1");
            if (otroGasto1Fecha1 != null && !otroGasto1Fecha1.trim().isEmpty()) {
                addendum.setOtroGasto1Fecha1(sdf.parse(otroGasto1Fecha1));
            } else {
                addendum.setOtroGasto1Fecha1(null);
            }
            
            String otroGasto1Fecha2 = request.getParameter("otroGasto1Fecha2");
            if (otroGasto1Fecha2 != null && !otroGasto1Fecha2.trim().isEmpty()) {
                addendum.setOtroGasto1Fecha2(sdf.parse(otroGasto1Fecha2));
            } else {
                addendum.setOtroGasto1Fecha2(null);
            }
            
            String otroGasto1Fecha3 = request.getParameter("otroGasto1Fecha3");
            if (otroGasto1Fecha3 != null && !otroGasto1Fecha3.trim().isEmpty()) {
                addendum.setOtroGasto1Fecha3(sdf.parse(otroGasto1Fecha3));
            } else {
                addendum.setOtroGasto1Fecha3(null);
            }
            
            addendum.setOtroGasto2Nombre(request.getParameter("otroGasto2Nombre"));
            
            String otroGasto2Monto = request.getParameter("otroGasto2Monto");
            if (otroGasto2Monto != null && !otroGasto2Monto.trim().isEmpty()) {
                addendum.setOtroGasto2Monto(Double.parseDouble(otroGasto2Monto));
            } else {
                addendum.setOtroGasto2Monto(null);
            }
            
            String otroGasto2Fecha1 = request.getParameter("otroGasto2Fecha1");
            if (otroGasto2Fecha1 != null && !otroGasto2Fecha1.trim().isEmpty()) {
                addendum.setOtroGasto2Fecha1(sdf.parse(otroGasto2Fecha1));
            } else {
                addendum.setOtroGasto2Fecha1(null);
            }
            
            String otroGasto2Fecha2 = request.getParameter("otroGasto2Fecha2");
            if (otroGasto2Fecha2 != null && !otroGasto2Fecha2.trim().isEmpty()) {
                addendum.setOtroGasto2Fecha2(sdf.parse(otroGasto2Fecha2));
            } else {
                addendum.setOtroGasto2Fecha2(null);
            }
            
            String otroGasto2Fecha3 = request.getParameter("otroGasto2Fecha3");
            if (otroGasto2Fecha3 != null && !otroGasto2Fecha3.trim().isEmpty()) {
                addendum.setOtroGasto2Fecha3(sdf.parse(otroGasto2Fecha3));
            } else {
                addendum.setOtroGasto2Fecha3(null);
            }
            
            // Observaciones y recomendación
            addendum.setObservaciones(request.getParameter("observaciones"));
            addendum.setRecomiendaAyuda("si".equalsIgnoreCase(request.getParameter("recomiendaAyuda")));
            
            String recomendacionFecha = request.getParameter("recomendacionFecha");
            if (recomendacionFecha != null && !recomendacionFecha.trim().isEmpty()) {
                addendum.setRecomendacionFecha(sdf.parse(recomendacionFecha));
            } else {
                addendum.setRecomendacionFecha(null);
            }
            
            // Actualizar addendum
            Addendum actualizado = addendumController.actualizarAddendum(addendum);
            
            if (actualizado != null) {
                response.sendRedirect("expediente-detalle.jsp?id=" + expediente.getIdExpediente());
                return;
            } else {
                mensajeError = "Error al actualizar el addendum. Intente nuevamente.";
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
    <title>Editar Addendum - Sistema Pastoral Social</title>
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
            <h1 class="page-title">Editar Addendum</h1>
            <p class="page-subtitle">
                Expediente <%= familia.getNumeroExpediente() %> - <%= familia.getNombreJefeFamilia()%>
            </p>
            <p class="page-subtitle">
                Registrado: <%= sdf.format(addendum.getFechaRegistro()) %>
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
                <p class="section-description">Actualice los montos y fechas de pago de los servicios básicos</p>

                <div class="form-row">
                    
                    <div class="form-group">
                        <label>Electricidad (Monto ₡)</label>
                        <input type="number" step="0.01" name="electricidadMonto" 
                               value="<%= addendum.getElectricidadMonto() != null ? addendum.getElectricidadMonto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="electricidadFecha1" 
                               value="<%= addendum.getElectricidadFecha1() != null ? sdf.format(addendum.getElectricidadFecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="electricidadFecha2" 
                               value="<%= addendum.getElectricidadFecha2() != null ? sdf.format(addendum.getElectricidadFecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="electricidadFecha3" 
                               value="<%= addendum.getElectricidadFecha3() != null ? sdf.format(addendum.getElectricidadFecha3()) : "" %>">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Agua (Monto ₡)</label>
                        <input type="number" step="0.01" name="aguaMonto" 
                               value="<%= addendum.getAguaMonto() != null ? addendum.getAguaMonto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="aguaFecha1" 
                               value="<%= addendum.getAguaFecha1() != null ? sdf.format(addendum.getAguaFecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="aguaFecha2" 
                               value="<%= addendum.getAguaFecha2() != null ? sdf.format(addendum.getAguaFecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="aguaFecha3" 
                               value="<%= addendum.getAguaFecha3() != null ? sdf.format(addendum.getAguaFecha3()) : "" %>">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Teléfono (Monto ₡)</label>
                        <input type="number" step="0.01" name="telefonoMonto" 
                               value="<%= addendum.getTelefonoMonto() != null ? addendum.getTelefonoMonto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="telefonoFecha1" 
                               value="<%= addendum.getTelefonoFecha1() != null ? sdf.format(addendum.getTelefonoFecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="telefonoFecha2" 
                               value="<%= addendum.getTelefonoFecha2() != null ? sdf.format(addendum.getTelefonoFecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="telefonoFecha3" 
                               value="<%= addendum.getTelefonoFecha3() != null ? sdf.format(addendum.getTelefonoFecha3()) : "" %>">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Internet (Monto ₡)</label>
                        <input type="number" step="0.01" name="internetMonto" 
                               value="<%= addendum.getInternetMonto() != null ? addendum.getInternetMonto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="internetFecha1" 
                               value="<%= addendum.getInternetFecha1() != null ? sdf.format(addendum.getInternetFecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="internetFecha2" 
                               value="<%= addendum.getInternetFecha2() != null ? sdf.format(addendum.getInternetFecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="internetFecha3" 
                               value="<%= addendum.getInternetFecha3() != null ? sdf.format(addendum.getInternetFecha3()) : "" %>">
                    </div>
                    
                    
                    
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Cable (Monto ₡)</label>
                        <input type="number" step="0.01" name="cableMonto" 
                               value="<%= addendum.getCableMonto() != null ? addendum.getCableMonto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="cableFecha1" 
                               value="<%= addendum.getCableFecha1() != null ? sdf.format(addendum.getCableFecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="cableFecha2" 
                               value="<%= addendum.getCableFecha2() != null ? sdf.format(addendum.getCableFecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="cableFecha3" 
                               value="<%= addendum.getCableFecha3() != null ? sdf.format(addendum.getCableFecha3()) : "" %>">
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
                        <input type="number" step="0.01" name="alquilerMonto" 
                               value="<%= addendum.getAlquilerMonto() != null ? addendum.getAlquilerMonto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="alquilerFecha1" 
                               value="<%= addendum.getAlquilerFecha1() != null ? sdf.format(addendum.getAlquilerFecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="alquilerFecha2" 
                               value="<%= addendum.getAlquilerFecha2() != null ? sdf.format(addendum.getAlquilerFecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="alquilerFecha3" 
                               value="<%= addendum.getAlquilerFecha3() != null ? sdf.format(addendum.getAlquilerFecha3()) : "" %>">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Alimentación (Monto ₡)</label>
                        <input type="number" step="0.01" name="alimentacionMonto" 
                               value="<%= addendum.getAlimentacionMonto() != null ? addendum.getAlimentacionMonto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="alimentacionFecha1" 
                               value="<%= addendum.getAlimentacionFecha1() != null ? sdf.format(addendum.getAlimentacionFecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="alimentacionFecha2" 
                               value="<%= addendum.getAlimentacionFecha2() != null ? sdf.format(addendum.getAlimentacionFecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="alimentacionFecha3" 
                               value="<%= addendum.getAlimentacionFecha3() != null ? sdf.format(addendum.getAlimentacionFecha3()) : "" %>">
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
                        <input type="number" step="0.01" name="medicamentoMonto" 
                               value="<%= addendum.getMedicamentoMonto() != null ? addendum.getMedicamentoMonto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="medicamentoFecha1" 
                               value="<%= addendum.getMedicamentoFecha1() != null ? sdf.format(addendum.getMedicamentoFecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="medicamentoFecha2" 
                               value="<%= addendum.getMedicamentoFecha2() != null ? sdf.format(addendum.getMedicamentoFecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="medicamentoFecha3" 
                               value="<%= addendum.getMedicamentoFecha3() != null ? sdf.format(addendum.getMedicamentoFecha3()) : "" %>">
                    </div>
                </div>
            </div>

            <!-- Otros Gastos -->
            <div class="card">
                <h2 class="section-title">Otros Gastos</h2>
                <p class="section-description">Gastos adicionales no contemplados arriba</p>

                <div class="form-group" style="margin-bottom: 1rem;">
                    <label>Nombre del Gasto 1</label>
                    <input type="text" name="otroGasto1Nombre" 
                           value="<%= addendum.getOtroGasto1Nombre() != null ? addendum.getOtroGasto1Nombre() : "" %>"
                           placeholder="Ej: Transporte, Educación, etc.">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Monto ₡</label>
                        <input type="number" step="0.01" name="otroGasto1Monto" 
                               value="<%= addendum.getOtroGasto1Monto() != null ? addendum.getOtroGasto1Monto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="otroGasto1Fecha1" 
                               value="<%= addendum.getOtroGasto1Fecha1() != null ? sdf.format(addendum.getOtroGasto1Fecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="otroGasto1Fecha2" 
                               value="<%= addendum.getOtroGasto1Fecha2() != null ? sdf.format(addendum.getOtroGasto1Fecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="otroGasto1Fecha3" 
                               value="<%= addendum.getOtroGasto1Fecha3() != null ? sdf.format(addendum.getOtroGasto1Fecha3()) : "" %>">
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 1rem; margin-top: 1.5rem;">
                    <label>Nombre del Gasto 2</label>
                    <input type="text" name="otroGasto2Nombre" 
                           value="<%= addendum.getOtroGasto2Nombre() != null ? addendum.getOtroGasto2Nombre() : "" %>"
                           placeholder="Ej: Transporte, Educación, etc.">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Monto ₡</label>
                        <input type="number" step="0.01" name="otroGasto2Monto" 
                               value="<%= addendum.getOtroGasto2Monto() != null ? addendum.getOtroGasto2Monto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 1</label>
                        <input type="date" name="otroGasto2Fecha1" 
                               value="<%= addendum.getOtroGasto2Fecha1() != null ? sdf.format(addendum.getOtroGasto2Fecha1()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 2</label>
                        <input type="date" name="otroGasto2Fecha2" 
                               value="<%= addendum.getOtroGasto2Fecha2() != null ? sdf.format(addendum.getOtroGasto2Fecha2()) : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Fecha 3</label>
                        <input type="date" name="otroGasto2Fecha3" 
                               value="<%= addendum.getOtroGasto2Fecha3() != null ? sdf.format(addendum.getOtroGasto2Fecha3()) : "" %>">
                    </div>
                </div>
            </div>

            <!-- Observaciones y Recomendación -->
            <div class="card">
                <h2 class="section-title">Otras Observaciones y Recomendación</h2>
                
                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label>Otras observaciones determinadas al momento de la entrevista</label>
                    <textarea name="observaciones"><%= addendum.getObservaciones() != null ? addendum.getObservaciones() : "" %></textarea>
                </div>

                <div class="form-group">
                    <label>¿De acuerdo a lo indagado y observado durante la entrevista, se recomienda la ayuda?</label>
                    <div class="radio-group">
                        <div class="radio-option">
                            <input type="radio" id="recomiendaSi" name="recomiendaAyuda" value="si" 
                                   <%= addendum.getRecomiendaAyuda() != null && addendum.getRecomiendaAyuda() ? "checked" : "" %> required>
                            <label for="recomiendaSi" style="margin: 0;">Sí</label>
                        </div>
                        <div class="radio-option">
                            <input type="radio" id="recomiendaNo" name="recomiendaAyuda" value="no" 
                                   <%= addendum.getRecomiendaAyuda() == null || !addendum.getRecomiendaAyuda() ? "checked" : "" %> required>
                            <label for="recomiendaNo" style="margin: 0;">No</label>
                        </div>
                    </div>
                </div>

                <div class="form-group" style="margin-top: 1rem;">
                    <label>Fecha de Recomendación</label>
                    <input type="date" name="recomendacionFecha" style="max-width: 200px;"
                           value="<%= addendum.getRecomendacionFecha() != null ? sdf.format(addendum.getRecomendacionFecha()) : "" %>">
                </div>
            </div>

            <!-- Botones -->
            <div class="btn-group">
                <a href="expediente-detalle.jsp?id=<%= expediente.getIdExpediente() %>" class="btn btn-secondary" style="text-decoration: none; text-align: center; line-height: 1.5;">
                    Cancelar
                </a>
                <button type="submit" class="btn btn-primary">
                    Actualizar Addendum
                </button>
            </div>
        </form>
    </div>
</body>
</html>