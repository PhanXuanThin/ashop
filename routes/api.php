<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\GraphQLController;

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/graphql', [GraphQLController::class, 'handle']);
});