---- First we create the database named as DB_CarShowroom_DBMSProject
create database DB_OnlineCarShowroom_DBMSProject

--- Create Admin Table
create table tblAdmin
(
  AdminID int primary key identity(1, 1),
  AdminName nvarchar(150),
  Username nvarchar(150),
  AdminPassword nvarchar(150),
  lastLogin date
)

--- create Customer Table
create table tblCustomer
(
  CustomerID int primary key identity(1, 1),
  FirstName nvarchar(150),
  LastName nvarchar(150),
  ContactNo nvarchar(150),
  Email nvarchar(150),
  CustomerPassword nvarchar(150),
  City nvarchar(150),
  CustomerAddress nvarchar(150),
  CustomerPincode nvarchar(150),
  Gender nvarchar(150),
  CreateDate date,
  LastLogin nvarchar(150)
)

-- Create Dealer Table
create table tblDealer
(
  DealerID int primary key identity(1, 1),
  AdminID int references tblAdmin(AdminID),
  DealerName nvarchar(150),
  ContactNo nvarchar(150),
  DealerAddress nvarchar(150),
  Username nvarchar(150),
  DealerPassword nvarchar(150),
  CreateDate date,
  DealerImageName nvarchar(150),
  DealerImagePath nvarchar(150),
  LastLogin datetime
)

-- create Vehicle Table
create table tblVehicle
(
  VehicleID	int primary key identity(1, 1),
  Dealer int references tblDealer(DealerID),
  VehicleName varchar(150),
  Model varchar(150),
  VehicleType varchar(150),
  VehicleDescription varchar(150),
  VehileCost int,
  Quantity int,
  CreateDate date
)

-- create Image Table
create table tblImage
(
  ImageID int primary key identity(1, 1),
  ImageName nvarchar(150),
  Vehicle int references tblVehicle(VehicleID),
  ImagePath nvarchar(150)
)

-- create Showroom Table
create table tblShowroom
(
  ShowroomID int primary key identity (1, 1),
  Dealer int references tblDealer(DealerID),
  ShowroomName nvarchar(150),
  ContactNo nvarchar(150),
  ShowroomAddress nvarchar(150),
  City nvarchar(150),
  ShowroomState nvarchar(150),
  Pincode nvarchar(150),
  ImageName nvarchar(150),
  ImagePath nvarchar(150),
)

-- create Tax table
create table tblTax
(
  TaxID int primary key identity(1, 1),
  TaxDescripion nvarchar(150),
  Tax int
)

-- create Sales Table
create table tblSales
(
  SalesID int primary key identity (1, 1),
  Vehicle int references tblVehicle(VehicleID),
  Customer int references tblCustomer(CustomerID),
  Showroom int references tblShowroom(ShowroomID),
  SalePrice int,
  Tax int references tblTax(TaxID),
  OrderDate date,
  DeliveryDate date,
  SalesDescription nvarchar(150)
)

-- create ExpenceCategory table
create table tblExpenceCategory
(
  ExpenceCategoryID int primary key identity(1, 1),
  ExpenceCategory nvarchar(150)
)


-- create table tblExpence
create table tblExpence
(
  ExpenceID int primary key identity(1, 1),
  ShowroomID int references tblShowroom(ShowroomID),
  ExpenceName nvarchar(150),
  ExpenceAmount nvarchar(150),
  ExpenceCreated date,
  ExpenceCategory int references tblExpenceCategory(ExpenceCategoryID)
)

-- create Stock Table
create table tblStock
(
  StockID int primary key identity (1, 1),
  VehicleID int references tblVehicle(VehicleID),
  AvaliableQuantity int
)

-- create table Service Type
create table tblServiceType
(
  ServiceTypeID int primary key identity(1, 1),
  ServiceType nvarchar(150),
  ServiceAmount int,
  VehicleType nvarchar(150)
)

-- create Service table
create table tblService
(
  ServiceID int primary key identity (1, 1),
  ShowroomID int references tblShowroom(ShowroomID),
  ServiceTypeID int references tblServiceType(ServiceTypeID),
  VehicleName nvarchar(150),
  VehicleNo nvarchar(150),
  ServiceDate date
)

