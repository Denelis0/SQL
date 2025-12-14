create table publisher
(
	publisher_id integer primary key, //Уникальный идентификатор каждой строчки в таблице. Не может быть null, должен быть UNIQUE, только один в таблицы (хотя может быть из нескольких полей)
	org_name varchar(128) not null,
	address text not null
);

create table book
(
	book_id integer primary key,
	title text not null,
	isbn varchar(32) not null,
	fk_publisher_id integer references publisher(publisher_id) not null

);

//Можно изменять структуру таблицы не пересоздавая ее (реализация отношения "один ко многим" - самый частый): 
ALTER TABLE book //Изменить структуру таблицы book
ADD COLUMN fk_publisher_id integer; //Создает колонку с именем fk_publisher_id

ALTER TABLE book
ADD CONSTRAINT fk_book_publisher //Создает правило (ограничение) и даем имя fk_book_publisher
FOREIGN KEY (fk_publisher_id) //Указывает какой стоблец будет связывать две таблицы
REFERENCES publisher(publisher_id); //Куда введет ссылка. Значения fk_publisher_id (таблицы book) должны соответствовать значениям из колонки publisher_id в таблице publisher

insert into book
values
(1, 'The Diary of a Young girl', '0199535566',1),
(2, 'Pride and Prejudice', '9788367594006',1),
(3, 'To kill a mockingbird', '0446310786',2),
(4, 'The book of gutsy women', '1501178415',2),
(5, 'war and peace','1788886526',2);

insert into publisher
values
(1, 'Everyman''s Library','NY'),
(2, 'Oxford university press', 'NY'),
(3, 'Grand central publishing', 'Washington'),
(4, 'Simon & Schuster', 'Chicago');


---------------------------------------------------------------------------------------------------------------------
//Отношение "один к одному"
Create table person
(
	person_id int primary key,
	first_name varchar(64) not null,
	last_name varchar(64) not null
);

create table passport 
(
	passport_id int primary key,
	serial_number int not null,
	fk_passport_person int unique references person(person_id) //unique не позволяет существовать дубликатам
);

Insert into person values (1,'John', 'Snow');
insert into person values (2,'Ned','Stark');
insert into person values (3,'Rob','Baratheon');

alter table passport //Забыл добавить колонку, добавил через alter. При этом она встава в конец стоблцов
ADD column registration text not null;

Insert into passport values (1, 123456, 1, 'Winterfell');
insert into passport values (2, 789012, 2, 'Winterfell');
insert into passport values (3, 345678, 3, 'King''s Landing');


------------------------------------------------------------------------------------------------------------------------------------
//Отношение "многие ко многим"

DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS author;

CREATE TABLE book 
(
	book_id int PRIMARY KEY,
	title text NOT NULL,
	isbn text NOT NULL
);

CREATE TABLE author 
(
	author_id int PRIMARY KEY,
	full_name text NOT NULL,
	rating real
);

CREATE TABLE book_author
(
	book_id int REFERENCES book(book_id), //Внешний ключ на таблицу book стоблец book_id
	author_id int REFERENCES author(author_id),

	CONSTRAINT book_author_pkey PRIMARY KEY (book_id, author_id) //Создается уникальный ключ по двум полям (пара не должна повторяться)
	
);

INSERT INTO book
VALUES
(1, 'book 1', '123456'),
(2, 'book 2', '7890123'),
(3, 'book 3', '4567890'),
(4, 'book 4', '1234567');

INSERT INTO author
VALUES
(1, 'Bob', '4.5'),
(2, 'Alice', '4.0'),
(3, 'John', '4.7');

INSERT INTO book_author
VALUES
(1,1),
(2,1),
(3,1),
(3,2),
(4,1),
(4,2),
(4,3);



Краткая шпаргалка порядка выполнения:
FROM / JOIN (Собрать данные)
WHERE (Отфильтровать сырые данные)
GROUP BY (Сгруппировать)
Агрегатные функции
HAVING (Отфильтровать группы)
SELECT (Выбрать столбцы и посчитать функции)
ORDER BY (Отсортировать)
LIMIT (Обрезать количество)

