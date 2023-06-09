USE [master]
GO
/****** Object:  Database [TODO]    Script Date: 19.04.2023 21:39:27 ******/
CREATE DATABASE [TODO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TODO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TODO.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TODO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TODO_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TODO] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TODO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TODO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TODO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TODO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TODO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TODO] SET ARITHABORT OFF 
GO
ALTER DATABASE [TODO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TODO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TODO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TODO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TODO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TODO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TODO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TODO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TODO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TODO] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TODO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TODO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TODO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TODO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TODO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TODO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TODO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TODO] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TODO] SET  MULTI_USER 
GO
ALTER DATABASE [TODO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TODO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TODO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TODO] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TODO] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TODO] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TODO] SET QUERY_STORE = OFF
GO
USE [TODO]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 19.04.2023 21:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[Email] [nvarchar](100) NULL,
	[FullName] [nvarchar](100) NULL,
	[Password] [nvarchar](20) NULL,
 CONSTRAINT [PK_USERS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 19.04.2023 21:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_ROLE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 19.04.2023 21:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORY](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TODO]    Script Date: 19.04.2023 21:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TODO](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[UserId] [int] NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Deadline] [datetime] NULL,
	[StartTime] [datetime] NULL,
	[Endtime] [datetime] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_TODO] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewTodo]    Script Date: 19.04.2023 21:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewTodo]
AS
SELECT        dbo.TODO.Id, dbo.TODO.Title, dbo.TODO.Description, dbo.TODO.Deadline, dbo.TODO.StartTime, dbo.TODO.Endtime, dbo.TODO.Status, dbo.TODO.UserId, dbo.[USER].Email, dbo.[USER].FullName, dbo.[USER].Password, 
                         dbo.[USER].RoleId, dbo.ROLE.Name AS 'RoleName', dbo.TODO.CategoryId, dbo.CATEGORY.Name AS 'CategoryName'
FROM            dbo.ROLE INNER JOIN
                         dbo.[USER] ON dbo.ROLE.Id = dbo.[USER].RoleId INNER JOIN
                         dbo.TODO ON dbo.[USER].Id = dbo.TODO.UserId INNER JOIN
                         dbo.CATEGORY ON dbo.TODO.CategoryId = dbo.CATEGORY.Id
GO
SET IDENTITY_INSERT [dbo].[CATEGORY] ON 

INSERT [dbo].[CATEGORY] ([Id], [Name]) VALUES (1, N'Home')
INSERT [dbo].[CATEGORY] ([Id], [Name]) VALUES (2, N'Work')
SET IDENTITY_INSERT [dbo].[CATEGORY] OFF
GO
SET IDENTITY_INSERT [dbo].[ROLE] ON 

INSERT [dbo].[ROLE] ([Id], [Name]) VALUES (1, N'Administrator')
INSERT [dbo].[ROLE] ([Id], [Name]) VALUES (2, N'Registered')
SET IDENTITY_INSERT [dbo].[ROLE] OFF
GO
SET IDENTITY_INSERT [dbo].[TODO] ON 

INSERT [dbo].[TODO] ([Id], [CategoryId], [UserId], [Title], [Description], [Deadline], [StartTime], [Endtime], [Status]) VALUES (1095, 2, 3, N'adssadasdadsasdasdsad', N'sadasdsdasd', CAST(N'2023-04-19T21:16:52.097' AS DateTime), CAST(N'2023-04-19T21:16:52.097' AS DateTime), CAST(N'2023-04-19T21:16:52.097' AS DateTime), 0)
INSERT [dbo].[TODO] ([Id], [CategoryId], [UserId], [Title], [Description], [Deadline], [StartTime], [Endtime], [Status]) VALUES (1097, 1, 1, N'asdasdasd', N'asdadsasd', CAST(N'2023-04-26T21:28:06.000' AS DateTime), CAST(N'2023-04-19T21:28:09.793' AS DateTime), CAST(N'2023-04-19T21:28:09.793' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TODO] OFF
GO
SET IDENTITY_INSERT [dbo].[USER] ON 

INSERT [dbo].[USER] ([Id], [RoleId], [Email], [FullName], [Password]) VALUES (1, 1, N'alper@sapan.com', N'ALPER SAPAN', N'123')
INSERT [dbo].[USER] ([Id], [RoleId], [Email], [FullName], [Password]) VALUES (3, 2, N'john@doe.com', N'JOHN DOE', N'456')
SET IDENTITY_INSERT [dbo].[USER] OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_TODOLIST]    Script Date: 19.04.2023 21:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TODOLIST] 
AS
BEGIN
	SELECT dbo.TODO.todoId, dbo.TODO.UserId, dbo.TODO.CategoryId, dbo.TODO.todoTitle, dbo.TODO.todoDescription, dbo.TODO.todoDeadline, dbo.TODO.todoDateStart, dbo.TODO.todoDateEnd, dbo.TODO.todoStatus, dbo.[USER].userLoginID, dbo.[USER].userPassword, dbo.[USER].userFullName, dbo.CATEGORY.categoryName FROM dbo.CATEGORY INNER JOIN dbo.TODO ON dbo.CATEGORY.categoryId = dbo.TODO.CategoryId INNER JOIN dbo.[USER] ON dbo.TODO.UserId = dbo.[USER].userId
END
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
         Begin Table = "ROLE"
            Begin Extent = 
               Top = 40
               Left = 817
               Bottom = 219
               Right = 987
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "USER"
            Begin Extent = 
               Top = 15
               Left = 568
               Bottom = 145
               Right = 738
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TODO"
            Begin Extent = 
               Top = 16
               Left = 332
               Bottom = 244
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CATEGORY"
            Begin Extent = 
               Top = 28
               Left = 69
               Bottom = 188
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
         SortType = ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewTodo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewTodo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewTodo'
GO
USE [master]
GO
ALTER DATABASE [TODO] SET  READ_WRITE 
GO
