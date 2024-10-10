<?php

use Illuminate\Support\Facades\Route;

var_dump($_SERVER);
die;

Route::get('/', function () {
    return view('welcome');
});
