<?php

use Illuminate\Support\Facades\Route;

var_dump('ESTOU AQUI');
var_dump(storage_path());
die;

Route::get('/', function () {
    return view('welcome');
});
