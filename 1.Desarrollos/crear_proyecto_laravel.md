
# Proyecto Laravel con AdminLTE

Este proyecto utiliza Laravel como framework backend y el paquete [Laravel-AdminLTE](https://github.com/jeroennoten/Laravel-AdminLTE) para la interfaz de administración.

## 1. Configuración inicial del proyecto

### 1.1 Crear un nuevo proyecto Laravel

```bash
composer create-project laravel/laravel nombre-del-proyecto
cd nombre-del-proyecto
```

### 1.2 Instalar Jetstream

```bash
composer require laravel/jetstream
```

### 1.3 Instalar Jetstream con Livewire

```bash
php artisan jetstream:install livewire
```

### 1.4 Instalar dependencias del frontend

```bash
npm install
```

### 1.5 Compilar los assets

```bash
npm run build
```

### 1.6 Ejecutar migraciones de base de datos

```bash
php artisan migrate
```

### 1.7 Iniciar el servidor de desarrollo

```bash
php artisan serve
```

---

## 2. Instalación y configuración de AdminLTE

### 2.1 Crear el archivo de rutas `admin.php`

En el directorio `routes`, crea un nuevo archivo llamado `admin.php` donde definirás las rutas para el panel de administración.

### 2.2 Registrar las rutas de administrador

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

### 2.3 Crear el controlador para el panel de administración

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

### 2.4 Crear la vista de administrador

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

### 2.5 Instalar el paquete AdminLTE

Instala el paquete con Composer:

```bash
composer require jeroennoten/laravel-adminlte
```

Y luego ejecuta el instalador:

```bash
php artisan adminlte:install
```

---

## 3. Notas finales

- Asegúrate de tener autenticación habilitada, ya que las rutas de administrador están protegidas con middleware `auth`.
- Puedes personalizar la plantilla de AdminLTE editando los archivos de configuración generados tras la instalación.

---
