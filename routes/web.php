<?php

use Illuminate\Support\Facades\Route;
use App\Http\Integrations\Controllers as IntegrationsControllers;

Route::get('/', function () {
    return view('welcome');
});


Route::get('/integrations/alexa', IntegrationsControllers\AlexaController::class);
