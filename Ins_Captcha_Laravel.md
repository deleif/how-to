# INSTALAR GOOGLE CAPTCHA EN Laravel
* Ejecuta el siguiente comando para instalar la biblioteca NoCaptcha a través de Composer:

> 'composer require anhskohbo/no-captcha'


* Después de que Composer haya terminado de instalar la biblioteca, abre el archivo config/app.php y agrega el siguiente proveedor de servicios en el arreglo provider
> ''providers' => [
    // Otros proveedores de servicios...
    Anhskohbo\NoCaptcha\NoCaptchaServiceProvider::class,
],

* A continuación, en el mismo archivo config/app.php, agrega el siguiente alias de fachada en el arreglo aliases:
> ''aliases' => [
    // Otros alias de fachada...
    'NoCaptcha' => Anhskohbo\NoCaptcha\Facades\NoCaptcha::class,
],

* Ahora, para configurar las credenciales del servicio reCAPTCHA de Google, ve a la página oficial de reCAPTCHA (https://www.google.com/recaptcha) y regístrate para obtener las claves del sitio (Site Key) y la clave secreta (Secret Key).
Una vez que tengas las claves, abre el archivo .env en la raíz de tu proyecto Laravel y agrega las siguientes variables de entorno:
> 'NOCAPTCHA_SECRET=your-secret-key'
> 'NOCAPTCHA_SITEKEY=your-site-key'

* Ejecuta el siguiente comando para generar las vistas de autenticación de Laravel Fortify:
> 'php artisan vendor:publish --provider="Laravel\Fortify\FortifyServiceProvider"

Luego, en el archivo resources/views/auth/login.blade.php, agrega el siguiente código antes del botón de inicio de sesión:

> '<div class="g-recaptcha" data-sitekey="{{ config('services.recaptcha.sitekey') }}"></div>

*Agrega el script que Se genera con tus detalles clave. Usa este fragmento para obtener tokens de reCAPTCHA, que, luego, debe verificar el backend de tu aplicación.
Es algo así:
> '<script src="https://www.google.com/recaptcha/enterprise.js?render=6Ld0Jw4mAAAAAIOXNGXof87Hr811X9MES5Lbuy7p"></script>
<script>
grecaptcha.enterprise.ready(function() {
    grecaptcha.enterprise.execute(xxxxxxxxxxxxxxxxxxxxxxxxxxxx, {action: 'login'}).then(function(token) {
       ...
    });
});
</script>