SELECT DISTINCT title //Убирает дубли
FROM employees;

SELECT COUNT(*) //счет количества строк в таблице
FROM employees;

SELECT COUNT(DISTINCT country) //Ищу сначала страны (без дублей), потом их количество
FROM employees;

SELECT *
FROM customers
WHERE country IN ('Mexico', 'Germany', 'USA', 'Canada'); //ищем где есть эти страны

SELECT *
FROM customers
WHERE country NOT IN ('Mexico', 'Germany', 'USA', 'Canada'); //ищем где нет этих стран

SELECT DISTINCT country
FROM customers
ORDER BY country ASC; //Сортировка по возрастанию (по умолчаю такой вид сортировки)

SELECT DISTINCT country
FROM customers
ORDER BY country DESC; //По убыванию

SELECT MIN(order_date) //Самое маленькое
FROM orders
WHERE ship_city = 'London'

SELECT MAX(order_date) //Самое большое
FROM orders
WHERE ship_city = 'London'

SELECT AVG(unit_price) //Среднее арифметическое (сумма / количество)
FROM products
WHERE discontinued <> 1

SELECT SUM(units_in_stock) //Сумма всех значений
FROM products
WHERE discontinued <> 1

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE '_uch%' //_ - 1 любой символ, % - неограниченное множество любых символов

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NULL;

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NOT NULL;

SELECT category_id, SUM(unit_price * units_in_stock)
FROM products
WHERE discontinued <> 1
GROUP BY category_id
HAVING SUM(unit_price * units_in_stock) > 5000
ORDER BY SUM(unit_price * units_in_stock) DESC;

UNION (ALL) - объединение (с дублями), INTERSECT - пересечение, EXCEPT -исключение, EXCEPT ALL - исключение с вычитание
Пример:
SELECT country
FROM customers
UNION
SELECT country
FROM employees

ПОДЗАПРОСЫ:

SELECT company_name, contact_name
FROM customers
WHERE EXISTS (SELECT customer_id FROM orders
              WHERE customer_id=customers.customer_id AND
              freight BETWEEN 50 AND 100);
			  
//SQL берет первую строку из таблицы customers
//Опустим, это клиент ALFKI.
//В этот момент для базы данных customers.customer_id становится равным 'ALFKI'
//Там написано условие:
//WHERE customer_id = customers.customer_id
//База данных подставляет текущее значение 'ALFKI' в это условие
//WHERE customer_id = 'ALFKI'  
//Она ищет заказы именно для ALFKI. Нашла? Допустим, Да
//Значит, EXISTS возвращает TRUE. Клиент ALFKI попадает в результат
//SQL возвращается к внешней таблице и берет вторую строку

SELECT DISTINCT company_name
FROM customers
WHERE customer_id = ANY(SELECT customer_id FROM orders
                        JOIN order_details USING(order_id)
                        WHERE quantity > 40);
//Сначала база данных находит список ID клиентов, у которых были крупные заказы. Результат — список чисел, например: {ID_1, ID_5, ID_99}
//ANY (Любой): Условие WHERE customer_id = ANY(...) читается так:
//"Возьми клиента, посмотри на его ID. Если этот ID равен любому из чисел в полученном списке, то покажи этого клиента"
//Смысл: Это полный аналог оператора IN (...)
//= ANY (...) — это то же самое, что IN (...)

SELECT DISTINCT product_name, quantity
FROM products
JOIN order_details USING(product_id)
WHERE quantity > ALL (SELECT AVG(quantity)
                      FROM order_details
                      GROUP BY product_id)
ORDER BY quantity;
SELECT AVG(quantity) ... GROUP BY product_id
//Он возвращает не одно число, а список средних значений для каждого продукта отдельно
//Оператор > ALL (...):
//Это условие означает: "Значение должно быть больше, чем КАЖДОЕ число из этого списка"
//Если список [10, 2, 50], то чтобы пройти проверку > ALL, твое количество должно быть больше 50