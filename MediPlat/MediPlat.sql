﻿CREATE DATABASE MediPlat
GO
USE MediPlat
GO

CREATE TABLE "Patient" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "UserName" NVARCHAR(255),
  "FullName" NVARCHAR(255),
  "Email" NVARCHAR(255),
  "Password" NVARCHAR(255),
  "PhoneNumber" NVARCHAR(20),
  "Balance" DECIMAL(12,2) DEFAULT 0,
  "JoinDate" DATETIME DEFAULT GETDATE(),
  "Sex" NVARCHAR(50),
  "Address" NVARCHAR(MAX),
  "Status" NVARCHAR(50)
);

CREATE TABLE "Specialty" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "Name" NVARCHAR(255),
  "Description" NVARCHAR(MAX)
);

CREATE TABLE "Experience" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "SpecialtyID" UNIQUEIDENTIFIER,
  "Title" NVARCHAR(255),
  "Description" NVARCHAR(MAX),
  "Certificate" NVARCHAR(MAX),
  "DoctorID" UNIQUEIDENTIFIER
);

CREATE TABLE "Doctor" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "UserName" NVARCHAR(255),
  "FullName" NVARCHAR(255),
  "Email" NVARCHAR(255),
  "Password" NVARCHAR(255),
  "AvatarUrl" NVARCHAR(MAX),
  "Balance" DECIMAL(12,2) DEFAULT 0,
  "FeePerHour" DECIMAL(12,2),
  "Degree" NVARCHAR(255),
  "AcademicTitle" NVARCHAR(255),
  "JoinDate" DATETIME DEFAULT GETDATE(),
  "PhoneNumber" NVARCHAR(50),
  "Status" NVARCHAR(50)
);

CREATE TABLE "Subscription" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "Name" NVARCHAR(255),
  "Price" DECIMAL(18,2),
  "EnableSlot" TINYINT,
  "Description" NVARCHAR(MAX),
  "CreatedDate" DATETIME DEFAULT GETDATE(),
  "UpdateDate" DATETIME
);

CREATE TABLE "DoctorSubscription" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "SubscriptionID" UNIQUEIDENTIFIER,
  "EnableSlot" SMALLINT,
  "DoctorID" UNIQUEIDENTIFIER,
  "StartDate" DATETIME DEFAULT GETDATE(),
  "EndDate" DATETIME,
  "UpdateDate" DATETIME,
  "Status" NVARCHAR(20) CHECK ("Status" IN (N'Active', N'Inactive'))
);

CREATE TABLE "Services" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "SpecialtyID" UNIQUEIDENTIFIER,
  "Title" NVARCHAR(255),
  "Description" NVARCHAR(MAX)
);

CREATE TABLE "Slot" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "DoctorID" UNIQUEIDENTIFIER,
  "ServiceID" UNIQUEIDENTIFIER,
  "Title" NVARCHAR(255),
  "Description" NVARCHAR(MAX),
  "StartTime" DATETIME,
  "EndTime" DATETIME,
  "Date" DATETIME,
  "SessionFee" DECIMAL(12,2),
  "Status" NVARCHAR(50)
);

CREATE TABLE "AppointmentSlot" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "SlotID" UNIQUEIDENTIFIER,
  "PatientID" UNIQUEIDENTIFIER,
  "Status" NVARCHAR(50)
);

CREATE TABLE "Transaction" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "PatientID" UNIQUEIDENTIFIER,
  "DoctorID" UNIQUEIDENTIFIER,
  "SubID" UNIQUEIDENTIFIER,
  "AppointmentSlotID" UNIQUEIDENTIFIER,
  "TransactionInfo" NVARCHAR(MAX),
  "Amount" DECIMAL(18,2),
  "CreatedDate" DATETIME DEFAULT GETDATE(),
  "Status" NVARCHAR(50)
);

CREATE TABLE "Review" (
  "ID" UNIQUEIDENTIFIER PRIMARY KEY,
  "Rating" INT,
  "Message" NVARCHAR(MAX),
  "PatientID" UNIQUEIDENTIFIER,
  "DoctorID" UNIQUEIDENTIFIER,
  "SlotID" UNIQUEIDENTIFIER
);

ALTER TABLE "Experience" ADD FOREIGN KEY ("SpecialtyID") REFERENCES "Specialty" ("ID");

ALTER TABLE "Experience" ADD FOREIGN KEY ("DoctorID") REFERENCES "Doctor" ("ID");

ALTER TABLE "DoctorSubscription" ADD FOREIGN KEY ("SubscriptionID") REFERENCES "Subscription" ("ID");

ALTER TABLE "DoctorSubscription" ADD FOREIGN KEY ("DoctorID") REFERENCES "Doctor" ("ID");

ALTER TABLE "Services" ADD FOREIGN KEY ("SpecialtyID") REFERENCES "Specialty" ("ID");

ALTER TABLE "Slot" ADD FOREIGN KEY ("DoctorID") REFERENCES "Doctor" ("ID");

ALTER TABLE "Slot" ADD FOREIGN KEY ("ServiceID") REFERENCES "Services" ("ID");

ALTER TABLE "AppointmentSlot" ADD FOREIGN KEY ("SlotID") REFERENCES "Slot" ("ID");

ALTER TABLE "AppointmentSlot" ADD FOREIGN KEY ("PatientID") REFERENCES "Patient" ("ID");

ALTER TABLE "Transaction" ADD FOREIGN KEY ("AppointmentSlotID") REFERENCES "AppointmentSlot" ("ID");

ALTER TABLE "Transaction" ADD FOREIGN KEY ("SubID") REFERENCES "Subscription" ("ID");

ALTER TABLE "Transaction" ADD FOREIGN KEY ("PatientID") REFERENCES "Patient" ("ID");

ALTER TABLE "Transaction" ADD FOREIGN KEY ("DoctorID") REFERENCES "Doctor" ("ID");

ALTER TABLE "Review" ADD FOREIGN KEY ("PatientID") REFERENCES "Patient" ("ID");

ALTER TABLE "Review" ADD FOREIGN KEY ("DoctorID") REFERENCES "Doctor" ("ID");

ALTER TABLE "Review" ADD FOREIGN KEY ("SlotID") REFERENCES "Slot" ("ID");


INSERT INTO Doctor(ID, UserName, FullName, Email, Password, AvatarUrl, Balance, FeePerHour, Degree, AcademicTitle, JoinDate, PhoneNumber, Status)
VALUES
	(NEWID(), N'tuanntase140515', N'Nguyễn Thanh Anh Tuấn', 'tuanntase140515@gmail.com', N'123456', CONCAT('https://api.dicebear.com/7.x/pixel-art/png?seed=', CAST(NEWID() AS NVARCHAR(50))), 10000.00, 10000.00, N'Bác sĩ Đa Khoa', N'Giáo Sư', GETDATE(), '0705543619', 'Active');