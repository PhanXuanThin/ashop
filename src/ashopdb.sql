-- 1. `users`
CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `role` VARCHAR(50),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    email VARCHAR(255) NOT NULL,
    type_address VARCHAR(255),
    business_model VARCHAR(255),
    status VARCHAR(255),
    name_hotel VARCHAR(255),
    tel_hotel VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- 2. `customers`
CREATE TABLE `customers` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(20),
    `address` TEXT,
    `city` VARCHAR(255),
    `state` VARCHAR(255),
    `country` VARCHAR(255),
    `postal_code` VARCHAR(20),
    `loyalty_points` INT DEFAULT 0,
    `status` VARCHAR(50),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. `products`
CREATE TABLE `products` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `brand` VARCHAR(255),
    `price` DECIMAL(10, 2),
    `discounted_price` DECIMAL(10, 2),
    `quantity` INT DEFAULT 0,
    `availability` BOOLEAN DEFAULT TRUE,
    `available_color` VARCHAR(255),
    `available_size` VARCHAR(255),
    `promotions` TEXT,
    `image_main` VARCHAR(255),
    `image_gallery` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
INSERT INTO `products` (`name`, `description`, `brand`, `price`, `discounted_price`, `quantity`, `availability`, `available_color`, `available_size`, `promotions`, `image_main`, `image_gallery`)
VALUES
('Smartphone X1', 'Latest model with advanced features', 'TechBrand', 799.99, 749.99, 50, TRUE, 'Black, White', '64GB, 128GB, 256GB', 'Summer Sale', 'smartphone_x1_main.jpg', 'smartphone_x1_gallery1.jpg, smartphone_x1_gallery2.jpg'),
('Wireless Headphones', 'Noise-cancelling headphones with long battery life', 'AudioCo', 199.99, 179.99, 100, TRUE, 'Black', 'One Size', 'Holiday Discount', 'headphones_main.jpg', 'headphones_gallery1.jpg, headphones_gallery2.jpg'),
('4K Ultra HD TV', '55-inch 4K Ultra HD television with smart features', 'VisionTech', 1199.99, 1099.99, 30, TRUE, 'Silver', '55 Inch', 'Spring Special', 'tv_main.jpg', 'tv_gallery1.jpg, tv_gallery2.jpg'),
('Gaming Laptop Pro', 'High-performance gaming laptop with powerful specs', 'GameMaster', 1499.99, 1399.99, 20, TRUE, 'Gray', '15.6 Inch', 'Black Friday Sale', 'laptop_main.jpg', 'laptop_gallery1.jpg, laptop_gallery2.jpg'),
('Bluetooth Speaker', 'Portable Bluetooth speaker with rich sound', 'SoundWave', 89.99, 79.99, 150, TRUE, 'Red, Blue, Black', 'One Size', 'Weekend Deal', 'speaker_main.jpg', 'speaker_gallery1.jpg, speaker_gallery2.jpg');

-- 4. `categories`
CREATE TABLE `categories` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `parent_id` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`parent_id`) REFERENCES `categories`(`id`)
);

-- 5. `product_categories`
CREATE TABLE `product_categories` (
    `product_id` INT,
    `category_id` INT,
    PRIMARY KEY (`product_id`, `category_id`),
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
    FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`)
);

-- 6. `orders`
CREATE TABLE `orders` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_number` VARCHAR(255) UNIQUE NOT NULL,
    `customer_id` INT,
    `status` VARCHAR(50),
    `total_amount` DECIMAL(10, 2),
    `shipping_address` TEXT,
    `billing_address` TEXT,
    `payment_method` VARCHAR(255),
    `payment_status` VARCHAR(50),
    `shipping_method` VARCHAR(255),
    `shipping_cost` DECIMAL(10, 2),
    `tracking_number` VARCHAR(255),
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`)
);

-- 7. `order_items`
CREATE TABLE `order_items` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT,
    `product_id` INT,
    `product_name` VARCHAR(255),
    `product_price` DECIMAL(10, 2),
    `quantity` INT,
    `total_price` DECIMAL(10, 2),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`),
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`)
);

-- 8. `payments`
CREATE TABLE `payments` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT,
    `amount` DECIMAL(10, 2),
    `payment_method` VARCHAR(255),
    `payment_status` VARCHAR(50),
    `transaction_id` VARCHAR(255),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`)
);

-- 9. `shipping_methods`
CREATE TABLE `shipping_methods` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `method_name` VARCHAR(255),
    `description` TEXT,
    `cost` DECIMAL(10, 2),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- Insert sample reviews with valid customer_id and product_id
INSERT INTO `reviews` (product_id, customer_id, rating, review, created_at, updated_at)
VALUES
    (1, 1, 5, 'Excellent product, highly recommend!', NOW(), NOW()),
    (1, 2, 4, 'Very good, but there are some minor issues.', NOW(), NOW()),
    (2, 1, 3, 'Average experience. It could be better.', NOW(), NOW()),  -- Make sure this customer_id and product_id exist
    (2, 2, 2, 'Not satisfied with the quality.', NOW(), NOW()),        -- Make sure this customer_id and product_id exist
    (1, 2, 1, 'Terrible experience. Will not purchase again.', NOW(), NOW()); -- Make sure this customer_id and product_id exist

