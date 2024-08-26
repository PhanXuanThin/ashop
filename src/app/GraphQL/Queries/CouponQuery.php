<?php

namespace App\GraphQL\Queries;

use App\Models\Coupons;
use Google\Service\Datastore\Count;
use Google\Service\Monitoring\Custom;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class CouponQuery
{
    public function allCoupons()
    {
        return Coupons::all();
    }

    public function customCoupon($root, array $args)
    {
        return Coupons::find($args['id']);
    }
}
