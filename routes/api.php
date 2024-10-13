<?php

use Illuminate\Support\Facades\Route;
use App\Http\Integrations\Controllers as IntegrationsControllers;

Route::get('/', function () {
    return response()->json([
        'message' => 'Hello!',
    ]);
});

Route::prefix('/integrations')->group(function (\Illuminate\Routing\Router $router) {
    //
});
