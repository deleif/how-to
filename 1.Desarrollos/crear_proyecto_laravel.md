
# Proyecto Laravel con AdminLTE

Este proyecto utiliza Laravel como framework backend y el paquete [Laravel-AdminLTE](https://github.com/jeroennoten/Laravel-AdminLTE) para la interfaz de administración.

## Pasos de instalación y configuración

### 1. Instalar dependencias del frontend

Ejecuta el siguiente comando para instalar las dependencias de Node:

```bash
npm install
```

### 2. Compilar los assets

Una vez instaladas las dependencias, compila los archivos del frontend:

```bash
npm run build
```

### 3. Ejecutar migraciones de base de datos

Aplica las migraciones con el comando:

```bash
php artisan migrate
```

### 4. Iniciar el servidor de desarrollo

Levanta el servidor local con:

```bash
php artisan serve
```

---

## Instalación y configuración de AdminLTE

### 1. Crear el archivo de rutas `admin.php`

En el directorio `routes`, crea un nuevo archivo llamado `admin.php` donde definirás las rutas para el panel de administración.

### 2. Registrar las rutas de administrador

Edita el archivo `bootstrap/app.php` e incluye el archivo `admin.php` en el bloque de configuración de rutas:

```php
<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Support\Facades\Route;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
        then: function () {
            Route::middleware('web', 'auth')->group(base_path('routes/admin.php'));
        }
    )
    ->withMiddleware(function (Middleware $middleware) {
        //
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
```

### 3. Crear el controlador para el panel de administración

Ejecuta el siguiente comando para generar el controlador:

```bash
php artisan make:controller Admin/HomeController
```

Luego edita el controlador generado como se muestra a continuación:

```php
<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index()
    {
        return view('admin.index');
    }
}
```

### 4. Crear la vista de administrador

Crea la vista `resources/views/admin/index.blade.php` y agrega el siguiente contenido:

```blade
@extends('adminlte::page')

@section('title', 'Dashboard')

@section('content_header')
    <h1>Dashboard</h1>
@stop

@section('content')
    <p>Welcome to this beautiful admin panel.</p>
@stop

@section('css')
    {{-- Agrega aquí tus hojas de estilo personalizadas --}}
    {{-- <link rel="stylesheet" href="/css/admin_custom.css"> --}}
@stop

@section('js')
    <script> console.log("Hi, I'm using the Laravel-AdminLTE package!"); </script>
@stop
```

### 5. Instalar el paquete AdminLTE

Instala el paquete con Composer:

```bash
composer require jeroennoten/laravel-adminlte
```

Y luego ejecuta el instalador:

```bash
php artisan adminlte:install
```

---

## Notas finales

- Asegúrate de tener autenticación habilitada, ya que las rutas de administrador están protegidas con middleware `auth`.
- Puedes personalizar la plantilla de AdminLTE editando los archivos de configuración generados tras la instalación.

---
