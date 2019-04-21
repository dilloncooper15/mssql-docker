USE ExampleDb
GO

/* Foreign Key Generation */
ALTER TABLE [dbo].[CustomerAddress]  WITH CHECK ADD  CONSTRAINT [FK_Address] FOREIGN KEY([AddressID])
REFERENCES [dbo].[Address] ([ID])
GO
ALTER TABLE [dbo].[CustomerAddress] CHECK CONSTRAINT [FK_Address]
GO

ALTER TABLE [dbo].[CustomerAddress]  WITH CHECK ADD  CONSTRAINT [FK_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[CustomerAddress] CHECK CONSTRAINT [FK_Customer]
GO


/* Add Constraints */
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [CK_Address_ModifiedDate] CHECK  (([ModifiedDate]>=[CreatedDate]))
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [CK_Address_ModifiedDate]
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [CK_Customer_ModifiedDate] CHECK  (([ModifiedDate]>=[CreatedDate]))
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [CK_Customer_ModifiedDate]
GO
