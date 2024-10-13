<?php

namespace App\Http\Integrations\Controllers;

use Illuminate\Http\JsonResponse;

class AlexaController extends IntegrationController
{
    public function __invoke(): JsonResponse
    {
        return response()->json('OK');
    }
}
