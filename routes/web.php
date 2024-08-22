<?php

use App\Events\UserRegisterd;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PostController;
use App\Jobs\SendMail;
use App\Models\Post;
use App\Models\User;
use App\Mail\PostPublished;
use App\DataTables\UsersDataTable;
use App\Models\Address;
use App\Models\BestSaler;
use App\Models\Feature;
use App\Models\Products;
use App\Models\Coupon;
use App\Http\Controllers\CouponController;


Route::get('/coupons', [CouponController::class, 'index']);
Route::get('/coupons/{id}', [CouponController::class, 'show']);
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    $address = Address::all();
    $bestseller = BestSaler::all();
    $feature= Feature::all();
    $products= Products::all();
    $coupons=Coupon::all();
    return view('ashop', [
        'address' => $address,
        'bestseller' => $bestseller,
        'feature'=> $feature,
        'products'=> $products,
        'coupons'=> $coupons
    ]);
});