-- create table SpareProducts
create table tblSpareProduct
(
  SpareProductID int primary key identity (1, 1),
  ShowroomID int references tblShowroom(ShowroomID),
  ProductName nvarchar(150),
  ProductType nvarchar(150),
  ProductWeight nvarchar(150),
  ProductDimensions nvarchar(150),
  ProductStrenght nvarchar(150),
  Quantity nvarchar(150),
  ExpiryDate nvarchar(150)
)

----------------------------------------------- Admin Table -----------------------------------------------
--------------------------------------------- Insert Admin Record ---------------------------------------------
create procedure SP_InsertAdminRecord
(
  @name nvarchar(150),
  @username nvarchar(150),
  @password nvarchar(150),
  @lastlogin date
)
as
begin
  insert into tblAdmin(AdminName, Username, AdminPassword, lastLogin)
  values (@name, @username, @password, @lastlogin)
end

select * from tblAdmin

--------------------------------------------- Update Admin Record ---------------------------------------------
create proc SP_UpadteAdminRecord
(
  @id int,
  @name nvarchar(150),
  @username nvarchar(150),
  @pass nvarchar(150),
  @login nvarchar(150)
)
as
begin
  update tblAdmin set AdminName = @name, Username = @username, AdminPassword = @pass, lastLogin = @login
  where AdminID = @id
end

exec SP_UpadteAdminRecord 1, 'MuzamilKhan', 'MK', '123', '2222-12-22'

exec SP_InsertAdminRecord 'MuzamilKhan', 'MK', '123', '2222-12-22'


--------------------------------------------- Delete Admin Record ---------------------------------------------

create proc SP_DeleteAdminRecord
(
  @id int
)
as
begin
  delete from tblAdmin where tblAdmin.AdminID = @id
end

exec SP_DeleteAdminRecord 1

select * from tblAdmin




----------------------------------------------- Customer Table -----------------------------------------------
--------------------------------------------- Insert Customer Record ---------------------------------------------
create procedure SP_InsertCustomer
(
  @id int,
  @fn nvarchar(150),
  @ln nvarchar(150),
  @cn nvarchar(150),
  @email nvarchar(150),
  @pass nvarchar(150),
  @city nvarchar(150),
  @address nvarchar(150),
  @pincode nvarchar(150),
  @gender nvarchar(150),
  @createdate date,
  @login datetime
)
as
begin
  insert into tblCustomer(FirstName, LastName, ContactNo, Email, CustomerPassword, City, CustomerAddress, CustomerPincode, Gender, CreateDate, LastLogin)
  values(@fn, @ln, @cn, @email, @pass,@city,@address,@pincode,@gender,@createdate,@login)
end

execute SP_InsertCustomer 'Ahmed','Khan', '+92 3363506933', 'Ahmed@gmail.com', 'mk', 'Karachi', 'Hashim Raza Road', '7400',
'Male', '2022-1-1', '2022-1-1'
select * from tblCustomer

--------------------------------------------- Update Customer Record ---------------------------------------------

create procedure SP_UpdateCustomer
(
  @id int,
  @fn nvarchar(150),
  @ln nvarchar(150),
  @cn nvarchar(150),
  @email nvarchar(150),
  @pass nvarchar(150),
  @city nvarchar(150),
  @address nvarchar(150),
  @pincode nvarchar(150),
  @gender nvarchar(150),
  @createdate date,
  @login datetime
)
as
begin
  update tblCustomer set FirstName = @fn, LastName = @ln, ContactNo = @cn, Email = @email, CustomerPassword = @pass,
  City = @city, CustomerAddress = @address, CustomerPincode = @pincode, Gender = @gender, CreateDate = @createdate,
  LastLogin = @login where CustomerID = @id
end

exec SP_UpdateCustomer 2, 'Salman', 'Khan', '123', 'salman123@gmail.com', 'salman', 'Karachi', 'Hashim Raza Road', '7400',
'Male', '2022-1-1', '2022-1-1'


--------------------------------------------- Delete Customer Record ---------------------------------------------

create proc SP_DeleteCustomerRecord
(
  @id int
)
as
begin
  delete from tblCustomer where tblCustomer.CustomerID = @id
end

exec SP_DeleteCustomerRecord 2

select * from tblCustomer

