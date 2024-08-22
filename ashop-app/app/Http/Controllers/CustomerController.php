<?php

namespace App\Http\Controllers;

use App\Models\Coupon;
use Illuminate\Http\Request;

class CouponController extends Controller
{
    public function index()
    {
        $coupons = Coupon::all();
        return response()->json($coupons);
    }

    public function show($id)
    {
        $coupon = Coupon::find($id);

        if ($coupon) {
            return response()->json($coupon);
        } else {
            return response()->json(['message' => 'Coupon not found'], 404);
        }
    }
}
