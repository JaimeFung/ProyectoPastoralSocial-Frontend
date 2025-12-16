<%-- 
    Document   : privacidad
    Created on : Dec 15, 2025, 5:16:59 PM
    Author     : Jaime
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Privacidad y tratamiento de datos - Pastoral Social</title>
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
                margin-bottom: 2rem;
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
                margin-bottom: 1rem;
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

            /* LISTA PRINCIPIOS */

            .principios-lista {
                margin-top: 0.75rem;
                padding-left: 1.1rem;
                font-size: 0.9rem;
                color: #374151;
            }

            .principios-lista li {
                margin-bottom: 0.4rem;
            }

            /* CONFIGURACIONES */

            .two-column-grid {
                display: grid;
                grid-template-columns: minmax(0, 1.1fr) minmax(0, 1fr);
                gap: 1.5rem;
            }

            .settings-group {
                margin-top: 0.6rem;
                display: flex;
                flex-direction: column;
                gap: 0.7rem;
            }

            .setting-row {
                display: flex;
                align-items: flex-start;
                gap: 0.65rem;
            }

            .setting-row input[type="checkbox"] {
                margin-top: 0.2rem;
                width: 16px;
                height: 16px;
            }

            .setting-label {
                font-size: 0.9rem;
                color: #111827;
                font-weight: 500;
            }

            .setting-help {
                font-size: 0.8rem;
                color: var(--color-muted);
            }

            .btn-row {
                display: flex;
                justify-content: flex-end;
                gap: 0.75rem;
                margin-top: 1rem;
                flex-wrap: wrap;
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
                margin-bottom: 1rem;
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

            .hint-text {
                font-size: 0.8rem;
                color: var(--color-muted);
                margin-top: 0.4rem;
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
                <a href="usuarios.jsp" class="nav-item">
                    <span>Usuarios y seguridad</span>
                </a>
                <a href="privacidad.jsp" class="nav-item active">
                    <span>Privacidad y datos</span>
                </a>
            </nav>
        </aside>

        <!-- Top navbar -->
        <header class="top-navbar">
            <div class="nav-actions">
                <a href="usuarios.jsp">Configurar cuenta</a>
                <a href="index.jsp">Cerrar sesión</a>
            </div>
        </header>

        <!-- Main content -->
        <main class="main-content">
            <div class="container">

                <header class="page-header">
                    <h1 class="page-title">Privacidad y tratamiento de datos</h1>
                    <p class="page-subtitle">
                        Defina cómo se protege y se comparte la información de las personas acompañadas
                        por la Pastoral Social.
                    </p>
                </header>

                <!-- Principios -->
                <section class="card">
                    <div class="card-header">
                        <h2 class="card-title">Principios de confidencialidad</h2>
                        <p class="card-description">
                            Estas orientaciones recuerdan el cuidado pastoral que se debe tener con la
                            información de cada persona y familia acompañada.
                        </p>
                    </div>

                    <ul class="principios-lista">
                        <li>
                            Los datos se utilizan únicamente con fines pastorales y administrativos dentro de la diócesis.
                        </li>
                        <li>
                            La información personal no debe compartirse fuera de los equipos autorizados sin el
                            consentimiento correspondiente.
                        </li>
                        <li>
                            Las notas pastorales deben escribirse con respeto, evitando juicios y detalles innecesarios.
                        </li>
                        <li>
                            En reportes y presentaciones públicas se procurará anonimizar los datos personales.
                        </li>
                    </ul>

                    <p class="hint-text">
                        Estas indicaciones no sustituyen la normativa civil vigente ni las políticas oficiales de la diócesis,
                        sino que orientan el uso responsable del sistema.
                    </p>
                </section>

                <!-- Configuraciones -->
                <section class="two-column-grid">

                    <!-- Visibilidad de la información -->
                    <section class="card">
                        <div class="card-header">
                            <h2 class="card-title">Visibilidad de la información pastoral</h2>
                            <p class="card-description">
                                Configure qué datos pueden ser consultados por otros equipos parroquiales y qué
                                información se reserva a responsables específicos.
                            </p>
                        </div>

                        <form id="formVisibilidad">
                            <div class="settings-group">

                                <div class="setting-row">
                                    <input type="checkbox" id="compartir_contacto" checked>
                                    <div>
                                        <label for="compartir_contacto" class="setting-label">
                                            Compartir datos de contacto entre parroquias
                                        </label>
                                        <p class="setting-help">
                                            Permite que otras parroquias vean teléfono y dirección cuando atienden al
                                            mismo beneficiario.
                                        </p>
                                    </div>
                                </div>

                                <div class="setting-row">
                                    <input type="checkbox" id="compartir_historial_ayuda" checked>
                                    <div>
                                        <label for="compartir_historial_ayuda" class="setting-label">
                                            Compartir historial de ayudas entregadas
                                        </label>
                                        <p class="setting-help">
                                            Muestra las ayudas registradas en otras parroquias para evitar duplicidades
                                            y coordinar mejor el acompañamiento.
                                        </p>
                                    </div>
                                </div>

                                <div class="setting-row">
                                    <input type="checkbox" id="ocultar_notas_sensibles">
                                    <div>
                                        <label for="ocultar_notas_sensibles" class="setting-label">
                                            Ocultar notas pastorales sensibles a otros equipos
                                        </label>
                                        <p class="setting-help">
                                            Las notas marcadas como sensibles solo serán visibles para el equipo responsable
                                            del expediente y para la coordinación diocesana.
                                        </p>
                                    </div>
                                </div>

                                <div class="setting-row">
                                    <input type="checkbox" id="restringir_datos_economicos" checked>
                                    <div>
                                        <label for="restringir_datos_economicos" class="setting-label">
                                            Restringir datos económicos a roles autorizados
                                        </label>
                                        <p class="setting-help">
                                            La información sobre ingresos, deudas u otros datos económicos solo será visible
                                            para administradores y coordinadores parroquiales.
                                        </p>
                                    </div>
                                </div>

                                <div class="setting-row">
                                    <input type="checkbox" id="restringir_documentos_confidenciales" checked>
                                    <div>
                                        <label for="restringir_documentos_confidenciales" class="setting-label">
                                            Restringir documentos marcados como confidenciales
                                        </label>
                                        <p class="setting-help">
                                            Los archivos adjuntos señalados como “confidenciales” requerirán permisos
                                            especiales para su visualización.
                                        </p>
                                    </div>
                                </div>

                            </div>
                        </form>
                    </section>

                    <!-- Uso en reportes y comunicaciones -->
                    <section class="card">
                        <div class="card-header">
                            <h2 class="card-title">Uso de datos en reportes y comunicaciones</h2>
                            <p class="card-description">
                                Ajuste cómo se utilizan los datos del sistema en estadísticas, reportes internos y
                                comunicaciones automáticas.
                            </p>
                        </div>

                        <form id="formReportes">
                            <div class="settings-group">

                                <div class="setting-row">
                                    <input type="checkbox" id="usar_en_estadisticas" checked>
                                    <div>
                                        <label for="usar_en_estadisticas" class="setting-label">
                                            Utilizar datos en reportes estadísticos anónimos
                                        </label>
                                        <p class="setting-help">
                                            Permite que la diócesis genere estadísticas globales sin mostrar nombres
                                            ni números de documento.
                                        </p>
                                    </div>
                                </div>

                                <div class="setting-row">
                                    <input type="checkbox" id="anonimizar_impresiones" checked>
                                    <div>
                                        <label for="anonimizar_impresiones" class="setting-label">
                                            Ocultar nombres y cédulas en reportes impresos por defecto
                                        </label>
                                        <p class="setting-help">
                                            Los listados que se impriman desde el sistema mostrarán solo códigos de
                                            expediente, salvo que se indique lo contrario.
                                        </p>
                                    </div>
                                </div>

                                <div class="setting-row">
                                    <input type="checkbox" id="limitar_correos_automaticos" checked>
                                    <div>
                                        <label for="limitar_correos_automaticos" class="setting-label">
                                            Limitar datos personales en correos automáticos
                                        </label>
                                        <p class="setting-help">
                                            Los correos enviados por el sistema incluirán únicamente el código de expediente
                                            y la parroquia, sin detalles sensibles.
                                        </p>
                                    </div>
                                </div>

                                <div class="setting-row">
                                    <input type="checkbox" id="avisar_cambios_privacidad">
                                    <div>
                                        <label for="avisar_cambios_privacidad" class="setting-label">
                                            Avisar a los usuarios cuando cambien estas políticas
                                        </label>
                                        <p class="setting-help">
                                            Enviará un aviso interno cuando se realicen modificaciones importantes en
                                            la configuración de privacidad.
                                        </p>
                                    </div>
                                </div>

                            </div>
                        </form>

                        <p class="hint-text">
                            Estas preferencias podrán ser revisadas periódicamente por la coordinación diocesana para
                            garantizar un uso responsable de la información.
                        </p>
                    </section>
                </section>

                <!-- Botones generales -->
                <section class="card">
                    <div class="btn-row">
                        <button type="button" class="btn btn-secondary" id="btnRestablecer">
                            Restablecer configuración recomendada
                        </button>
                        <button type="button" class="btn" id="btnGuardar">
                            Guardar configuración de privacidad
                        </button>
                    </div>
                </section>

            </div>
        </main>

        <script>
            const formVisibilidad = document.getElementById('formVisibilidad');
            const formReportes = document.getElementById('formReportes');
            const btnGuardar = document.getElementById('btnGuardar');
            const btnRestablecer = document.getElementById('btnRestablecer');

            function guardarConfiguracion() {
                // Aquí después se pueden leer los valores y enviarlos al backend.
                alert('La configuración de privacidad se ha guardado (simulación).');
            }

            function restablecerConfiguracion() {
                if (!confirm('¿Desea restablecer la configuración recomendada de privacidad?')) {
                    return;
                }

                // Valores recomendados por defecto
                formVisibilidad.reset();
                formReportes.reset();

                // Valores recomendados por defecto
                document.getElementById('compartir_contacto').checked = true;
                document.getElementById('compartir_historial_ayuda').checked = true;
                document.getElementById('restringir_datos_economicos').checked = true;
                document.getElementById('restringir_documentos_confidenciales').checked = true;
                document.getElementById('usar_en_estadisticas').checked = true;
                document.getElementById('anonimizar_impresiones').checked = true;
                document.getElementById('limitar_correos_automaticos').checked = true;

                alert('Se ha restablecido la configuración recomendada (simulación).');
            }

            btnGuardar.addEventListener('click', guardarConfiguracion);
            btnRestablecer.addEventListener('click', restablecerConfiguracion);
        </script>
    </body>
</html>
