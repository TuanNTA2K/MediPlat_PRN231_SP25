CREATE DATABASE MediPlat
GO
USE MediPlat
GO

CREATE TABLE [Patient] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [UserName] NVARCHAR(255),
  [FullName] NVARCHAR(255),
  [Email] NVARCHAR(255),
  [Password] NVARCHAR(255),
  [PhoneNumber] NVARCHAR(20),
  [Balance] DECIMAL(12,2) DEFAULT (0),
  [JoinDate] DATETIME DEFAULT (GETDATE()),
  [Sex] NVARCHAR(50),
  [Address] NVARCHAR(MAX),
  [Status] NVARCHAR(50)
)
GO

CREATE TABLE [Specialty] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [Name] NVARCHAR(255),
  [Description] NVARCHAR(MAX)
)
GO

CREATE TABLE [Experience] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [SpecialtyID] UNIQUEIDENTIFIER,
  [Title] NVARCHAR(255),
  [Description] NVARCHAR(MAX),
  [Certificate] NVARCHAR(MAX),
  [DoctorID] UNIQUEIDENTIFIER
)
GO

CREATE TABLE [Doctor] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [UserName] NVARCHAR(255),
  [FullName] NVARCHAR(255),
  [Email] NVARCHAR(255),
  [Password] NVARCHAR(255),
  [AvatarUrl] NVARCHAR(MAX),
  [Balance] DECIMAL(12,2) DEFAULT (0),
  [FeePerSession] DECIMAL(12,2),
  [Degree] NVARCHAR(255),
  [AcademicTitle] NVARCHAR(255),
  [JoinDate] DATETIME DEFAULT (GETDATE()),
  [PhoneNumber] NVARCHAR(50),
  [Status] NVARCHAR(50)
)
GO

CREATE TABLE [Subscription] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [Name] NVARCHAR(255),
  [Price] DECIMAL(18,2),
  [EnableSlot] TINYINT,
  [Description] NVARCHAR(MAX),
  [UpdateDate] DATETIME null
)
GO

CREATE TABLE [DoctorSubscription] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [SubscriptionID] UNIQUEIDENTIFIER,
  [EnableSlot] TINYINT,
  [StartDate] DATETIME DEFAULT (GETDATE()),
  [EndDate] DATETIME,
  [UpdateDate] DATETIME null,
  [DoctorID] UNIQUEIDENTIFIER
)
GO

CREATE TABLE [Services] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [SpecialtyID] UNIQUEIDENTIFIER,
  [Title] NVARCHAR(255),
  [Description] NVARCHAR(MAX)
)
GO

CREATE TABLE [Slot] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [DoctorID] UNIQUEIDENTIFIER,
  [ServiceID] UNIQUEIDENTIFIER,
  [SpecialtyID] UNIQUEIDENTIFIER,
  [Title] NVARCHAR(255),
  [Description] NVARCHAR(MAX),
  [StartTime] DATETIME,
  [EndTime] DATETIME,
  [Date] DATETIME,
  [SessionFee] DECIMAL(12,2),
  [Status] NVARCHAR(50)
)
GO

CREATE TABLE [AppointmentSlot] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [SlotID] UNIQUEIDENTIFIER,
  [PatientID] UNIQUEIDENTIFIER,
  [Status] NVARCHAR(50)
)
GO

CREATE TABLE [Transaction] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [PatientID] UNIQUEIDENTIFIER,
  [DoctorID] UNIQUEIDENTIFIER,
  [SubID] UNIQUEIDENTIFIER,
  [AppointmentSlotID] UNIQUEIDENTIFIER,
  [TransactionInfo] NVARCHAR(MAX),
  [Amount] DECIMAL(18,2),
  [CreatedDate] DATETIME DEFAULT (GETDATE()),
  [Status] NVARCHAR(50)
)
GO

CREATE TABLE [Review] (
  [ID] UNIQUEIDENTIFIER PRIMARY KEY,
  [Rating] INT,
  [Message] NVARCHAR(MAX),
  [PatientID] UNIQUEIDENTIFIER,
  [DoctorID] UNIQUEIDENTIFIER,
  [SlotID] UNIQUEIDENTIFIER
)
GO

ALTER TABLE [Experience] ADD FOREIGN KEY ([SpecialtyID]) REFERENCES [Specialty] ([ID])
GO

ALTER TABLE [Experience] ADD FOREIGN KEY ([DoctorID]) REFERENCES [Doctor] ([ID])
GO

ALTER TABLE [DoctorSubscription] ADD FOREIGN KEY ([SubscriptionID]) REFERENCES [Subscription] ([ID])
GO

ALTER TABLE [DoctorSubscription] ADD FOREIGN KEY ([DoctorID]) REFERENCES [Doctor] ([ID])
GO

ALTER TABLE [Services] ADD FOREIGN KEY ([SpecialtyID]) REFERENCES [Specialty] ([ID])
GO

ALTER TABLE [Slot] ADD FOREIGN KEY ([DoctorID]) REFERENCES [Doctor] ([ID])
GO

ALTER TABLE [Slot] ADD FOREIGN KEY ([ServiceID]) REFERENCES [Services] ([ID])
GO

ALTER TABLE [Slot] ADD FOREIGN KEY ([SpecialtyID]) REFERENCES [Specialty] ([ID])
GO

ALTER TABLE [AppointmentSlot] ADD FOREIGN KEY ([SlotID]) REFERENCES [Slot] ([ID])
GO

ALTER TABLE [AppointmentSlot] ADD FOREIGN KEY ([PatientID]) REFERENCES [Patient] ([ID])
GO

ALTER TABLE [Transaction] ADD FOREIGN KEY ([AppointmentSlotID]) REFERENCES [AppointmentSlot] ([ID])
GO

ALTER TABLE [Transaction] ADD FOREIGN KEY ([SubID]) REFERENCES [Subscription] ([ID])
GO

ALTER TABLE [Transaction] ADD FOREIGN KEY ([PatientID]) REFERENCES [Patient] ([ID])
GO

ALTER TABLE [Transaction] ADD FOREIGN KEY ([DoctorID]) REFERENCES [Doctor] ([ID])
GO

ALTER TABLE [Review] ADD FOREIGN KEY ([PatientID]) REFERENCES [Patient] ([ID])
GO

ALTER TABLE [Review] ADD FOREIGN KEY ([DoctorID]) REFERENCES [Doctor] ([ID])
GO

ALTER TABLE [Review] ADD FOREIGN KEY ([SlotID]) REFERENCES [Slot] ([ID])
GO

