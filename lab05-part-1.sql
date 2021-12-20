-- Kiểm tra xem đã có CSDL BookLibrary chưa, nếu có thì xoá đi.
if exists (select * from sys.databases where name='BookLibrary')
	drop database BookLibrary
go
-- Tạo lại CSDL BookLibrary
create database BookLibrary