----------------------------------------------- Dealer Table -----------------------------------------------
--------------------------------------------- Insert Dealer Record ---------------------------------------------


create proc SP_InsertDealerRecord
(
  @adminid int,
  @name nvarchar(150),
  @cn nvarchar(150),
  @address nvarchar(150),
  @uern nvarchar(150),
  @pass nvarchar(150),
  @create nvarchar(150),
  @lastlog nvarchar(150),
  @dealerimagename nvarchar(150),
  @dealerimagepath nvarchar(150)
)
as
begin
  insert into tblDealer (AdminID, DealerName, ContactNo, DealerAddress, Username, DealerPassword, 
                         CreateDate, LastLogin, DealerImageName, DealerImagePath)
						 values (@adminid, @name, @cn, @address, @uern, @pass, @create, @lastlog, @dealerimagename,
						 @dealerimagepath)
end



exec SP_InsertDealerRecord 1, 'Ahmed', '123', 'Korangi', 'ahmed', '123', '2022-01-01', '2022-01-01', null, null

--------------------------------------------- Update Dealer Record ---------------------------------------------
create proc SP_updateDealerRecord
(
  @id int,
  @adminid int,
  @name nvarchar(150),
  @contact nvarchar(150),
  @address nvarchar(150),
  @username nvarchar(150),
  @pass nvarchar(150),
  @createedate nvarchar(150),
  @lastlog nvarchar(150),
  @imagename nvarchar(150),
  @imagepath nvarchar(150)
)
as
begin
  update tblDealer set AdminID = @id, DealerName = @name, ContactNo = @contact, DealerAddress = @address, Username = @username,
  DealerPassword = @pass, CreateDate = @createedate, LastLogin = @lastlog, DealerImageName = @imagename, DealerImagePath = @imagepath
  where DealerID = @id
end

exec SP_updateDealerRecord 3, 1, 'Ahmed', '1234', 'Korangi', 'ahmed', '123', '2022-01-01', '2022-01-01', null, null


select * from tblDealer

--------------------------------------------- Delete Dealer Record ---------------------------------------------

create proc SP_DeleteDealerRecord
(
  @id int
)
as
begin
  delete from tblDealer where tblDealer.DealerID = @id
end

exec SP_DeleteDealerRecord 2

select * from tblDealer

------------------------------------------- Join Dealer & Vendor Table -------------------------------------------
create proc SP_DisplayDealerRecord
as
begin

select tblDealer.DealerID, tblAdmin.AdminName,tblDealer.DealerName,tblDealer.ContactNo, tblDealer.DealerAddress,
tblDealer.Username,tblDealer.DealerPassword, tblDealer.CreateDate,tblDealer.LastLogin,
tblDealer.DealerImageName,tblDealer.DealerImagePath from tblDealer inner join tblAdmin on tblDealer.AdminID = tblAdmin.AdminID
end

exec SP_DisplayDealerRecord

select * from tblDealer

----------------------------------------------- Vehicle Table -----------------------------------------------
--------------------------------------------- Insert Vehicle Record ---------------------------------------------

create proc SP_InsertVehicleRecord
(
  @dealer int,
  @vehicle nvarchar(150),
  @model nvarchar(150),
  @type nvarchar(150),
  @desc nvarchar(150),
  @cost int,
  @qty int,
  @createdate date
)
as
begin
  insert into tblVehicle (Dealer, VehicleName, Model, VehicleType, VehicleDescription, VehileCost, Quantity, CreateDate)
  values (@dealer, @vehicle, @model, @type, @desc, @cost, @qty, @createdate)
end

exec SP_InsertVehicleRecord 2, 'Civic', 'X', 'Sedan', 'Black Color Designed', 100, 12, '2022-01-01'

select * from tblVehicle
select * from tblDealer


--------------------------------------------- Update Vehicle Record ---------------------------------------------

create proc SP_UpdateVehicleRecord
(
  @id int,
  @dealer int,
  @vehicle nvarchar(150),
  @model nvarchar(150),
  @type nvarchar(150),
  @desc nvarchar(150),
  @cost int,
  @qty int,
  @createdate date
)
as
begin
  update tblVehicle set Dealer = @dealer, VehicleName = @vehicle, Model = @model, VehicleType = @type,
  VehicleDescription = @desc, VehileCost = @cost, Quantity = @qty, CreateDate =@createdate where VehicleID = @id
