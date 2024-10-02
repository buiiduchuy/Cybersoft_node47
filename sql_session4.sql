# tạo cơ sở dữ liệu
create database node47;
use node47

# tạo table , DATA
# tạo table users
# có 3 kiểu dữ liệu chính:
# - Number: int (số nguyên) , float (số thực),...
# - String: VARCHAR , TEXT,...
# - datetime: (timestamp,date,...)
create table users(
	full_name VARCHAR(100),
	email VARCHAR(255),
	age INT,
	pass_word VARCHAR(255)
);

INSERT INTO users (full_name, email, age, pass_word) VALUES 
('Nguyen Van A', 'nguyenvana@example.com', 25, 'password123'),
('Le Thi B', 'lethib@example.com', 30, 'passw0rd!'),
('Tran Van C', 'tranvanc@example.com', 22, 'mypassword456'),
('Pham Thi D', 'phamthid@example.com', 27, 'abc123xyz'),
('Do Quang Khai', 'khaidq@example.com', 23, 'KhaiPassword!'),
('Nguyen Thi E', 'nguyenthie@example.com', 26, 'securepass789'),
('Le Van F', 'levanf@example.com', 21, 'strongpass111'),
('Tran Thi G', 'tranthig@example.com', 29, 'passkey2021'),
('Nguyen Van H', 'nguyenvanh@example.com', 24, 'password789'),
('Le Thi I', 'lethii@example.com', 31, 'passme2022'),
('Tran Van J', 'tranvanj@example.com', 28, 'jpasspassword!'),
('Pham Van K', 'phamvank@example.com', 22, 'vank_pass432'),
('Do Thi L', 'dothil@example.com', 27, 'secretpass100'),
('Nguyen Van M', 'nguyenvanm@example.com', 24, 'mypassword999'),
('Le Thi N', 'lethin@example.com', 25, 'newpassword123'),
('Tran Van O', 'tranvano@example.com', 26, 'opassword567'),
('Pham Thi P', 'phamthip@example.com', 30, 'strongpassp@ss'),
('Do Van Q', 'dovanq@example.com', 28, 'quypasspass!'),
('Nguyen Thi R', 'nguyenthir@example.com', 23, 'securepassR@123'),
('Le Van S', 'levans@example.com', 21, 'Spasswordstrong!');


# viết câu query để get data
# *: lấy hết tất cả data trong table
# SELECT * from users
SELECT full_name AS 'Họ tên' , email from users

# lấy những người có tuổi từ 20-25 tuổi và sắp xếp tăng dần(giảm dần)
# cách 1:
# where : filter
# order by : sắp xếp
# ASC/DESC : keyword để sắp xếp data
# limit : giới hạn số lượng
SELECT * FROM users
WHERE 20 <= age and age <= 25
ORDER BY  age DESC
LIMIT 5

# cách 2:
# between...and...
SELECT * FROM users
WHERE age BETWEEN 20 and 25


# liệt kê những người có tuổi lớn nhất
# cách 1:
# bước 1 : tìm tuổi lớn nhất trong danh sách users
# bước 2: lấy những người có tuổi lớn nhất
SELECT * FROM users
WHERE age = (
	SELECT age FROM users
	ORDER BY age DESC
	LIMIT 1
)

# cách 2: keyword MAX hoặc MIN
SELECT * FROM users 
WHERE age = (SELECT MIN(age) FROM users)


# tìm những người có họ "lê" trong danh sách
# => keyword LIKE (tìm tương đối)

SELECT * FROM users
WHERE full_name LIKE '%le%'
# le% => sẽ tìm những người có chữ le ở đầu chuỗi : le1, le van , le thi,...
# %le => tìm những người có chữ le ở cuối chuỗi : nguyen van le , trai le,...
# %le% => kết hợp của le% là %le => tìm những người có chữ le (le ở đầu , le ở cuối hoặc le ở giữa)

# DISTINCT lấy ra những full_name khác , không trùng nhau
SELECT DISTINCT full_name FROM users

# đếm có bao nhiêu user trong table
# => count

SELECT COUNT(*) FROM users


