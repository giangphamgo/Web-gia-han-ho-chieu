--File database đồ án bảo mật cơ sở dữ liệu
--Lê An & Trường Giang

--1. Tạo các user trong csdl
--Tạo user GS:
create user GS identified by GS;
grant create session to GS;
grant dba to GS;

--Tạo user xác thực cho từng quận ứng với từng địa chỉ
--Tạo user XTQ1 (Xác thực quận 1)
create user XTQ1 identified by XTQ1;
grant create session to XTQ1;
--Tạo user XTQ2 (Xác thực quận 2)
create user XTQ2 identified by XTQ2;
grant create session to XTQ2;
--Tạo user XTQ3 (Xác thực quận 3)
create user XTQ3 identified by XTQ3;
grant create session to XTQ3;
--Tạo user XD (xét duyệt)
create user XD identified by XD;
grant create session to XD;

--Tạo user LT (lưu trữ)
create user LT identified by LT;
grant create session to LT;
--Tạo user nguoidung phụ để kết nối vào ứng dụng web
create user nguoidung identified by 123456;
grant create session to nguoidung;

-- Cung cấp các quyền cho bảng
grant select, update, insert, delete on GS.PASSPORT to XTQ1;
grant select, update, insert, delete on GS.PASSPORT to XTQ2;
grant select, update, insert, delete on GS.PASSPORT to XTQ3;

grant select, insert, update on GS.PASSPORTVALID to XTQ1;
grant select, insert, update on GS.PASSPORTVALID to XTQ2;
grant select, insert, update on GS.PASSPORTVALID to XTQ3;

grant select, update, insert on GS.RESIDENT to XTQ1;
grant select, update, insert on GS.RESIDENT to XTQ2;
grant select, update, insert on GS.RESIDENT to XTQ3;

grant select, update on GS.RESIDENT to LT;
grant select, update on GS.PASSPORTVALID to LT;
grant select, update on GS.PASSPORTVALID to XD;
grant select, insert on GS.PASSPORT to nguoidung;

--2. Tạo bảng cho các đối tượng
--Tạo bảng Passport để chứa dữ liệu đổ từ form đăng ký, được sử dụng bởi user XT
create table Passport (
    MA_SHC CHAR(5) NOT NULL PRIMARY KEY,
    HOVATEN VARCHAR2(50),
    DIACHI VARCHAR2(50),
    PHAI VARCHAR2(10),
    CMND CHAR(10),
    DIENTHOAI CHAR(10),
    EMAIL VARCHAR2(50)
);

--Tạo bảng PassportValid: dữ liệu sau khi được xét duyệt sẽ đổ vào bảng này, được sử dụng bởi user XD
create table PassportValid (
    MA_SHC CHAR(5) NOT NULL PRIMARY KEY,
    HOVATEN VARCHAR2(50),
    DIACHI VARCHAR2(50),
    PHAI VARCHAR2(10),
    CMND CHAR(10),
    DIENTHOAI CHAR(10),
    EMAIL VARCHAR2(50),
    CHAPNHAN NUMBER(1)
	);

--Tạo bảng Resident dùng để chứa dữ liệu người đã có passport, 
--đối chiếu với  bảng passport được sử dụng bởi user XT và LT
create table Resident (
    MSHC CHAR(5) NOT NULL PRIMARY KEY,
    HOVATEN VARCHAR2(50),
    DIACHI VARCHAR2(50),
    PHAI VARCHAR2(10),
    CMND CHAR(10),
    DIENTHOAI CHAR(10),
    EMAIL VARCHAR2(50),
    NGAYHETHAN DATE
	);
--Tạo bảng XT (xác thực) dùng để chưa dữ liệu user XT cho từng quận.
create table XT (
  MSXT CHAR(5) NOT NULL PRIMARY KEY,
  TENQUAN VARCHAR2(50)
);