end

exec SP_UpdateVehicleRecord 1, 2, 'Civic', 'Turbo', 'Sedan', 'Black Color Designed', 100, 12, '2022-01-01'


--------------------------------------------- Delete Vehicle Record ---------------------------------------------
create proc SP_DeleteVehicleRecord
(
  @id int
)
as
begin
  delete from tblVehicle where tblVehicle.VehicleID = @id
end

exec SP_DeleteVehicleRecord 1

select * from tblVehicle
select * from tblDealer

--------------------------------------------- Join Vehicle And Dealer Record ---------------------------------------------
create proc SP_DisplayVehicleRecord
as
begin

  select tblVehicle.VehicleID, tblDealer.DealerName,tblVehicle.VehicleName,tblVehicle.Model,tblVehicle.VehicleType,tblVehicle.VehicleType,
  tblVehicle.VehileCost, tblVehicle.Quantity,tblVehicle.CreateDate from tblVehicle
  inner join tblDealer on tblVehicle.Dealer = tblDealer.DealerID

end

exec SP_DisplayVehicleRecord


select * from tblVehicle
select * from tblDealer


----------------------------------------------- Image Table -----------------------------------------------
--------------------------------------------- Insert Image Record ---------------------------------------------

create proc SP_InsertImageRecord
(
  @imagename nvarchar(150),
  @vehicle int,
  @imagepath nvarchar(150)
)
as
begin
  insert into tblImage (ImageName, Vehicle, ImagePath) values (@imagename, @vehicle, @imagepath)
end

exec SP_InsertImageRecord 'abc.png', 1, '~/UploadFiles/abc.png'

select * from tblImage


--------------------------------------------- Update Image Record ---------------------------------------------

create proc SP_UpdateImageRecord
(
  @id int,
  @imagename nvarchar(150),
  @vehicle int,
  @imagepath nvarchar(150)
)
as
begin
  update tblImage set ImageName = @imagename, Vehicle = @vehicle, ImagePath = @imagepath where ImageID = @id
end

exec SP_UpdateImageRecord 1, 'abcd.png', 1, '~/UploadFiles/abcd.png'

select * from tblImage

--------------------------------------------- Delete Image Record ---------------------------------------------

create proc SP_DeleteImageRecord
(
  @id int
)
as
begin
  delete from tblImage where tblImage.ImageID = @id
end

exec SP_DeleteImageRecord 2

select * from tblImage


--------------------------------------------- Join Vehicle Table From Image Image Record ---------------------------------------------
create proc SP_DisplayImageRecord
as
begin
  select tblImage.ImageID, tblImage.ImageName, tblVehicle.VehicleName, tblImage.ImagePath from tblImage
  inner join tblVehicle on tblImage.Vehicle = tblVehicle.VehicleID
end

exec SP_DisplayImageRecord
select * from tblImage


----------------------------------------------- Showroom Table -----------------------------------------------
--------------------------------------------- Insert Showroom Record ---------------------------------------------

create proc SP_InsertShowroomRecord
(
  @dealer int,
  @name nvarchar(150),
  @cn nvarchar(150),
  @address nvarchar(150),
  @city nvarchar(150),
  @state nvarchar(150),
  @pincode nvarchar(150),
  @imagename nvarchar(150),
  @imagepath nvarchar(150)
)
as
begin
  insert into tblShowroom (Dealer, ShowroomName, ContactNo, ShowroomAddress, City, ShowroomState, Pincode, ImageName, ImagePath)
  values (@dealer, @name, @cn, @address, @city, @state, @pincode, @imagename, @imagepath)
end

exec SP_InsertShowroomRecord 2, 'MK Showroom', '123', 'Airport', 'Karachi', 'Sindh Karachi', '7400', null, null

select * from tblShowroom


--------------------------------------------- Update Showroom Record ---------------------------------------------

create proc SP_UpdateShowroomRecord
(
  @id int,
  @dealer int,
  @name nvarchar(150),
  @cn nvarchar(150),
  @address nvarchar(150),
  @city nvarchar(150),
  @state nvarchar(150),
  @pincode nvarchar(150),
  @imagename nvarchar(150),
  @imagepath nvarchar(150)
)
as
begin
  update tblShowroom set Dealer = @dealer, ShowroomName = @name, ContactNo = @cn, ShowroomAddress = @address, City = @city,
  ShowroomState = @state, Pincode = @pincode, ImageName = @imagename, ImagePath = @imagepath