-- 10. `reviews`
CREATE TABLE `reviews` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `product_id` INT,
    `customer_id` INT,
    `rating` INT CHECK (`rating` BETWEEN 1 AND 5),
    `review` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`)
);
INSERT INTO `reviews` (product_id, customer_id, rating, review, created_at, updated_at)
VALUES
    (1, 1, 5, 'Excellent product, highly recommend!', NOW(), NOW()),
    (1, 2, 4, 'Very good, but there are some minor issues.', NOW(), NOW()),
    (2, 3, 3, 'Average experience. It could be better.', NOW(), NOW()),
    (3, 4, 2, 'Not satisfied with the quality.', NOW(), NOW()),
    (4, 5, 1, 'Terrible experience. Will not purchase again.', NOW(), NOW());
    -- Insert sample customers
INSERT INTO `customers` (first_name, last_name, email, password, phone, address, city, state, country, postal_code, loyalty_points, status, created_at, updated_at)
VALUES
    ('John', 'Doe', 'john.doe@example.com', 'password123', '123-456-7890', '123 Elm St', 'Springfield', 'IL', 'USA', '62701', 100, 'active', NOW(), NOW()),
    ('Jane', 'Smith', 'jane.smith@example.com', 'password123', '987-654-3210', '456 Oak St', 'Springfield', 'IL', 'USA', '62702', 150, 'active', NOW(), NOW());

-- Insert sample products
INSERT INTO `products` (name, description, price, created_at, updated_at)
VALUES
    ('Product A', 'Description for product A', 19.99, NOW(), NOW()),
    ('Product B', 'Description for product B', 29.99, NOW(), NOW());
-- Insert sample customers
INSERT INTO `customers` (first_name, last_name, email, password, phone, address, city, state, country, postal_code, loyalty_points, status, created_at, updated_at)
VALUES
    ('John', 'Doe', 'john.doe@example.com', 'password123', '123-456-7890', '123 Elm St', 'Springfield', 'IL', 'USA', '62701', 100, 'active', NOW(), NOW()),
    ('Jane', 'Smith', 'jane.smith@example.com', 'password123', '987-654-3210', '456 Oak St', 'Springfield', 'IL', 'USA', '62702', 150, 'active', NOW(), NOW());

-- Insert sample products
INSERT INTO `products` (name, description, price, created_at, updated_at)
VALUES
    ('Product A', 'Description for product A', 19.99, NOW(), NOW()),
    ('Product B', 'Description for product B', 29.99, NOW(), NOW());

-- 11. `coupons`
CREATE TABLE `coupons` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `code` VARCHAR(255) UNIQUE NOT NULL,
    `description` TEXT,
    `discount_type` VARCHAR(50),
    `discount_value` DECIMAL(10, 2),
    `start_date` DATE,
    `end_date` DATE,
    `usage_limit` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 12. `order_coupons`
CREATE TABLE `order_coupons` (
    `order_id` INT,
    `coupon_id` INT,
    `discount_applied` DECIMAL(10, 2),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`order_id`, `coupon_id`),
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`),
    FOREIGN KEY (`coupon_id`) REFERENCES `coupons`(`id`)
);

-- 13. `wishlists`
CREATE TABLE `wishlists` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `customer_id` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`)
);

-- 14. `wishlist_items`
CREATE TABLE `wishlist_items` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `wishlist_id` INT,
    `product_id` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`wishlist_id`) REFERENCES `wishlists`(`id`),
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`)
);

-- 15. `carts`
CREATE TABLE `carts` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `customer_id` INT,
    `session_id` VARCHAR(255),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`)
);

-- 16. `cart_items`
CREATE TABLE `cart_items` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `cart_id` INT,
    `product_id` INT,
    `quantity` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`cart_id`) REFERENCES `carts`(`id`),
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`)
);

-- 17. `addresses`
CREATE TABLE `addresses` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `customer_id` INT,
    `address` TEXT,
    `city` VARCHAR(255),
    `state` VARCHAR(255),
    `country` VARCHAR(255),
    `postal_code` VARCHAR(20),
    `type` VARCHAR(50),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`)
);

-- 18. `inventory`
CREATE TABLE `inventory` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `product_id` INT,
    `quantity_in_stock` INT DEFAULT 0,
    `quantity_sold` INT DEFAULT 0,
    `quantity_reserved` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`)
);

-- 19. `product_images`
CREATE TABLE `product_images` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `product_id` INT,
    `image_path` VARCHAR(255),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`)
);

-- 20. `settings`
CREATE TABLE `settings` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `key` VARCHAR(255) UNIQUE NOT NULL,
    `value` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 21. `roles`
CREATE TABLE `roles` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `role_name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 22. `role_user`
CREATE TABLE `role_user` (
    `user_id` INT,
    `role_id` INT,
    PRIMARY KEY (`user_id`, `role_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`)
);

-- 23. `activity_logs`
CREATE TABLE `activity_logs` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT,
    `action` VARCHAR(255),
    `description` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);

-- 24. `tags`
CREATE TABLE `tags` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 25. `product_tags`
CREATE TABLE `product_tags` (
    `product_id` INT,
    `tag_id` INT,
    PRIMARY KEY (`product_id`, `tag_id`),
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
    FOREIGN KEY (`tag_id`) REFERENCES `tags`(`id`)
);

-- 26. `discounts`
CREATE TABLE `discounts` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `product_id` INT,
    `discount_type` VARCHAR(50),
    `discount_value` DECIMAL(10, 2),
    `start_date` DATE,
    `end_date` DATE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`)
);

-- 27. `taxes`
CREATE TABLE `taxes` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `tax_name` VARCHAR(255),
    `rate` DECIMAL(5, 2),
    `country` VARCHAR(255),
    `state` VARCHAR(255),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 28. `order_statuses`
CREATE TABLE `order_statuses` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `status_name` VARCHAR(255),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 29. `order_status_history`
CREATE TABLE `order_status_history` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT,
    `status_id` INT,
    `changed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`),
    FOREIGN KEY (`status_id`) REFERENCES `order_statuses`(`id`)
);

-- 30. `banners`
CREATE TABLE `banners` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255),
    `image_path` VARCHAR(255),
    `link` VARCHAR(255),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