# thêm 2 column address và phone cho table users
# => update table thay vì xoá table và tạo lại
# thêm column mới
ALTER table users # keyword để update 
ADD COLUMN address VARCHAR(255),
ADD COLUMN phone VARCHAR(15)

# thay đổi kiểu dữ liệu cho column đó (address)

ALTER TABLE users
modify address VARCHAR(100)


# thêm ràng buộc (contraint) cho column
ALTER TABLE users
modify COLUMN full_name VARCHAR(100) not null

INSERT INTO users(email,age,pass_word,address) VALUES
('test@gmail.com',30,'1234','Quan 3')
# => error : Field 'full_name' doesn't have a default value


# khoá chính (primary key)
# column trong table nhưng dùng để xác định data đó là duy nhất , để query 1 phần tử

# thêm khoá chính cho table users
ALTER TABLE users
add COLUMN user_id int PRIMARY KEY AUTO_INCREMENT

INSERT INTO users(full_name , age, email) VALUES
('cyber',30,'cyber@gmail.com')

# query , insert , update , delete

SELECT * FROM users
WHERE user_id = 3

UPDATE users
SET age = 30
WHERE user_id = 3 # bắt buộc phải có where để không làm thay đổi toàn bộ data có trong table

# DELETE (soft detele và hard delete)
# soft delete : set cờ delete là false và sẽ không show lên UI nhưng data vẫn còn tồn tại dưới database
# hard detele : xoá hẳn data khỏi database

DELETE FROM users
WHERE user_id = 3 # bắt buộc phải có khi dùng hard delete


# relation ship
# Ý nghĩa :
# tổ chức và quản lý dữ liệu tốt hơn thay vì viết tất cả data trong 1 table duy nhất
# giảm thiểu việc trùng lặp dữ liệu
# đảm bảo tính toàn vẹn dữ liệu
# vd: không thể xoá user nếu use đó vẫn có các đơn hàng trong table orders
# tăn hiệu quả truy vấn


# lưu ý khi tạo database khi nhìn vào ERD
# chọn những table có PK và không có FK

# tạo databse cho web app food
# tạo table user , restaurant và foot_type
# vì 3 table này không có FK

CREATE TABLE users(
	user_id int PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(100),
	email VARCHAR(100),
	pass_word VARCHAR(100)
)

INSERT INTO users (full_name, email, pass_word) VALUES
('John Doe', 'johndoe@example.com', 'password123'),
('Jane Smith', 'janesmith@example.com', 'abcde12345'),
('Michael Johnson', 'michaelj@example.com', 'mypassword'),
('Emily Davis', 'emilyd@example.com', 'qwerty9876'),
('David Wilson', 'davidw@example.com', 'pass4321'),
('Sarah Miller', 'sarahm@example.com', 'password456'),
('Christopher Brown', 'chrisb@example.com', 'chris_pass123'),
('Jessica Taylor', 'jessicat@example.com', 'taylor567'),
('Daniel Moore', 'danielm@example.com', 'moore_pass987'),
('Sophia Thomas', 'sophiat@example.com', 'sophia1234'),
('Matthew Jackson', 'matthewj@example.com', 'jackson_pass234'),
('Olivia White', 'oliviaw@example.com', 'olivia_pw567'),
('James Harris', 'jamesh@example.com', 'james123'),
('Isabella Clark', 'isabellac@example.com', 'bella_pass789'),
('Benjamin Lewis', 'benjaminl@example.com', 'ben12345'),
('Emma Walker', 'emmaw@example.com', 'walker123'),
('Alexander Hall', 'alexh@example.com', 'alex_pw567'),
('Charlotte Allen', 'charlottea@example.com', 'charlie_890'),
('Ethan Young', 'ethany@example.com', 'ethan_1234'),
('Ava King', 'avak@example.com', 'ava_pw4321');


# tạo table restaurant 
create table restaurant(
	res_id int PRIMARY KEY AUTO_INCREMENT,
	res_name VARCHAR(100),
	image VARCHAR(255),
	description VARCHAR(255)
)