end

exec SP_UpdateShowroomRecord 1, 2, 'Khan Showroom', '123', 'Airport', 'Karachi', 'Sindh Karachi', '7400', null, null
select * from tblShowroom

----------------------------------------------- Showroom Table -----------------------------------------------
--------------------------------------------- Delete Showroom Record ---------------------------------------------

create proc SP_DeleteShowroomRecord
(
  @id int
)
as
begin
  delete from tblShowroom where tblShowroom.ShowroomID = @id
end

exec SP_DeleteShowroomRecord 1

select * from tblShowroom

--------------------------------------------- Join Showroom And Admin Record ---------------------------------------------

create proc SP_DisplayShowroomRecord
as
begin

select tblShowroom.ShowroomID, tblDealer.DealerName, tblShowroom.ShowroomName, tblShowroom.ContactNo, tblShowroom.ShowroomAddress,
tblShowroom.City, tblShowroom.ShowroomState, tblShowroom.Pincode, tblShowroom.ImageName, tblShowroom.ImagePath from tblShowroom
inner join tblDealer on tblShowroom.Dealer = tblDealer.DealerID

end

exec SP_DisplayShowroomRecord

select * from tblShowroom


--------------------------------------------- Insert Expence Category Record ---------------------------------------------
-- first we insert data in category form
create proc SP_InsertExpenceCategory
(
  @expcat nvarchar(150)
)
as
begin
  insert into tblExpenceCategory(ExpenceCategory)
  values (@expcat)
end

exec SP_InsertExpenceCategory 'Bill'


select * from tblExpenceCategory
--------------------------------------------- Update Expence Category Record ---------------------------------------------
create proc SP_UpdateExpenceCategory
(
  @id int,
  @expcat nvarchar(150)
)
as
begin
  update tblExpenceCategory set ExpenceCategory = @expcat where ExpenceCategoryID = @id
end

exec SP_UpdateExpenceCategory 1, 'Misc'

select * from tblExpenceCategory

--------------------------------------------- Delete Expence Category Record ---------------------------------------------
create proc SP_DeleteExpenceCategory
(
  @id int
)
as
begin
  delete from tblExpenceCategory where ExpenceCategoryID = @id
end

exec SP_DeleteExpenceCategory 1

select * from tblExpenceCategory


--------------------------------------------- Insert Expence Record ---------------------------------------------


create proc SP_InsertExpence
(
  @Sid int,
  @Expname nvarchar(150),
  @amount nvarchar(150),
  @expcreate nvarchar(150),
  @expcat int
)

as
begin
  insert into tblExpence (ShowroomID, ExpenceName, ExpenceAmount, ExpenceCreated, ExpenceCategory) values (@Sid, @Expname, @amount, @expcreate, @expcat)
end

exec SP_InsertExpence 1, 'Misc Charges', '1222', '12-12-2000', 1

select * from tblExpence
select * from tblShowroom

--------------------------------------------- Update Expence Record ---------------------------------------------

create proc SP_UpdateExpence
(
  @id int,
  @Sid int,
  @Expname nvarchar(150),
  @amount nvarchar(150),
  @expcreate nvarchar(150),
  @expcat int
)
as
begin
  update tblExpence set ShowroomID = @Sid, ExpenceName = @Expname, ExpenceCreated = @expcreate, ExpenceCategory = @expcat where ExpenceID = @id
end

exec SP_UpdateExpence 1, 1, 'Misc Charging', '1222', '12-12-2000', 1

--------------------------------------------- Delete Expence Record ---------------------------------------------
create proc SP_DeleteExpence
(
  @id int
)
as
begin
  delete from tblExpence where ExpenceID = @id
end

exec SP_DeleteExpence 1

select * from tblExpence

--------------------------------------------- Inner join Expence & Expence Category Record ---------------------------------------------
create proc SP_DisplayExpenceRecord
as
begin
  select tblShowroom.ShowroomName, tblExpence.ExpenceName, tblExpence.ExpenceAmount, tblExpence.ExpenceCategory, tblExpence.ExpenceCategory
  from tblExpence inner join tblShowroom on tblExpence.ShowroomID = tblShowroom.ShowroomID
