<?php

namespace App\Http\Controllers;

use App\Models\Review;
use Illuminate\Http\Request;

class ReviewController extends Controller
{
    // GET /api/reviews
    public function index()
    {
        return Review::all();
    }

    // POST /api/reviews
    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|integer|exists:products,id',
            'customer_id' => 'required|integer|exists:customers,id',
            'rating' => 'required|integer|between:1,5',
            'review' => 'required|string',
        ]);

        return Review::create($request->all());
    }

    // GET /api/reviews/{id}
    public function show($id)
    {
        return Review::findOrFail($id);
    }

    // PUT /api/reviews/{id}
    public function update(Request $request, $id)
    {
        $review = Review::findOrFail($id);
        
        $request->validate([
            'product_id' => 'sometimes|integer|exists:products,id',
            'customer_id' => 'sometimes|integer|exists:customers,id',
            'rating' => 'sometimes|integer|between:1,5',
            'review' => 'sometimes|string',
        ]);

        $review->update($request->all());

        return $review;
    }

    // DELETE /api/reviews/{id}
    public function destroy($id)
    {
        try {
            $review = Review::findOrFail($id);
            $review->delete();
            return response()->json(['message' => 'Review deleted successfully'], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json(['error' => 'Review not found'], 404);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred while deleting the review'], 500);
        }
    }
}
