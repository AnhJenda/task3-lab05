use BookLibrary
go
-- Tạo bảng Book
create table Book (
	BookCode int,
	BookTitle varchar(100) NOT NULL,
	Author varchar(50) NOT NULL,
	Edition int,
	BookPrice money,
	Copies int,
	constraint pk_book primary key (BookCode)
)
go
-- Tạo bảng Member
create table Member (
	MemberCode int,
	MemberName varchar(50) NOT NULL,
	MemberAddress varchar(100) NOT NULL,
	PhoneNumber int,
	constraint pk_member primary key (MemberCode),
)
go
-- Tạo bảng IssueDetails
create table IssueDetails (
	BookCode int,
	MemberCode int,
	IssueDate datetime,
	ReturnDate datetime,
	constraint fk_BookCode foreign key (BookCode) references Book(BookCode),
	constraint fk_MemberCode foreign key (MemberCode) references Member(MemberCode)
)
go
						-- Dưới đây là các thao tác với bảng theo yêu cầu ở mục 2.
-- Xoá bỏ các ràng buộc khoá ngoại ở bảng IssueDetails
alter table IssueDetails
	drop constraint fk_BookCode
alter table IssueDetails
	drop constraint fk_MemberCode
go
-- Xoá bỏ ràng buộc khoá chính ở bảng Book và Member
alter table Book
	drop constraint pk_book
alter table Member
	drop constraint pk_member
go
-- Thêm mới ràng buộc khoá chính cho bảng Member và Book
alter table Book
	add constraint pk_book primary key (BookCode)
alter table Member
	add constraint pk_member primary key (MemberCode)
go
-- Thêm mới các ràng buộc khoá ngoại cho bảng IssueDetails
alter table IssueDetails
	add constraint fk_BookCode foreign key (BookCode) references Book(BookCode);
alter table IssueDetails
	add constraint fk_MemberCode foreign key (MemberCode) references Member(MemberCode)
go
-- Bổ sung thêm ràng buộc giá bán sách >0 và <200
alter table Book
	add constraint ck_BookPrice check (BookPrice > 0 and BookPrice < 200)
go
-- Bổ sung thêm ràng buộc duy nhất cho cột PhoneNumber của bảng Member
alter table Member
	add constraint unique_PhoneNumber unique(PhoneNumber)
go
-- Bổ sung thêm ràng buộc NOT NULL cho BookCode, MemberCode trong bảng IssueDetails
alter table IssueDetails
	alter column BookCode int NOT NULL;
alter table IssueDetails
	alter column MemberCode int NOT NULL	
go
-- Tạo khóa chính gồm 2 cột BookCode, MemberCode cho bảng IssueDetails		
alter table IssueDetails
	add primary key (BookCode, MemberCode) 	
go
		-- Thêm dữ liệu hợp lý cho các bảng 
-- Bảng Book
insert into Book (BookCode, BookTitle, Author, Edition, BookPrice, Copies)
	values
		(1,'Vạn Cổ Thần Đế', 'Phi Thiên Ngư', 2, 100, 50),
		(2,'Vũ Luyện Điên Phong', 'Mạc Mặc', 4, 70, 50),
		(3,'Phàm Nhân Tu Tiên', 'Nhĩ Căn', 2, 199, 50),
		(4,'Nhất Niệm Vĩnh Hằng', 'Nhĩ Căn', 3, 100, 50)
go
-- Bảng Member
insert into Member (MemberCode, MemberName, MemberAddress, PhoneNumber)
	values
		(1, 'Đinh Quang Anh', 'Ninh Bình', 100761),
		(2, 'Vũ Viết Quý', 'Thái Bình', 923742),
		(3, 'Tạ Duy Linh', 'Thái Nguyên', 742842)
go
-- Bảng IssueDetails
insert into IssueDetails (BookCode, MemberCode ,IssueDate, ReturnDate)
	values
		(1, 1, '20211218 10:48:56 AM', '20211225 10:48:56 AM'),
		(2, 2, '20211220 09:32:30 AM', '20211227 09:32:30 AM'),
		(3, 3, '20211222 09:50:30 AM', '20211229 09:50:30 AM')
		-- Select để Kiểm tra các bảng
select * from Book
select * from Member
select * from IssueDetails