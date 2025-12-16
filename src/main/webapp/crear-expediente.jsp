<%-- 
    Document   : crear-expediente
    Created on : Dec 15, 2025, 5:15:44 PM
    Author     : Jaime
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Crear Expediente - Sistema Pastoral Social</title>
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

            .logo::before, .logo::after {
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

            .nav-item.active:hover {
                background: var(--color-primary-dark);
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
                max-width: 1100px;
                margin: 0 auto;
                padding: 2rem 1.5rem 2.3rem;
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
                transition: background-color 0.2s ease, box-shadow 0.2s ease, transform
                    0.1s ease;
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

            .back-btn:active {
                transform: translateY(0);
                box-shadow: 0 6px 14px rgba(15, 23, 42, 0.12);
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
                align-items: center;
                gap: 0.5rem;
                margin-bottom: 0.4rem;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #111827;
            }

            .card-description {
                font-size: 0.88rem;
                color: var(--color-muted);
                margin-bottom: 1.2rem;
            }

            .form-row {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 1rem;
                margin-bottom: 0.6rem;
            }

            .form-row-2 {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 1rem;
                margin-bottom: 0.6rem;
            }

            .form-group {
                margin-bottom: 0.9rem;
            }

            label {
                display: block;
                font-size: 0.85rem;
                font-weight: 500;
                color: #374151;
                margin-bottom: 0.45rem;
            }

            input, select, textarea {
                width: 100%;
                padding: 0.55rem 0.9rem;
                border: 1px solid #D1D5DB;
                border-radius: 10px;
                font-size: 0.87rem;
                font-family: inherit;
                background: #FDFBF7;
                transition: border-color 0.2s ease, box-shadow 0.2s ease,
                    background-color 0.2s ease;
            }

            input:focus, select:focus, textarea:focus {
                outline: none;
                border-color: var(--color-primary);
                box-shadow: 0 0 0 2px rgba(35, 65, 90, 0.16);
                background: #FFFFFF;
            }

            textarea {
                resize: vertical;
            }

            .btn-group {
                display: flex;
                gap: 1rem;
                margin-top: 1.6rem;
            }

            .btn {
                flex: 1;
                padding: 0.7rem 1rem;
                border-radius: 999px;
                border: none;
                font-size: 0.9rem;
                font-weight: 500;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.45rem;
                transition: background-color 0.2s ease, color 0.2s ease, box-shadow 0.2s
                    ease, transform 0.1s ease;
            }

            .btn-primary {
                background: var(--color-primary);
                color: #FFFFFF;
                box-shadow: 0 10px 22px rgba(15, 23, 42, 0.25);
            }

            .btn-primary:hover {
                background: var(--color-primary-dark);
                box-shadow: 0 13px 26px rgba(15, 23, 42, 0.3);
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

            @media ( max-width : 768px) {
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
                .form-row, .form-row-2 {
                    grid-template-columns: 1fr;
                }
            }
        </style>

    </head>
    <body>
        <aside class="sidebar">
            <div class="logo-container">
                <div class="logo"></div>
                <div class="brand-text">
                    <h1>Pastoral Social</h1>
                    <p>Diócesis de Cartago</p>
                </div>
            </div>

            <nav class="nav-menu">
                <a href="dashboard.jsp" class="nav-item"> <span>Panel principal</span>
                </a> <a href="expedientes.jsp" class="nav-item active"> <span>Expedientes</span>
                </a>
            </nav>
        </aside>

        <div class="main-content">
            <header class="top-navbar">

                <div class="nav-actions">
                    <a href="usuarios.jsp">Configurar cuenta</a>
                    <a href="login.jsp">Cerrar sesión</a>
                </div>
            </header>

            <div class="container">
                <div class="page-header">
                    <button class="back-btn"
                            onclick="window.location.href = 'expedientes.jsp'">Volver</button>
                    <div>
                        <h1 class="page-title">Crear Nuevo Expediente</h1>
                        <p class="page-subtitle">Registro de beneficiario</p>
                    </div>
                </div>

                <form action="expedientes.jsp" method="post">
                    <!-- Información Personal -->
                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">Información Personal</h2>
                        </div>
                        <p class="card-description">Datos personales del beneficiario</p>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="nombre">Nombre</label> <input type="text" id="nombre"
                                                                          name="nombre" placeholder="Nombre" required>
                            </div>
                            <div class="form-group">
                                <label for="primerApellido">Primer Apellido</label> <input
                                    type="text" id="primerApellido" name="primerApellido"
                                    placeholder="Primer Apellido" required>
                            </div>
                            <div class="form-group">
                                <label for="segundoApellido">Segundo Apellido</label> <input
                                    type="text" id="segundoApellido" name="segundoApellido"
                                    placeholder="Segundo Apellido" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="cedula">Cédula</label> <input type="text" id="cedula"
                                                                          name="cedula" placeholder="1-0234-0567" required>
                            </div>
                            <div class="form-group">
                                <label for="fechaNacimiento">Fecha de Nacimiento</label> <input
                                    type="date" id="fechaNacimiento" name="fechaNacimiento" required>
                            </div>
                            <div class="form-group">
                                <label for="genero">Género</label> <select id="genero"
                                                                           name="genero" required>
                                    <option value="">Seleccione</option>
                                    <option value="masculino">Masculino</option>
                                    <option value="femenino">Femenino</option>
                                    <option value="otro">Otro</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="estadoCivil">Estado Civil</label> <select
                                    id="estadoCivil" name="estadoCivil" required>
                                    <option value="">Seleccione</option>
                                    <option value="soltero">Soltero(a)</option>
                                    <option value="casado">Casado(a)</option>
                                    <option value="union-libre">Unión Libre</option>
                                    <option value="divorciado">Divorciado(a)</option>
                                    <option value="viudo">Viudo(a)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="telefono">Teléfono</label> <input type="tel"
                                                                              id="telefono" name="telefono" placeholder="8888-8888" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Correo Electrónico</label> <input type="email"
                                                                                     id="email" name="email" placeholder="correo@ejemplo.com">
                            </div>
                        </div>
                    </div>

                    <!-- Información de Vivienda -->
                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">Información de Vivienda</h2>
                        </div>
                        <p class="card-description">Dirección y datos de residencia</p>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="provincia">Provincia</label> <select id="provincia"
                                                                                 name="provincia" required>
                                    <option value="">Seleccione</option>
                                    <option value="cartago">Cartago</option>
                                    <option value="san-jose">San José</option>
                                    <option value="alajuela">Alajuela</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="canton">Cantón</label> <input type="text" id="canton"
                                                                          name="canton" placeholder="Cantón" required>
                            </div>
                            <div class="form-group">
                                <label for="distrito">Distrito</label> <input type="text"
                                                                              id="distrito" name="distrito" placeholder="Distrito" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="direccionExacta">Dirección Exacta</label>
                            <textarea id="direccionExacta" name="direccionExacta" rows="3"
                                      placeholder="Ingrese la dirección exacta del domicilio" required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="tipoVivienda">Tipo de Vivienda</label> <select
                                id="tipoVivienda" name="tipoVivienda" required>
                                <option value="">Seleccione</option>
                                <option value="propia">Propia</option>
                                <option value="alquilada">Alquilada</option>
                                <option value="prestada">Prestada</option>
                                <option value="precario">Precario</option>
                            </select>
                        </div>
                    </div>

                    <!-- Información Familiar y Socioeconómica -->
                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">Información Familiar y Socioeconómica</h2>
                        </div>
                        <p class="card-description">Composición familiar e ingresos</p>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="numeroPersonasHogar">Personas en el Hogar</label> <input
                                    type="number" id="numeroPersonasHogar"
                                    name="numeroPersonasHogar" placeholder="0" min="0" required>
                            </div>
                            <div class="form-group">
                                <label for="numeroDependientes">Número de Dependientes</label> <input
                                    type="number" id="numeroDependientes" name="numeroDependientes"
                                    placeholder="0" min="0" required>
                            </div>
                            <div class="form-group">
                                <label for="ingresoMensual">Ingreso Mensual Aprox.</label> <input
                                    type="text" id="ingresoMensual" name="ingresoMensual"
                                    placeholder="₡0" required>
                            </div>
                        </div>
                    </div>

                    <!-- Información de Solicitud de Ayuda -->
                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">Información de Solicitud de Ayuda</h2>
                        </div>
                        <p class="card-description">Detalles de la ayuda pastoral
                            requerida</p>

                        <div class="form-row-2">
                            <div class="form-group">
                                <label for="parroquia">Parroquia de Referencia</label> <select
                                    id="parroquia" name="parroquia" required>
                                    <option value="">Seleccione una parroquia</option>
                                    <option value="santiago-apostol">Parroquia Santiago
                                        Apóstol</option>
                                    <option value="san-nicolas">Parroquia San Nicolás</option>
                                    <option value="inmaculada-concepcion">Parroquia
                                        Inmaculada Concepción</option>
                                    <option value="nuestra-senora-pilar">Parroquia Nuestra
                                        Señora del Pilar</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="tipoAyudaSolicitada">Tipo de Ayuda Solicitada</label>
                                <select id="tipoAyudaSolicitada" name="tipoAyudaSolicitada"
                                        required>
                                    <option value="">Seleccione</option>
                                    <option value="alimentaria">Ayuda Alimentaria</option>
                                    <option value="medicamentos">Medicamentos</option>
                                    <option value="vivienda">Vivienda</option>
                                    <option value="educacion">Educación</option>
                                    <option value="servicios">Servicios Básicos</option>
                                    <option value="vestimenta">Vestimenta</option>
                                    <option value="otra">Otra</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="motivoSolicitud">Motivo de la Solicitud</label>
                            <textarea id="motivoSolicitud" name="motivoSolicitud" rows="3"
                                      placeholder="Describa brevemente la situación que motiva la solicitud de ayuda"
                                      required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="observaciones">Observaciones Adicionales</label>
                            <textarea id="observaciones" name="observaciones" rows="3"
                                      placeholder="Información adicional relevante para el expediente"></textarea>
                        </div>
                    </div>

                    <!-- Botones de Acción -->
                    <div class="btn-group">
                        <button type="button" class="btn btn-secondary"
                                onclick="window.location.href = 'expedientes.jsp'">
                            Cancelar</button>
                        <button type="submit" class="btn btn-primary">Guardar
                            Expediente</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>