INSERT INTO restaurant (res_name, image, description) VALUES
('Sunset Grill', 'https://example.com/images/sunset-grill.jpg', 'A cozy beachside grill with the best sunsets.'),
('Ocean Breeze', 'https://example.com/images/ocean-breeze.jpg', 'A seafood lover’s paradise, fresh from the sea.'),
('Mountain View Bistro', 'https://example.com/images/mountain-view.jpg', 'Rustic dishes with an incredible view of the mountains.'),
('Urban Eatery', 'https://example.com/images/urban-eatery.jpg', 'Trendy dishes for city dwellers with a love for food.'),
('Green Garden', 'https://example.com/images/green-garden.jpg', 'Farm-to-table vegetarian delights.'),
('The Spice Route', 'https://example.com/images/spice-route.jpg', 'Exotic flavors from across Asia and the Middle East.'),
('La Dolce Vita', 'https://example.com/images/la-dolce-vita.jpg', 'Authentic Italian cuisine in a romantic setting.'),
('The Steakhouse', 'https://example.com/images/steakhouse.jpg', 'Premium steaks and a wide selection of wines.'),
('Sushi Dreams', 'https://example.com/images/sushi-dreams.jpg', 'Fresh and innovative sushi dishes with a modern twist.'),
('Taco Fiesta', 'https://example.com/images/taco-fiesta.jpg', 'A vibrant spot for the best tacos and margaritas.'),
('The Breakfast Club', 'https://example.com/images/breakfast-club.jpg', 'Start your day right with delicious breakfast options.'),
('Burgers & Brews', 'https://example.com/images/burgers-brews.jpg', 'Gourmet burgers paired with the best craft beers.'),
('Café de Paris', 'https://example.com/images/cafe-de-paris.jpg', 'A quaint French café offering pastries and coffee.'),
('The Vegan Corner', 'https://example.com/images/vegan-corner.jpg', 'Innovative plant-based dishes for the conscious eater.'),
('Pizza Palace', 'https://example.com/images/pizza-palace.jpg', 'Stone-baked pizzas with a variety of fresh toppings.'),
('BBQ Nation', 'https://example.com/images/bbq-nation.jpg', 'A mecca for barbecue enthusiasts, smoky and spicy.'),
('The Golden Dragon', 'https://example.com/images/golden-dragon.jpg', 'Traditional Chinese dishes in a modern setting.'),
('El Rancho', 'https://example.com/images/el-rancho.jpg', 'Tex-Mex flavors with a touch of Southwest charm.'),
('The Noodle House', 'https://example.com/images/noodle-house.jpg', 'Authentic noodle dishes from all over Asia.'),
('Street Bites', 'https://example.com/images/street-bites.jpg', 'Street food classics from around the world.');


# create table foot_type
create table food_type (
	type_id int PRIMARY KEY AUTO_INCREMENT,
	type_name VARCHAR(50)
)

INSERT INTO food_type (type_name) VALUES
('Italian'),
('Chinese'),
('Mexican'),
('Japanese'),
('Indian'),
('Thai'),
('French'),
('Vietnamese'),
('Greek'),
('Spanish'),
('American'),
('Turkish'),
('Korean'),
('Mediterranean'),
('Lebanese'),
('Brazilian'),
('Caribbean'),
('Ethiopian'),
('Moroccan'),
('German');

# create table rate_res

CREATE TABLE rate_res(
	rate_res_id int PRIMARY KEY AUTO_INCREMENT,
	
	user_id INT,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	
	res_id INT,
	FOREIGN KEY (res_id) REFERENCES restaurant(res_id),
	
	amount int,
	date_rate DATE
)

