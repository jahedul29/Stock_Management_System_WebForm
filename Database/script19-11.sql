USE [master]
GO
/****** Object:  Database [TestDB]    Script Date: 19-Nov-18 9:36:31 AM ******/
CREATE DATABASE [TestDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestDB', FILENAME = N'D:\BITM\Project Testing\Database\TestDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestDB_log', FILENAME = N'D:\BITM\Project Testing\Database\TestDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TestDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TestDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestDB] SET  MULTI_USER 
GO
ALTER DATABASE [TestDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [TestDB]
GO
/****** Object:  Table [dbo].[Catagories]    Script Date: 19-Nov-18 9:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Catagories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CatagoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Catagories] PRIMARY KEY CLUSTERED 
(
	[Id] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 19-Nov-18 9:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Companies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](50) NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Items]    Script Date: 19-Nov-18 9:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [varchar](50) NOT NULL,
	[ReorderLavel] [int] NULL,
	[AvailableQuantity] [decimal](18, 2) NULL,
	[CompanyId] [int] NOT NULL,
	[CatagoryId] [int] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockOuts]    Script Date: 19-Nov-18 9:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockOuts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SellQuantity] [decimal](18, 2) NOT NULL,
	[DamageQuantity] [decimal](18, 2) NOT NULL,
	[LostQuantity] [decimal](18, 2) NOT NULL,
	[Date] [date] NULL,
	[ItemId] [int] NULL,
 CONSTRAINT [PK_StockOuts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[GetAllItemsView]    Script Date: 19-Nov-18 9:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GetAllItemsView]
AS
SELECT        i.Id, i.ItemName, i.AvailableQuantity, co.Id AS CompanyID, co.CompanyName, ca.Id AS CatagoryId, ca.CatagoryName, i.ReorderLavel
FROM            dbo.Items AS i INNER JOIN
                         dbo.Companies AS co ON i.CompanyId = co.Id INNER JOIN
                         dbo.Catagories AS ca ON i.CatagoryId = ca.Id

GO
/****** Object:  View [dbo].[ItemSellView]    Script Date: 19-Nov-18 9:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ItemSellView]
AS
SELECT        v.Id, v.ItemName, v.CompanyName, so.Id AS StockOutId, so.SellQuantity, so.Date AS SellDate, so.ItemId
FROM            dbo.GetAllItemsView AS v INNER JOIN
                         dbo.StockOuts AS so ON v.Id = so.ItemId

GO
SET IDENTITY_INSERT [dbo].[Catagories] ON 

INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1014, N'Buiscuit')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1013, N'Chips')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (6, N'Cloth')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1012, N'Computer')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1015, N'Drinks')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1008, N'Food')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1009, N'Furniture')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1010, N'Kitchen')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (5, N'Medicine')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1007, N'Men''s Product')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1006, N'Mobile')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1016, N'Software')
INSERT [dbo].[Catagories] ([Id], [CatagoryName]) VALUES (1011, N'Stationary')
SET IDENTITY_INSERT [dbo].[Catagories] OFF
SET IDENTITY_INSERT [dbo].[Companies] ON 

INSERT [dbo].[Companies] ([Id], [CompanyName]) VALUES (4, N'PHP')
INSERT [dbo].[Companies] ([Id], [CompanyName]) VALUES (2, N'RFL')
INSERT [dbo].[Companies] ([Id], [CompanyName]) VALUES (5, N'S. Alam')
INSERT [dbo].[Companies] ([Id], [CompanyName]) VALUES (3, N'Transcom Beverage')
INSERT [dbo].[Companies] ([Id], [CompanyName]) VALUES (1, N'Uniliver')
SET IDENTITY_INSERT [dbo].[Companies] OFF
SET IDENTITY_INSERT [dbo].[Items] ON 

INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (1, N'Toast', 0, CAST(25.00 AS Decimal(18, 2)), 1, 1014)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (2, N'Cosmos', 0, CAST(10.00 AS Decimal(18, 2)), 1, 1014)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (3, N'Cream', 0, CAST(0.00 AS Decimal(18, 2)), 1, 1014)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (5, N'Nuty', 5, CAST(10.00 AS Decimal(18, 2)), 1, 1014)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (6, N'Core i5', 1, CAST(10.00 AS Decimal(18, 2)), 4, 1012)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (7, N'Toast', 0, CAST(0.00 AS Decimal(18, 2)), 5, 1014)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (8, N'Book', 0, CAST(0.00 AS Decimal(18, 2)), 2, 1011)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (9, N'Cocacola', 0, CAST(0.00 AS Decimal(18, 2)), 3, 1015)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (10, N'Pepsi', 0, CAST(0.00 AS Decimal(18, 2)), 3, 1015)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (11, N'Chair', 0, CAST(0.00 AS Decimal(18, 2)), 2, 1009)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (12, N'Table', 0, CAST(0.00 AS Decimal(18, 2)), 2, 1009)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (13, N'Metres', 0, CAST(0.00 AS Decimal(18, 2)), 2, 1009)
INSERT [dbo].[Items] ([Id], [ItemName], [ReorderLavel], [AvailableQuantity], [CompanyId], [CatagoryId]) VALUES (14, N'Matres', 0, CAST(0.00 AS Decimal(18, 2)), 2, 1009)
SET IDENTITY_INSERT [dbo].[Items] OFF
SET IDENTITY_INSERT [dbo].[StockOuts] ON 

INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (1, CAST(10.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x01380B00 AS Date), 1)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (2, CAST(0.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x91390B00 AS Date), 2)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (3, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(0x1F3B0B00 AS Date), 3)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (5, CAST(5.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x4B3C0B00 AS Date), 2)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (6, CAST(6.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0xF63E0B00 AS Date), 5)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (7, CAST(0.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0xF83E0B00 AS Date), 11)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (8, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)), CAST(0xE6390B00 AS Date), 10)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (9, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(7.00 AS Decimal(18, 2)), CAST(0x7B3B0B00 AS Date), 12)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (10, CAST(50.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x423A0B00 AS Date), 2)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (11, CAST(80.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x1F3B0B00 AS Date), 11)
INSERT [dbo].[StockOuts] ([Id], [SellQuantity], [DamageQuantity], [LostQuantity], [Date], [ItemId]) VALUES (12, CAST(0.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0xC13C0B00 AS Date), 1)
SET IDENTITY_INSERT [dbo].[StockOuts] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Catagories]    Script Date: 19-Nov-18 9:36:31 AM ******/
ALTER TABLE [dbo].[Catagories] ADD  CONSTRAINT [IX_Catagories] UNIQUE NONCLUSTERED 
(
	[CatagoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Companies]    Script Date: 19-Nov-18 9:36:31 AM ******/
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [IX_Companies] UNIQUE NONCLUSTERED 
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_ReorderLabel]  DEFAULT ((0)) FOR [ReorderLavel]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_AvailableQuantity]  DEFAULT ((0)) FOR [AvailableQuantity]
GO
ALTER TABLE [dbo].[StockOuts] ADD  CONSTRAINT [DF_StockOuts_SellQuantity]  DEFAULT ((0)) FOR [SellQuantity]
GO
ALTER TABLE [dbo].[StockOuts] ADD  CONSTRAINT [DF_StockOuts_DamageQuantity]  DEFAULT ((0)) FOR [DamageQuantity]
GO
ALTER TABLE [dbo].[StockOuts] ADD  CONSTRAINT [DF_StockOuts_LostQuantity]  DEFAULT ((0)) FOR [LostQuantity]
GO
ALTER TABLE [dbo].[StockOuts] ADD  CONSTRAINT [DF_StockOuts_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Catagories] FOREIGN KEY([CatagoryId])
REFERENCES [dbo].[Catagories] ([Id])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Catagories]
GO
ALTER TABLE [dbo].[StockOuts]  WITH CHECK ADD  CONSTRAINT [FK_StockOuts_Items] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([Id])
GO
ALTER TABLE [dbo].[StockOuts] CHECK CONSTRAINT [FK_StockOuts_Items]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "co"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 102
               Right = 432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ca"
            Begin Extent = 
               Top = 102
               Left = 259
               Bottom = 198
               Right = 429
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GetAllItemsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GetAllItemsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "v"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "so"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 136
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ItemSellView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ItemSellView'
GO
USE [master]
GO
ALTER DATABASE [TestDB] SET  READ_WRITE 
GO
