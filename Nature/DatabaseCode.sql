USE [master]
GO
/****** Object:  Database [SharifiDB]    Script Date: 10/16/2015 10:27:58 PM ******/
CREATE DATABASE [SharifiDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SharifiDB', FILENAME = N'C:\Users\Rexa\SharifiDB.mdf' , SIZE = 102400KB , MAXSIZE = UNLIMITED, FILEGROWTH = 50%)
 LOG ON 
( NAME = N'SharifiDB_log', FILENAME = N'C:\Users\Rexa\SharifiDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SharifiDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SharifiDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SharifiDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SharifiDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SharifiDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SharifiDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SharifiDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SharifiDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SharifiDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SharifiDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SharifiDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SharifiDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SharifiDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SharifiDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SharifiDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SharifiDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SharifiDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SharifiDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SharifiDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SharifiDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SharifiDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SharifiDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SharifiDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SharifiDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SharifiDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SharifiDB] SET  MULTI_USER 
GO
ALTER DATABASE [SharifiDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SharifiDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SharifiDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SharifiDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SharifiDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SharifiDB]
GO
/****** Object:  Table [dbo].[AdminSet]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminSet](
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Fullname] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_AdminSet] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FileSet]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FileSet](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[Bytes] [varbinary](max) NOT NULL,
	[Length] [int] NOT NULL,
 CONSTRAINT [PK_FileSet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GroupSet]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupSet](
	[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF_GroupSet_Id]  DEFAULT (newid()),
	[Name] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_GroupSet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostSet]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostSet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](350) NOT NULL,
	[Abstract] [nvarchar](max) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[DateTime] [datetime] NOT NULL CONSTRAINT [DF_PostSet_DateTime]  DEFAULT (getdate()),
	[AdminUsername] [nvarchar](50) NOT NULL,
	[GroupId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PostSet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_Admins]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Admins]
	AS SELECT Username , Fullname FROM [AdminSet]
GO
/****** Object:  View [dbo].[v_FileDownloads]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_FileDownloads]
AS
SELECT        id, Name, [Type], Bytes
FROM            dbo.FileSet
GO
/****** Object:  View [dbo].[v_Files]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Files]
AS
SELECT        id, Name, [Type], [Length]
FROM            dbo.FileSet
GO
/****** Object:  View [dbo].[v_Groups]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Groups]
	AS SELECT Id, Name From GroupSet
GO
/****** Object:  View [dbo].[v_Posts]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Posts]
	AS SELECT Id, Title, Abstract,GroupId, AdminUsername From PostSet
GO
ALTER TABLE [dbo].[PostSet]  WITH CHECK ADD  CONSTRAINT [FK_PostSet_AdminSet] FOREIGN KEY([AdminUsername])
REFERENCES [dbo].[AdminSet] ([Username])
GO
ALTER TABLE [dbo].[PostSet] CHECK CONSTRAINT [FK_PostSet_AdminSet]
GO
ALTER TABLE [dbo].[PostSet]  WITH CHECK ADD  CONSTRAINT [FK_PostSet_GroupSet] FOREIGN KEY([GroupId])
REFERENCES [dbo].[GroupSet] ([Id])
GO
ALTER TABLE [dbo].[PostSet] CHECK CONSTRAINT [FK_PostSet_GroupSet]
GO
/****** Object:  StoredProcedure [dbo].[p_Admin_Delete]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_Admin_Delete] --We have created this; but plz don't use it!
	@Username nvarchar(50)
AS
	Delete AdminSet where Username=@Username
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[p_Admin_Insert]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_Admin_Insert]
	@Username nvarchar(50),
	@Password nvarchar(100),
	@Fullname nvarchar(100)
AS
	INSERT INTO AdminSet(Username,[Password],Fullname) Values (@Username, @Password, @Fullname)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[p_Admin_Update]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_Admin_Update]
	@Username nvarchar(50), -- Not editable
	@Password nvarchar(100),
	@Fullname nvarchar(100)
AS
	UPDATE AdminSet SET [Password]=@password , Fullname=@Fullname WHERE Username=@Username
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[p_File_Delete]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
CREATE PROCEDURE [dbo].[p_File_Delete]
@Id uniqueidentifier
AS
BEGIN
DELETE FROM FileSet where Id=@Id
END

GO
/****** Object:  StoredProcedure [dbo].[p_File_Insert]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
CREATE PROCEDURE [dbo].[p_File_Insert]
@Name nvarchar(100),
@Type nvarchar(20),
@Bytes varbinary(max),
@Lenght int
AS
BEGIN
insert into FileSet(Name, [Type], Bytes, [Length], Id) values (@Name,@Type,@Bytes,@Lenght,newid())
END

GO
/****** Object:  StoredProcedure [dbo].[p_Group_Delete]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_Group_Delete] --integrity
	@Id uniqueidentifier

AS
	DELETE GroupSet WHERE Id=@Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[p_Group_Insert]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_Group_Insert]
	@Name nvarchar(300)
AS
	INSERT INTO GroupSet(Id,Name) VALUES (NewID(), @Name)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[p_Group_Update]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_Group_Update]
	@Id uniqueidentifier,
	@Name nvarchar(300)
AS
	UPDATE GroupSet SET Name=@Name WHERE Id=@Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[p_Post_Delete]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_Post_Delete]
	@Id int
AS
	delete PostSet where Id=@Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[p_Post_Insert]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_Post_Insert]
	@Title nvarchar(350),
	@Abstract nvarchar(MAX),
	@Body nvarchar(MAX),
	@GroupId uniqueidentifier,
	@AdminUsername nvarchar(50)
AS
	insert into PostSet(Title,Abstract,Body,[DateTime],GroupId,AdminUsername) values(@Title,@Abstract,@Body,GETDATE(),@GroupId,@AdminUsername)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[p_Post_Update]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_Post_Update]
	@Id int,
	@Title nvarchar(350),
	@Abstract nvarchar(MAX),
	@Body nvarchar(MAX),
	@GroupId uniqueidentifier,
	@AdminUsername nvarchar(50)
AS
	Update PostSet set Title=@Title , Abstract=@Abstract , Body=@Body, GroupId=@GroupId, AdminUsername=@AdminUsername WHERE Id=@Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[v_Check_Password]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[v_Check_Password]
	@Username nvarchar(50),
	@Password nvarchar(100)
AS

DECLARE @StoredPassword nvarchar(100)
set @StoredPassword = (SELECT [Password] FROM AdminSet WHere Username=@Username)

IF @StoredPassword = @Password
	BEGIN
		RETURN 1
	END
ELSE
	BEGIN
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[v_Post]    Script Date: 10/16/2015 10:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[v_Post]
	@Id	int
AS
	 SELECT Title,Abstract, Body, [DateTime], Name as [Group], Fullname as [User] from PostSet inner join GroupSet on PostSet.GroupId=GroupSet.Id inner join AdminSet on PostSet.AdminUsername=AdminSet.Username where PostSet.Id=@Id
GO
USE [master]
GO
ALTER DATABASE [SharifiDB] SET  READ_WRITE 
GO
