/* Tao bảng ảo có tên là Thong_tin_Nhan_Vien gồm những thuộc tính:
-MNV
-Ho va ten
-Phong ban
-luong
*/

create view Thong_tin_Nhan_Vien as
SELECT    e.employee_id AS MNV, CONCAT(e.first_name, ' ', e.last_name)  AS [Ho va ten], d.department_name AS [Phong Ban], e.salary AS luong
FROM         dbo.employees AS e INNER JOIN
                      dbo.departments AS d ON d.department_id = e.department_id


/*
  Tao bảng ảo có tên là KinhNghiem gồm những thuộc tính:
-MNV
-KN
*/
create view  KinhNghiem as
SELECT    employee_id AS MNV, DATEDIFF(year, hire_date, GETDATE()) AS KN
FROM         dbo.employees

/*Tạo thủ tục thuong_tet:
   - Nếu nhân viên làm được dưới  10 năm thì tiền thưởng = 1 tháng lương
- Nếu nhân viên làm được dưới  20 năm thì tiền thưởng = 2 tháng lương
- Nếu nhân viên làm được dưới  30 năm thì tiền thưởng = 3 tháng lương
*/
create proc thuong_tet
as
begin
select tt.*,tt.luong[Thuong tet] from Thong_tin_Nhan_Vien tt 
join KinhNghiem kn on kn.MNV=tt.MNV
where kn.kn<20
union 
select tt.*,tt.luong*2[Thuong tet] from Thong_tin_Nhan_Vien tt 
join KinhNghiem kn on kn.MNV=tt.MNV
where kn.kn<30
union 
select tt.*,tt.luong*3[Thuong tet] from Thong_tin_Nhan_Vien tt 
join KinhNghiem kn on kn.MNV=tt.MNV
where kn.kn<30
end

thuong_tet


/* Tao thuc tuc Tang luong
- Nếu nhân viên làm được dưới  10 năm thì tăng 10% 
- Nếu nhân viên làm được dưới  10 năm thì tăng 20% 
- Nếu nhân viên làm được dưới  10 năm thì tăng 30% 
*/

create proc tang_luong
as
begin

	update employees set salary=salary+salary*0.1 where employee_id=
	(select MNV from KinhNghiem where KN<10) 
	update employees set salary=salary+salary*0.2 where employee_id=
	(select MNV from KinhNghiem where KN<20) 

	update employees set salary=salary+salary*0.3 where employee_id in
	(select MNV from KinhNghiem where KN<30) 
end

tang_luong
