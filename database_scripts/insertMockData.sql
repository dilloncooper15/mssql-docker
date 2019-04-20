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


/* Customer */
INSERT [dbo].[Customer] 
    ([FirstName],
    [MiddleName],
    [LastName],
    [AddressID],
    [PhoneNumber],
    [PhoneNumberExt],
    [Email],
    [CreatedBy],
    [CreatedDate],
    [ModifiedDate]) 
VALUES 
    ('Alan', NULL, 'Turing', 1, '5555551234', NULL, 'alan.turing@example.com', 'chuck.norris@example.com', GETDATE(), GETDATE());