--3. Insert data vào các bảng
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('aa01', 'Phung Ngoc An', 'Q1', 'nam', '215389141', '0909070751', 'an141@gmail.com', to_date('01/01/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('aa02', 'Truong Minh Duong', 'Q1', 'nam', '215389142', '0909070752', 'duong142@gmail.com', to_date('02/01/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('aa03', 'Nguyen Le My Duyen', 'Q1', 'nu', '215389143', '0909070753', 'duyen143@gmail.com', to_date('03/01/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('aa04', 'Nguyen Thi Kieu Duyen', 'Q1', 'nu', '215389144', '0909070754', 'duyen144@gmail.com', to_date('04/01/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('aa05', 'Le Thi Thanh Ha', 'Q1', 'nu', '215389145', '0909070755', 'ha145@gmail.com', to_date('05/01/2018', 'dd/mm/yyyy') );

--Quan 2
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('bb01', 'Nguyen Duong Khoi', 'Q2', 'nam', '215321461', '0901374430', 'khoi461@gmail.com', to_date('11/01/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('bb02', 'Le Thi Nhu Huynh ', 'Q2', 'nu', '215321462', '0901374431', 'huynh462@gmail.com', to_date('12/01/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('bb03', 'Huynh Van Nhan', 'Q2', 'nam', '215321463', '0901374432', 'nhan463@gmail.com', to_date('13/01/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('bb04', 'Nguyen Minh Nhan', 'Q2', 'nam', '215321464', '0901374433', 'nhan464@gmail.com', to_date('14/01/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('bb05', 'Le Thi My Nu', 'Q2', 'nu', '215321465', '0901374434', 'nu465@gmail.com', to_date('15/01/2018', 'dd/mm/yyyy') );

--Quan 3
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('cc01', 'Bui Vi', 'Q3', 'nam', '213422131', '0909246351', 'buivi131@gmail.com', to_date('01/02/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('cc02', 'Pham Tuan Anh', 'Q3', 'nam', '213422132', '0909246352', 'anh132@gmail.com', to_date('02/02/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('cc03', 'Nguyen Tuong Van', 'Q3', 'nu', '213422133', '0909246353', 'van133@gmail.com', to_date('03/02/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)
values ('cc04', 'Nguyen Hong Van', 'Q3', 'nu', '213422134', '0909246354', 'van134@gmail.com', to_date('04/02/2018', 'dd/mm/yyyy') );
insert into Resident (MSHC, HOVATEN, DIACHI, PHAI, CMND, DIENTHOAI, EMAIL, NGAYHETHAN)


--Insert quận xát thực:
insert into XT(MSXT, TENQUAN) values ('XTQ1','Q1');
insert into XT(MSXT, TENQUAN) values ('XTQ2','Q2');
insert into XT(MSXT, TENQUAN) values ('XTQ3','Q3');

--4. Tạo các chính sách bảo mật
--Tạo 1 function XT_Policy dùng để 
--Trong đó có 1 cái biến tạm QuanXT

CREATE OR REPLACE FUNCTION XT_Policy ( 
p_schema  IN  VARCHAR2 DEFAULT NULL, p_object  IN  VARCHAR2 DEFAULT NULL) 
RETURN VARCHAR2 
IS QuanXT VARCHAR2(30);
BEGIN
IF USER Like 'XT%' THEN
select TENQUAN into QuanXT from XT where MSXT=USER;
RETURN 'DIACHI=' || '''' || QuanXT || ''''; 
END IF;
RETURN NULL;
END; 
BEGIN 
DBMS_RLS.add_policy 
(object_schema     => 'GS',
object_name        => 'RESIDENT', 
policy_name        => 'XT_Policy', 
policy_function    => 'XT_Policy'
); 
END; 

BEGIN 
DBMS_RLS.add_policy 
(object_schema     => 'GS',
object_name        => 'PASSPORT', 
policy_name        => 'XT_Policy1', 
policy_function    => 'XT_Policy'
); 
END; 

--Ap dung cho user LT
create or replace FUNCTION LT_Policy ( 
p_schema  IN  VARCHAR2 DEFAULT NULL, p_object  IN  VARCHAR2 DEFAULT NULL) 
RETURN VARCHAR2 
as
BEGIN
IF USER = 'LT' THEN
RETURN '1=0'; 
END IF;
RETURN NULL;
END;

BEGIN 
DBMS_RLS.add_policy 
(object_schema     => 'GS',
object_name        => 'PASSPORTVALID', 
policy_name        => 'LT_Policy', 
policy_function    => 'LT_Policy',
statement_types => 'SELECT', 
sec_relevant_cols => 'HOVATEN,DIACHI,PHAI,CMND,DIENTHOAI,EMAIL', 
sec_relevant_cols_opt => DBMS_RLS.all_rows
); 
END; 

BEGIN 
DBMS_RLS.add_policy 
(object_schema     => 'GS',
object_name        => 'RESIDENT', 
policy_name        => 'LT_Policy1', 
policy_function    => 'LT_Policy',
statement_types => 'SELECT', 
sec_relevant_cols => 'HOVATEN,DIACHI,PHAI,CMND,DIENTHOAI,EMAIL',
sec_relevant_cols_opt => DBMS_RLS.all_rows
); 
END; 

BEGIN 
DBMS_RLS.add_policy 
(object_schema     => 'GS',
object_name        => 'RESIDENT', 
policy_name        => 'LT_Policy2', 
policy_function    => 'LT_Policy',
statement_types => 'UPDATE', 
sec_relevant_cols => 'HOVATEN,DIACHI,PHAI,CMND,DIENTHOAI,EMAIL'
); 
END;
