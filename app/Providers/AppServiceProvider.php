<?php

namespace App\Providers;
use Carbon\Carbon;
use Illuminate\Support\ServiceProvider;
use Eusebiu\JavaScript\Facades\ScriptVariables;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        Carbon::setLocale(config('app.locale'));

        $this->app->bind('App\Contracts\IContactsRepository', 'App\Repositories\ContactsRepository');
        $this->app->bind('App\Contracts\IProductsRepository', 'App\Repositories\ProductsRepository');
        $this->app->bind('App\Contracts\IEmailRepository', 'App\Repositories\EmailRepository');
        $this->app->bind('App\Contracts\IPdfRepository', 'App\Repositories\PdfRepository');
    }
}