end

exec SP_DisplayExpenceRecord

select * from tblExpence

--------------------------------------------- Insert Service Type Record ---------------------------------------------
create proc SP_InsertServiceType
(
  @type nvarchar(150),
  @amount int,
  @Vtype nvarchar(150)
)

as
begin
  insert into tblServiceType (ServiceType, ServiceAmount, VehicleType) values (@type, @amount, @Vtype)
end

exec SP_InsertServiceType 'Body Wash', 500, 'Bolan'

--------------------------------------------- Update Service Type Record ---------------------------------------------
create proc SP_UpdateServiceType
(
  @id int,
  @type nvarchar(150),
  @amount int,
  @Vtype nvarchar(150)
)

as
begin
  update tblServiceType set ServiceType = @id, ServiceAmount = @type, VehicleType = @Vtype where ServiceTypeID = @id
end

exec SP_UpdateServiceType 1, 'Body Wash', 200, 'Bolan'

select * from tblServiceType

--------------------------------------------- Delete Service Type Record ---------------------------------------------

create proc SP_DeleteServiceType
(
  @id int
)
as
begin
  delete from tblServiceType where ServiceTypeID = @id
end

exec SP_DeleteServiceType 1


select * from tblServiceType

--------------------------------------------- Insert Service Record ---------------------------------------------
create proc SP_InsertService
(
  @Showid int,
  @service int,
  @vname nvarchar(150),
  @Vehicleno nvarchar(150),
  @date date
)

as
begin
  
  insert into tblService (ShowroomID, ServiceTypeID, VehicleName, VehicleNo, ServiceDate)
  values (@Showid, @service, @vname, @Vehicleno, @date)

end

exec SP_InsertService 1, 1, 'Suzuki', 'CAD-123', '12-12-2000'

select * from tblServiceType
select * from tblService

--------------------------------------------- Update Service Record ---------------------------------------------

create proc SP_UpdateService
(
  @id int,
  @Showid int,
  @service int,
  @vname nvarchar(150),
  @Vehicleno nvarchar(150),
  @date date
)

as
begin
  
  update tblService set ShowroomID = @id, ServiceTypeID = @Showid, VehicleName = @vname, VehicleNo = @Vehicleno,
  ServiceDate = @date where ServiceID = @id
end

exec SP_UpdateService 1, 1, 1, 'Suzuki', 'CAD-123', '12-12-2000' 

select * from tblServiceType
select * from tblService

--------------------------------------------- Delete Service Record ---------------------------------------------

create proc SP_DeleteService
(
  @id int
)
as
begin
  delete from tblService where ServiceID = @id
end

exec SP_DeleteService 1

select * from tblServiceType
select * from tblService

--------------------------------------------- Inner Join Service Service Type And Showroom Record ---------------------------------------------

create proc SP_DisplayServiceRecord
as
begin
  select tblService.ServiceID, tblShowroom.ShowroomName, tblServiceType.ServiceType, tblService.VehicleName, tblService.VehicleNo,
  tblService.ServiceDate from tblService
  inner join tblShowroom on tblService.ShowroomID = tblShowroom.ShowroomID
  inner join tblServiceType on tblService.ServiceID = tblServiceType.ServiceTypeID
end

select * from tblServiceType
select * from tblService
--------------------------------------------- Insert Spare Product Record ---------------------------------------------


create trigger [dbo].[TG_ProductRecord] On [dbo].[tblSpareProduct]
after insert
as
begin
  set nocount on;
  Declare @SPID int, @Showid int, @Pn nvarchar(150), @ptype nvarchar(150), @pweight nvarchar(150), @pdimension nvarchar(150),
  @pstr nvarchar(150), @qty nvarchar(150), @expdate date

  select @SPID = inserted.SpareProductID, @Showid = inserted.ShowroomID, @Pn = ProductName, @ptype = inserted.ProductType, 
  @pweight = inserted.ProductWeight, @pdimension = inserted.ProductDimensions,
  @pstr = inserted.ProductStrenght, @qty = inserted.Quantity, @expdate = inserted.ExpiryDate from inserted

  insert into tblSpareProduct values (@SPID, @Showid, @Pn, @ptype, @pweight, @pdimension, @pstr, @qty, @expdate)

