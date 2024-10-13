<?php

namespace App\Http\Integrations\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;

class AlexaController extends IntegrationController
{
    public function __invoke(): JsonResponse
    {
        Log::debug('Integração Alexa recebeu uma requisição', [
            'request' => request(),
        ]);

        try {
            $intentName = request()->json('request.intent.name');

            if ($intentName === 'AdicionarItemIntent') {
                $slot = collect(request()->json('request.intent.slots'));
                $product = $slot->get('Produto')['value'];

                return response()->json([
                    'version' => '1.0',
                    'response' => [
                        'outputSpeech' => [
                            'type' => 'PlainText',
                            'text' => sprintf('Você tem 5 %s no estoque', $product),
                        ],
                        'shouldEndSession' => false,
                    ],
                ]);
            }
        } catch (\Throwable $exception) {
            Log::error('Comando de integração da Alexa com problemas', [
                'exception' => $exception,
            ]);
        }

        return response()->json([
            'version' => '1.0',
            'response' => [
                'outputSpeech' => [
                    'type' => 'PlainText',
                    'text' => 'Desculpe, não entendi seu pedido.',
                ],
                'shouldEndSession' => false,
            ],
        ]);
    }
}
