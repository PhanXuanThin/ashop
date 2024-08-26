<?php

namespace App\GraphQL\Queries;

use App\Models\User;

class UserQuery
{
    public function allUsers()
    {
        return User::all();
    }

    public function customItem($root, array $args)
    {
        return User::find($args['id']);
    }
}