INSERT INTO rate_res (user_id, res_id, amount, date_rate) VALUES
(1, 1, 5, '2024-09-01'),
(2, 2, 4, '2024-09-02'),
(3, 3, 3, '2024-09-03'),
(4, 4, 5, '2024-09-04'),
(5, 5, 4, '2024-09-05'),
(6, 6, 5, '2024-09-06'),
(7, 7, 3, '2024-09-07'),
(8, 8, 4, '2024-09-08'),
(9, 9, 5, '2024-09-09'),
(10, 10, 4, '2024-09-10'),
(11, 11, 5, '2024-09-11'),
(12, 12, 3, '2024-09-12'),
(13, 13, 4, '2024-09-13'),
(14, 14, 5, '2024-09-14'),
(15, 15, 3, '2024-09-15'),
(16, 16, 4, '2024-09-16'),
(17, 17, 5, '2024-09-17'),
(18, 18, 4, '2024-09-18'),
(19, 19, 3, '2024-09-19'),
(20, 20, 5, '2024-09-20');


CREATE TABLE like_res (
	like_res_id int PRIMARY KEY AUTO_INCREMENT,
	
	user_id int,
	FOREIGN KEY(user_id) REFERENCES users(user_id),
	
	res_id int,
	FOREIGN KEY(res_id) REFERENCES restaurant(res_id),
	
	date_like DATE
)

INSERT INTO like_res (user_id, res_id, date_like) VALUES
(1, 1, '2024-09-01'),
(2, 2, '2024-09-02'),
(3, 3, '2024-09-03'),
(4, 4, '2024-09-04'),
(5, 5, '2024-09-05'),
(6, 6, '2024-09-06'),
(7, 7, '2024-09-07'),
(8, 8, '2024-09-08'),
(9, 9, '2024-09-09'),
(10, 10, '2024-09-10'),
(11, 11, '2024-09-11'),
(12, 12, '2024-09-12'),
(13, 13, '2024-09-13'),
(14, 14, '2024-09-14'),
(15, 15, '2024-09-15'),
(16, 16, '2024-09-16'),
(17, 17, '2024-09-17'),
(18, 18, '2024-09-18'),
(19, 19, '2024-09-19'),
(20, 20, '2024-09-20');

CREATE TABLE foods (
	food_id int PRIMARY KEY AUTO_INCREMENT,
	
	food_name VARCHAR(100),
	
	type_id INT,
	FOREIGN KEY(type_id) REFERENCES food_type(type_id),
	
	price int,
	image VARCHAR(255),
	description VARCHAR(255)
)

INSERT INTO foods (food_name, type_id, price, image, description) VALUES
('Margherita Pizza', 1, 150000, 'https://example.com/images/margherita-pizza.jpg', 'Classic Italian pizza with tomatoes and mozzarella.'),
('General Tso\'s Chicken', 2, 120000, 'https://example.com/images/general-tsos-chicken.jpg', 'Spicy, tangy, and sweet Chinese-style fried chicken.'),
('Tacos al Pastor', 3, 90000, 'https://example.com/images/tacos-al-pastor.jpg', 'Mexican tacos with marinated pork and pineapple.'),
('Sushi Roll', 4, 180000, 'https://example.com/images/sushi-roll.jpg', 'Fresh sushi rolls with salmon, avocado, and rice.'),
('Chicken Curry', 5, 160000, 'https://example.com/images/chicken-curry.jpg', 'Rich and flavorful Indian chicken curry.'),
('Pad Thai', 6, 130000, 'https://example.com/images/pad-thai.jpg', 'Popular Thai stir-fried noodles with shrimp and peanuts.'),
('Croissant', 7, 50000, 'https://example.com/images/croissant.jpg', 'Buttery and flaky French pastry.'),
('Pho', 8, 100000, 'https://example.com/images/pho.jpg', 'Traditional Vietnamese beef noodle soup.'),
('Gyro', 9, 120000, 'https://example.com/images/gyro.jpg', 'Greek pita filled with seasoned lamb and vegetables.'),
('Paella', 10, 180000, 'https://example.com/images/paella.jpg', 'Spanish rice dish with seafood and saffron.'),
('Cheeseburger', 11, 140000, 'https://example.com/images/cheeseburger.jpg', 'Juicy American cheeseburger with lettuce and tomato.'),
('Lamb Kebab', 12, 170000, 'https://example.com/images/lamb-kebab.jpg', 'Grilled Turkish lamb skewers with spices.'),
('Bibimbap', 13, 150000, 'https://example.com/images/bibimbap.jpg', 'Korean rice bowl with vegetables, beef, and egg.'),
('Falafel Wrap', 14, 110000, 'https://example.com/images/falafel-wrap.jpg', 'Mediterranean wrap with falafel, hummus, and veggies.'),
('Hummus', 15, 80000, 'https://example.com/images/hummus.jpg', 'Traditional Lebanese chickpea dip served with pita.'),
('Churrasco', 16, 200000, 'https://example.com/images/churrasco.jpg', 'Brazilian grilled beef steak with chimichurri.'),
('Jerk Chicken', 17, 150000, 'https://example.com/images/jerk-chicken.jpg', 'Spicy Caribbean jerk chicken with rice and peas.'),
('Doro Wat', 18, 130000, 'https://example.com/images/doro-wat.jpg', 'Ethiopian spicy chicken stew with injera.'),
('Tagine', 19, 160000, 'https://example.com/images/tagine.jpg', 'Moroccan slow-cooked meat and vegetable stew.'),
('Bratwurst', 20, 100000, 'https://example.com/images/bratwurst.jpg', 'German sausage served with mustard and sauerkraut.');


