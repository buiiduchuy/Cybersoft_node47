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

# TỔNG KẾT
# create database , table , column , data
# query (select ... from <ten table>)
# filter (where)
# tìm data trong khoảng (between..and...)
# update table (add column mới , update datatype column)
# thêm ràng buộc => alter table <ten table>
# sub query (tìm kiếm người có tuổi lớn nhất , nhỏ nhất)
# tìm kiếm chuối (like)
# query , insert , update , delete