end

exec TG_ProductRecord 1, 1, 'Screw', 'Bold', '12KG', '2rem', '12fr', '100', '12-12-2000'

select * from tblSpareProduct

--------------------------------------------- Insert Spare Product Record ---------------------------------------------

create proc SP_InsertProduct
(
  @Showid int,
  @pn nvarchar(150),
  @ptype nvarchar(150),
  @pweight nvarchar(150),
  @pdim nvarchar(150),
  @pstr nvarchar(150),
  @qty nvarchar(150),
  @expdate date
)

as
begin
  
  insert into tblSpareProduct (ShowroomID, ProductName, ProductType, ProductWeight, ProductDimensions, ProductStrenght, Quantity,
  ExpiryDate) values (@Showid, @pn, @ptype, @pweight, @pdim, @pstr, @qty, @expdate)
end

exec SP_InsertProduct 1, 'Screw', 'Bold', '12KG', '2rem', '12fr', '100', '12-12-2000'

select * from tblSpareProduct

--------------------------------------------- Update Spare Product Record ---------------------------------------------

create proc SP_UpdateProduct
(
  @id int,
  @Showid int,
  @pn nvarchar(150),
  @ptype nvarchar(150),
  @pweight nvarchar(150),
  @pdim nvarchar(150),
  @pstr nvarchar(150),
  @qty nvarchar(150),
  @expdate date
)

as
begin
  
  update tblSpareProduct set SpareProductID = @id, ShowroomID = @Showid, ProductName = @pn,
  ProductWeight = @pweight, ProductDimensions = @pdim, ProductStrenght = @pstr, Quantity = @qty, ExpiryDate = @expdate
  where SpareProductID = @id
end

exec SP_UpdateProduct 1, 1, 'Screw', 'Bold', '12KG', '2rem', '12fr', '100', '12-12-2000'



select * from tblSpareProduct

--------------------------------------------- Delete Spare Product Record ---------------------------------------------

create proc SP_DeleteSpareProduct
(
  @id int
)
as
begin
  delete from tblSpareProduct where SpareProductID = @id
end

exec SP_DeleteSpareProduct 1

select * from tblSpareProduct


--------------------------------------------- Display Spare Product & Showroom Record ---------------------------------------------

create proc SP_DisplaySpareProductRecord
as
begin
  select tblSpareProduct.SpareProductID, tblShowroom.ShowroomName, tblSpareProduct.ProductName, tblSpareProduct.ProductType,
  tblSpareProduct.ProductWeight, tblSpareProduct.ProductDimensions, tblSpareProduct.ProductStrenght, tblSpareProduct.Quantity,
  tblSpareProduct.ExpiryDate from tblSpareProduct inner join tblShowroom on tblSpareProduct.ShowroomID = tblShowroom.ShowroomID
end

exec SP_DisplaySpareProductRecord
select * from tblSpareProduct


--------------------------------------------- Insert Tax Record ---------------------------------------------

create proc SP_TaxInsert
(
  @desc nvarchar(150),
  @tax int
)
as
begin
  insert into tblTax (TaxDescripion, Tax) values (@desc, @tax)
end

exec SP_TaxInsert 'FBR', 120000 

select * from tblTax

--------------------------------------------- Update Tax Record ---------------------------------------------

create proc SP_TaxUpdate
(
  @id int,
  @desc nvarchar(150),
  @tax int
)
as
begin
  update tblTax set TaxDescripion = @desc , Tax = @tax where TaxID = @id
end

exec SP_TaxUpdate 1, 'FBR', 120000 

select * from tblTax


--------------------------------------------- Delete Tax Record ---------------------------------------------

create proc SP_DeleteTax
(
  @id int
)

as
begin
  delete from tblTax where TaxID = @id
end

exec SP_DeleteTax 1

select * from tblTax


--------------------------------------------- Insert Sales Record ---------------------------------------------


select * from tblVehicle
select * from tblSales

