USE ExampleDb;
GO

/* Address */
INSERT [dbo].[Address]
    ([Address1],
    [Address2],
    [City],
    [State],
    [ZipCode],
    [Country],
    [CreatedBy],
    [CreatedDate],
    [ModifiedDate])
VALUES
    ('111 S Main St', 'Suite 1', 'Babel', 'MI', 12345, 'US', 'chuck.norris@example.com', GETDATE(), GETDATE()),
    ('123 N Park Ave', NULL, 'Middle of Nowhere', 'MI', 54321, 'US', 'chuck.norris@example.com', GETDATE(), GETDATE());

DECLARE @addressAlanTuring INT=(SELECT TOP(1) ID FROM [dbo].[Address] WHERE [Address1]='111 S Main St' AND [Address2]='Suite 1');

/* Customer */
INSERT [dbo].[Customer] 
    ([FirstName],
    [MiddleName],
    [LastName],
    [PhoneNumber],
    [PhoneNumberExt],
    [Email],
    [CreatedBy],
    [CreatedDate],
    [ModifiedDate]) 
VALUES 
    ('Alan', NULL, 'Turing', '5555551234', NULL, 'alan.turing@example.com', 'chuck.norris@example.com', GETDATE(), GETDATE());

DECLARE @customerAlanTuring INT=(SELECT TOP(1) ID FROM [dbo].[Customer] WHERE [FirstName]='Alan' AND [LastName]='Turing');

/* CustomerAddress */
INSERT [dbo].[CustomerAddress]
    ([CustomerID],
    [AddressID])
VALUES
    ((SELECT @customerAlanTuring),
    (SELECT @addressAlanTuring))
