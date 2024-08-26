<?php

namespace App\GraphQL\Mutations;

use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserMutation
{
    public function createUser($root, array $args)
    {
        $user = new User();
        $user->name = $args['name'];
        $user->email = $args['email'];
        $user->password = Hash::make($args['password']);
        $user->role = $args['role'];
        $user->save();

        return $user;
    }

    public function updateUser($root, array $args)
    {
        $user = User::find($args['id']);

        if (!$user) {
            throw new \Exception('User not found');
        }

        if (isset($args['name'])) {
            $user->name = $args['name'];
        }
        if (isset($args['email'])) {
            $user->email = $args['email'];
        }
        if (isset($args['password'])) {
            $user->password = Hash::make($args['password']);
        }
        if (isset($args['role'])) {
            $user->role = $args['role'];
        }

        $user->save();

        return $user;
    }

    public function deleteUser($root, array $args)
    {
        $user = User::find($args['id']);

        if (!$user) {
            throw new \Exception('User not found');
        }

        return $user->delete();
    }
}
