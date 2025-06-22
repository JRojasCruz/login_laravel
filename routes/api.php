<?php

use App\Http\Controllers\Api\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Laravel\Sanctum\Http\Middleware\EnsureFrontendRequestsAreStateful;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login'])
  ->middleware(EnsureFrontendRequestsAreStateful::class);
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
  return $request->user();
});
