CREATE DATABASE ExampleDb;
GO
USE ExampleDb;
GO


/****** Object:  Table [dbo].[Address] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address]
    ([ID] [int] IDENTITY(1,1) PRIMARY KEY,
    [Address1] [varchar](100) NOT NULL, 
    [Address2] [varchar](50) NULL, 
    [City] [varchar](100) NOT NULL, 
    [State] [varchar](2) NOT NULL,
    [ZipCode] [int] NOT NULL, 
    [Country] [varchar](50) NULL, 
    [CreatedBy] [varchar](100) NOT NULL, 
    [CreatedDate] [datetime] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL);


/****** Object:  Table [dbo].[Customer] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer] 
    ([ID] [int] IDENTITY(1,1) PRIMARY KEY, 
    [FirstName] [varchar](100) NOT NULL, 
    [MiddleName] [varchar](100) NULL, 
    [LastName] [varchar](100) NOT NULL,
    [PhoneNumber] [varchar](20) NOT NULL, 
    [PhoneNumberExt] [varchar](10) NULL, 
    [Email] [varchar](100) NULL,
    [CreatedBy] [varchar](100) NOT NULL, 
    [CreatedDate] [datetime] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL);


/****** Object:  Table [dbo].[CustomerAddress] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAddress]
    ([ID] [int] IDENTITY(1,1) PRIMARY KEY,
    [CustomerID] INT NOT NULL,
    [AddressID] INT NOT NULL);
