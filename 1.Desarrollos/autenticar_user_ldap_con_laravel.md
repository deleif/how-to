
# Autenticación LDAP en Laravel con Jetstream

Esta guía detalla el proceso para habilitar la autenticación LDAP en un proyecto Laravel existente utilizando Jetstream y el paquete `ldaprecord-laravel`.

---

## 1. Crear un nuevo proyecto Laravel con Jetstream

Si aún no tienes un proyecto Laravel con Jetstream, créalo con el siguiente comando:

```bash
laravel new nombre-del-proyecto
cd nombre-del-proyecto
composer require laravel/jetstream
php artisan jetstream:install livewire
npm install && npm run build

```

---

## 2. Modificar la migración de usuarios

Antes de ejecutar las migraciones, edita `database/migrations/xxxx_xx_xx_create_users_table.php` para agregar campos adicionales:

```php
Schema::create('users', function (Blueprint $table) {
    $table->id();
    $table->string('name');
    $table->string('surname');
    $table->string('username');
    $table->string('email')->unique();
    $table->timestamp('email_verified_at')->nullable();
    $table->string('password');
    $table->rememberToken();
    $table->foreignId('current_team_id')->nullable();
    $table->string('profile_photo_path', 2048)->nullable();
    $table->timestamps();
});
```

---

## 3. Configurar la base de datos PostgreSQL (opcional)

Si estás usando PostgreSQL, configura tu archivo `.env` con:

```
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=newldap2
DB_USERNAME=postgres
DB_PASSWORD=1234
```

Luego ejecuta las migraciones:

```bash
php artisan migrate
```

---

## 4. Instalar LdapRecord Laravel

Ejecuta el siguiente comando:

```bash
composer require directorytree/ldaprecord-laravel
```

---

## 5. Publicar archivos de configuración

Esto creará `config/ldap.php` y actualizará `config/auth.php`:

```bash
php artisan vendor:publish --provider="LdapRecord\Laravel\LdapServiceProvider"
```

---

## 6. Configurar el archivo `.env`

Agrega o modifica las siguientes variables:

```
LDAP_LOGGING=true
LDAP_CONNECTION=default
LDAP_HOST=xxxxxx
LDAP_USERNAME=xxxxxx
LDAP_PASSWORD=xxxxxxxxxx
LDAP_PORT=xxx
LDAP_BASE_DN="ou=xxx,dc=xxx,dc=xxxx"
LDAP_TIMEOUT=5
LDAP_SSL=false
LDAP_TLS=false
```

---

## 7. Configurar `config/auth.php`

Reemplaza el bloque `'providers'` por:

```php
'providers' => [
    'users' => [
        'driver' => 'ldap',
        'model' => LdapRecord\Models\ActiveDirectory\User::class,
        'database' => [
            'model' => App\Models\User::class,
            'sync_passwords' => false,
            'sync_attributes' => [
                'name' => 'givenname',
                'surname' => 'sn',
                'username' => 'samaccountname',
                'email' => 'mail',
            ],
        ],
    ],
],
```

---

## 8. Modificar el modelo `User`

Edita `app/Models/User.php` para incluir las interfaces y traits necesarios:

```php
use LdapRecord\Laravel\Auth\HasLdapUser;
use LdapRecord\Laravel\Auth\AuthenticatesWithLdap;
use LdapRecord\Laravel\Auth\LdapAuthenticatable;
use Laravel\Fortify\TwoFactorAuthenticatable;
use Laravel\Jetstream\HasProfilePhoto;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable implements LdapAuthenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    use AuthenticatesWithLdap, HasLdapUser;
}
```

---

## 9. Agregar columnas `guid` y `domain` a la tabla `users`

Crea una migración:

```bash
php artisan make:migration add_ldap_columns_to_users_table
```

Contenido de la migración:

```php
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddLdapColumnsToUsersTable extends Migration
{
    public function up()
    {
        $driver = Schema::getConnection()->getDriverName();

        Schema::table('users', function (Blueprint $table) use ($driver) {
            $table->string('guid')->nullable();
            $table->string('domain')->nullable();

            if ($driver !== 'sqlsrv') {
                $table->unique('guid');
            }
        });

        if ($driver === 'sqlsrv') {
            DB::statement(
                $this->compileUniqueSqlServerIndexStatement('users', 'guid')
            );
        }
    }

    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['guid', 'domain']);
        });
    }

    protected function compileUniqueSqlServerIndexStatement($table, $column)
    {
        return sprintf(
            'create unique index %s on %s (%s) where %s is not null',
            implode('_', [$table, $column, 'unique']),
            $table,
            $column,
            $column
        );
    }
}

Luego ejecuta las migraciones:

```bash
php artisan migrate
```

```

---

## 10. Modificar el formulario de login

Edita `resources/views/auth/login.blade.php` y asegúrate de que el campo `username` esté definido correctamente:

```blade
<div>
    <x-label for="username" value="{{ __('Usuario') }}" />
    <x-input id="username" class="block mt-1 w-full" type="text" name="username" :value="old('username')" required autofocus autocomplete="username" />
</div>
```

---

## 11. Configurar `config/fortify.php`

- Comenta el bloque de características:

```php
'features' => [
/*     Features::registration(),
    Features::resetPasswords(),
    Features::updateProfileInformation(),
    Features::updatePasswords(),
    Features::twoFactorAuthentication([
        'confirm' => true,
        'confirmPassword' => true,
    ]), */
],
```

- Cambia el identificador de autenticación:

```php
'username' => 'username',
```

---

## 12. Crear `AuthServiceProvider`

Ejecuta:

```bash
php artisan make:provider AuthServiceProvider
```

Contenido del archivo `app/Providers/AuthServiceProvider.php`:

```php
namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Auth;
use Laravel\Fortify\Fortify;

class AuthServiceProvider extends ServiceProvider
{
    protected $policies = [];

    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        $this->registerPolicies();

        Fortify::authenticateUsing(function ($request) {
            $validated = Auth::validate([
                'samaccountname' => $request->username,
                'password' => $request->password,
            ]);

            return $validated ? Auth::getLastAttempted() : null;
        });
    }
}
```

---

## 13. Finalización

Con estos pasos completados, tu proyecto Laravel con Jetstream estará preparado para autenticar usuarios mediante Active Directory usando el paquete LdapRecord-Laravel.