CREATE TABLE orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
	
	food_id INT,
	FOREIGN KEY(food_id) REFERENCES foods(food_id),
	
	user_id int,
	FOREIGN KEY(user_id) REFERENCES users(user_id),
	amount int,
	
	arr_sub_id VARCHAR(255)
)

INSERT INTO orders (food_id, user_id, amount, arr_sub_id) VALUES
(1, 1, 2, 'SUB123, SUB456'),
(2, 2, 1, 'SUB789'),
(3, 3, 3, 'SUB101, SUB102'),
(4, 4, 2, 'SUB103, SUB104'),
(5, 5, 1, 'SUB105'),
(6, 6, 4, 'SUB106, SUB107'),
(7, 7, 2, 'SUB108'),
(8, 8, 3, 'SUB109, SUB110'),
(9, 9, 1, 'SUB111'),
(10, 10, 2, 'SUB112, SUB113'),
(11, 11, 1, 'SUB114'),
(12, 12, 2, 'SUB115, SUB116'),
(13, 13, 3, 'SUB117'),
(14, 14, 4, 'SUB118, SUB119'),
(15, 15, 1, 'SUB120'),
(16, 16, 3, 'SUB121, SUB122'),
(17, 17, 2, 'SUB123'),
(18, 18, 4, 'SUB124, SUB125'),
(19, 19, 1, 'SUB126'),
(20, 20, 2, 'SUB127, SUB128');


# hiển thị username, tên món ăn của order với user_id = 5
# SELECT u.full_name,f.food_name FROM orders o
SELECT * FROM orders o
LEFT JOIN users u ON o.user_id = u.user_id
#INNER JOIN foods f ON f.food_id = o.food_id
WHERE o.user_id = 5

# left join
# lấy tất cả data giao nhau giữa 2 table là phần còn lại của table bên trái

# table sau from là table bên trái
# table sau join là table bên phải

# right join ngược lại với left join


# funtion tổng hợp : count , max , min , avg , sum -> group by
# khi tìm điều kiện trên những hàm tổng hợp thì dùng HAVING
# tìm 5 người like nhà hàng nhiều nhất

SELECT COUNT(u.user_id) AS 'Số like',u.user_id,u.full_name FROM users u
INNER JOIN like_res lr ON u.user_id = lr.user_id
GROUP BY u.user_id,u.full_name
ORDER BY COUNT(u.user_id) DESC
LIMIT 5

-- tìm người dùng không hoạt động
-- (user_id này không có trong table like_res , rate_res và orders)


####################

# buổi số 4
# liệt kê tất cả các table có trong youtube mini app


# user (user_id , user_name , password , email)
# video 
# like
# chanel
# comment
# video_type = category
# subcription
# history
# play_list
# notification
# ad


# liệt kê tất cả các table có trong food_app
# user
# food
# order
# review
# cart
# history
# rate
# address
# restaurant
# catrgory
# profile
# favorites
# notifition
# 