create proc SP_InsertSales
(
  @vehid int,
  @cusid int,
  @showid int,
  @salep int,
  @tax int,
  @ordate date,
  @deldate date,
  @saleDesc nvarchar(150)
)
as
begin

  insert into tblSales (Vehicle, Customer, Showroom, SalePrice, Tax, OrderDate, DeliveryDate, SalesDescription)
  values (@vehid, @cusid, @showid, @salep, @tax, @ordate, @deldate, @saleDesc)

end

exec SP_InsertSales 1, 1, 1, 12000, 1, '12-12-2000', '12-12-2000', 'Sales Hogyi Iski'
select * from tblSales

select * from tblVehicle
select * from tblCustomer
select * from tblShowroom

--------------------------------------------- Update Sales Record ---------------------------------------------
create proc SP_UpdateSalesRec
(
  @id int,
  @vehid int,
  @cusid int,
  @showid int,
  @salep int,
  @tax int,
  @ordate date,
  @deldate date,
  @saleDesc nvarchar(150)
)
as
begin

  update tblSales set Vehicle = @vehid, Customer = @cusid, Showroom = @showid, SalePrice = @salep,
  Tax = @tax, Orderdate = @ordate, DeliveryDate = @deldate, SalesDescription = @saleDesc where SalesID = @id

end

exec SP_UpdateSalesRec 1, 1, 1, 1, 12000, 1, '12-12-2000', '12-12-2000', 'Sales Hogyi Iski'

select * from tblSales

--------------------------------------------- Delete Sales Record ---------------------------------------------
create proc SP_DeleteSales
(
  @id int
)
as
begin
  delete from tblSales where SalesID = @id
end

exec SP_DeleteSales 1
select * from tblSales

--------------------------------------------- Show Sales Record ---------------------------------------------

create proc SP_DisplaySaleRecord
as
begin
  select tblSales.SalesID, tblVehicle.VehicleName, tblCustomer.CustomerID, tblCustomer.FirstName, tblCustomer.LastName,
  tblCustomer.Email, tblShowroom.ShowroomName, tblTax.TaxDescripion, tblSales.OrderDate, tblSales.DeliveryDate, tblSales.SalesDescription
  from tblSales
  inner join tblVehicle on tblSales.Vehicle = tblVehicle.VehicleID
  inner join tblCustomer on tblSales.Customer = tblCustomer.CustomerID
  inner join tblShowroom on tblSales.Showroom = tblShowroom.ShowroomID
  inner join tblTax on tblSales.Tax = tblTax.TaxID
end

exec SP_DisplaySaleRecord

select * from tblSales

--------------------------------------------- Insert Stock Record ---------------------------------------------
create proc SP_InsertStockResult
(
  @VehID int,
  @Qty int
)
as
begin
  insert into tblStock (VehicleID, AvaliableQuantity) values (@VehID, @Qty)
end

exec SP_InsertStockResult 1, 120
select * from tblStock

--------------------------------------------- Update Stock Record ---------------------------------------------
create proc SP_UpdateStockResult
(
  @id int,
  @VehID int,
  @Qty int
)
as
begin
  update tblStock set VehicleID = @VehID, AvaliableQuantity = @Qty where StockID = @id
end

exec SP_UpdateStockResult 1, 1, 125

select * from tblStock

--------------------------------------------- Delete Stock Record ---------------------------------------------

create proc SP_DeleteStock
(
  @id int
)
as
begin
  delete from tblStock where StockID = @id
end


exec SP_DeleteStock 1

select * from tblStock

--------------------------------------------- Show Stock Record ---------------------------------------------

select * from tblStock

create proc SP_DislayStockResult
as
begin
  select tblStock.StockID, tblVehicle.VehicleName, tblVehicle.Quantity from tblStock
  inner join tblVehicle on tblStock.VehicleID = tblVehicle.VehicleID
end

------------------------------------------ --------------------THE END -----------------------------------------------------


select * from tblAdmin
select * from tblDealer   

select tblDealer.DealerID,tblAdmin.AdminName, tblDealer.ContactNo from tblDealer
inner join tblAdmin on tblDealer.AdminID = tblAdmin.AdminID


------------------------------------------------------ Insert Data ------------------------------------------------------

exec SP_DislayStockResult


create proc DisplayAdmin
as
begin
select * from tblAdmin
end


select * from tblAdmin
