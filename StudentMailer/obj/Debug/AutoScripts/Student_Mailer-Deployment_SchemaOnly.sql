CREATE USER [bs023857] FOR LOGIN [RDG-HOME\bs023857] WITH DEFAULT_SCHEMA=[dbo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseLookUp](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseCode] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[CourseName] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_CourseLookUp] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[CourseCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DegreeLookUp](
	[DegreeID] [int] IDENTITY(1,1) NOT NULL,
	[DegreeName] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[DegreeCode] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Num_Of_Years] [int] NULL,
 CONSTRAINT [PK_tbl_Degree] PRIMARY KEY CLUSTERED 
(
	[DegreeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacultyLookUp](
	[FacultyID] [int] NOT NULL,
	[FacultyName] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
 CONSTRAINT [PK_FacultyLookUp11] PRIMARY KEY CLUSTERED 
(
	[FacultyID] ASC,
	[FacultyName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LevelLookUp](
	[LevelID] [int] IDENTITY(1,1) NOT NULL,
	[Level] [nvarchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[LevelName] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_Tbl_DegreeLevel] PRIMARY KEY CLUSTERED 
(
	[LevelID] ASC,
	[Level] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentModule](
	[StudentID] [int] NOT NULL,
	[ModuleID] [int] NOT NULL,
	[YearID] [smallint] NULL,
 CONSTRAINT [PK_StudentModule] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC,
	[ModuleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentData](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[StudentNumber] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[UniEmail] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[StudentName] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Initial] [nvarchar](4) COLLATE Latin1_General_CI_AS NULL,
	[LevelID] [smallint] NULL,
	[CourseID] [int] NULL,
	[FacultyID] [int] NULL,
	[DegreeID] [int] NULL,
	[TutorID] [int] NULL,
	[YearID] [smallint] NULL,
	[Status] [nvarchar](4) COLLATE Latin1_General_CI_AS NULL,
	[SPRCode] [nvarchar](20) COLLATE Latin1_General_CI_AS NULL,
	[OtherEmail] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_StudentData_1] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC,
	[StudentNumber] ASC,
	[UniEmail] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuleLookUp](
	[ModuleID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleCode] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[ModuleName] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[CourseID] [int] NULL,
 CONSTRAINT [PK_Tbl_Module] PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC,
	[ModuleCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LogicalLinkOptions]
AS
SELECT DISTINCT LogicOptions, ID, Logictype
FROM         dbo.LogicalLinkOptions

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogicalLinkLookUp](
	[LogicOptions] [char](10) COLLATE Latin1_General_CI_AS NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Logictype] [int] NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_CreateBackUp] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
BACKUP DATABASE Student_Mailer
TO DISK = N'C:\Users\BackupUser\Documents\SQL Server Management Studio\Backup Files\Solution1'
   WITH FORMAT,
      MEDIANAME = 'Z_SQLServerBackups',
      NAME = 'Full Backup of AdventureWorks2008R2';
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YearLookUp](
	[YearID] [int] IDENTITY(1,1) NOT NULL,
	[YearName] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_tbl_year] PRIMARY KEY CLUSTERED 
(
	[YearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TutorLookUp](
	[TutorID] [int] IDENTITY(1,1) NOT NULL,
	[TutorCode] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[TutorName] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_Tbl_Tutor] PRIMARY KEY CLUSTERED 
(
	[TutorID] ASC,
	[TutorCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_queryByDegreeANDTutor]
	-- Add the parameters for the stored procedure here
	@DegreeID int,--2
	@tutorID int  --95
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Tbl_StdInfo  
	where tbl_StdInfo.degreeID = @degreeID
	and 
	tbl_StdInfo.tutorID = @tutorID
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_QueryByDegree] 
	-- Add the parameters for the stored procedure here
	@DegreeID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT DISTINCT tbl.StudentName, tbl.StudentNumber, tbl.UniEmail
	FROM StudentData AS tbl
	WHERE tbl.degreeID = @DegreeID 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_QueryByCourse] 
@CourseID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT tbl.StudentName, tbl.StudentNumber, tbl.UniEmail
	FROM StudentData tbl 
    WHERE tbl.CourseID = @CourseID
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Yussuf, Aminah>
-- Description:	<FILTER StudentData BY StudentNumber>
-- =============================================
CREATE PROCEDURE Proc_GetStudentDataByStudentNumber
	-- Add the parameters for the stored procedure here
	@StudentNumber nvarchar(12)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT [StudentName],[StudentNumber],[UniEmail] FROM StudentData
	WHERE StudentNumber = @StudentNumber
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.Tutor
AS
SELECT DISTINCT TutorID, TutorName
FROM         dbo.TutorLookUp

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Aminah>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[Proc_BasicQueryOLD] 
	@DegreelevelID int , 
	@ModuleID int, 
	@DegreeID int, 
	@TutorID int, 
	@CourseID int, 
	@FacultyID int, 
	@YearID int 
AS
BEGIN 
	SET NOCOUNT ON; 
-- Using "AND" as logical link 

--All parameters selected (1)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID = -1 AND  @FacultyID != -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                              AND StudentData.[TutorID] = @TutorID AND StudentData.[FacultyID] = @FacultyID
                              AND StudentData.[YearID] = @YearID AND StudentData.[LevelID] = @degreelevelID 
                              AND dbo.StudentData.CourseID = @CourseID 
END  

--when YearID parameter is null (2)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID != -1 AND  @FacultyID != -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                              AND StudentData.[CourseID] = @CourseID AND StudentData.[FacultyID] = @FacultyID
                              AND StudentData.[LevelID] = @degreelevelID AND StudentData.[TutorID] = @TutorID 
END   

--When facultyID is null (3)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID != -1 AND  @FacultyID = -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                              AND StudentData.[CourseID] = @CourseID AND StudentData.[YearID] = @YearID 
                              AND StudentData.[LevelID] = @degreelevelID AND StudentData.[TutorID] = @TutorID 
END 
                              
--when degreelevelID is null  (4)                            
IF (@DegreelevelID = -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID != -1 AND  @FacultyID != -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID
WHERE				  ModuleLookUp.[ModuleID] = @ModuleID AND StudentData.[DegreeID] = @degreeID 
                              AND StudentData.[CourseID] = @CourseID AND StudentData.[FacultyID] = @FacultyID 
                              AND StudentData.[YearID] = @YearID AND StudentData.[TutorID] = @TutorID 
END
 
--when Module is null   (5)
IF (@DegreelevelID != -1 AND @ModuleID = -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID != -1 AND  @FacultyID != -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID
    WHERE             StudentData.[LevelID] = @degreelevelID AND StudentData.[CourseID] = @CourseID 
                              AND StudentData.[DegreeID] = @degreeID AND StudentData.[TutorID] = @TutorID 
                              AND StudentData.[YearID] = @YearID AND StudentData.[FacultyID] = @FacultyID 
END
    
--when degreeID is null (6)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID = -1 AND @TutorID != -1 AND @CourseID != -1 AND  @FacultyID != -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID
    WHERE             StudentData.[LevelID] = @degreelevelID AND StudentData.[TutorID] = @TutorID 
                              AND StudentData.[CourseID] = @CourseID AND StudentData.[FacultyID] = @FacultyID 
                              AND StudentData.[YearID] = @YearID AND ModuleLookUp.[ModuleID] = @ModuleID
END

--when tutorID is null (7)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID = -1 AND @CourseID != -1 AND  @FacultyID != -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID
    WHERE             StudentData.[TutorID] = @TutorID AND ModuleLookUp.[ModuleID] = @ModuleID
                              AND StudentData.[CourseID] = @CourseID AND StudentData.[FacultyID] = @FacultyID
                              AND StudentData.[CourseID] = @CourseID AND StudentData.[YearID] = @YearID 
END

--when tutorID is null (8)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID = -1 AND @CourseID != -1 AND  @FacultyID != -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                              AND StudentData.[CourseID] = @CourseID AND StudentData.[FacultyID] = @FacultyID
                              AND StudentData.[YearID] = @YearID AND StudentData.[LevelID] = @degreelevelID   
END	
 
--level not equal to null 
IF (@DegreelevelID != -1 AND @ModuleID = -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[LevelID] = @degreelevelID 
END 

--Module not equal to null 
IF (@DegreelevelID = -1 AND @ModuleID != -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             ModuleLookUp.[ModuleID] = @ModuleID  
END  
 
--Degree not equal to null
IF (@DegreelevelID = -1 AND @ModuleID = -1 AND @DegreeID != -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID  
END  
 
--Tutor not equal to null
IF (@DegreelevelID = -1 AND @ModuleID = -1 AND @DegreeID = -1 AND @TutorID != -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[TutorID] = @TutorID 
 END
 
--Course not equal to null 
IF (@DegreelevelID = -1 AND @ModuleID = -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID != -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             dbo.CourseLookUp.CourseID = @CourseID
END  
 
--Faculty not equal to null 
IF (@DegreelevelID = -1 AND @ModuleID = -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID != -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[FacultyID] = @FacultyID
END  

-- Year not equal to null
IF (@DegreelevelID = -1 AND @ModuleID = -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID 
END  
 
--All parameters selected (9)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID != -1 AND  @FacultyID != -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                              AND StudentData.[TutorID] = @TutorID AND StudentData.[FacultyID] = @FacultyID
                              AND StudentData.[YearID] = @YearID AND StudentData.[LevelID] = @degreelevelID 
                              AND dbo.CourseLookUp.CourseID = @CourseID
END  
 
--level and Module not equal to null (10)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND StudentData.[LevelID] = @degreelevelID 
END  

--Level, Module and Degree (11)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                               AND StudentData.[LevelID] = @degreelevelID 
END

--Level, Module, Degree and Tutor (12)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                              AND StudentData.[TutorID] = @TutorID AND StudentData.[LevelID] = @degreelevelID 

END 

--Level, Module, Degree,Tutor and CourseID (13)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID != -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                              AND StudentData.[TutorID] = @TutorID AND StudentData.[LevelID] = @degreelevelID 
END

--Level, Module, Degree,Tutor,Faculty and CourseID (14)
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID != -1 AND  @FacultyID != -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                              AND StudentData.[TutorID] = @TutorID AND StudentData.[FacultyID] = @FacultyID
                              AND StudentData.[LevelID] = @degreelevelID 
END  

--Degree and DegreeLevel
IF (@DegreelevelID != -1 AND @ModuleID = -1 AND @DegreeID != -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp  ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp   ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp  ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp  ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp   ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp    ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND StudentData.[LevelID] = @degreelevelID 
END  

--Degree  And Tutor 
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID = -1 AND @TutorID != -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[TutorID] = @TutorID AND StudentData.[LevelID] = @degreelevelID 
END  

--CourseID And DegreeLevel  
IF (@DegreelevelID != -1 AND @ModuleID = -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID != -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE              StudentData.[LevelID] = @degreelevelID 
                              AND dbo.CourseLookUp.CourseID = @CourseID
END  
 
--DegreeLevel and Faculty
IF (@DegreelevelID != -1 AND @ModuleID = -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID != -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[FacultyID] = @FacultyID AND StudentData.[LevelID] = @degreelevelID
END  
 
--Year And DegreeLevel 
IF (@DegreelevelID != -1 AND @ModuleID = -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[YearID] = @YearID AND StudentData.[LevelID] = @degreelevelID 
END  
 
--Level,Degree and Tutor 
IF (@DegreelevelID != -1 AND @ModuleID = -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID  
                      AND StudentData.[TutorID] = @TutorID 
                      AND StudentData.[LevelID] = @degreelevelID 
END  
 
--Level,Degree, Tutor and Course 
IF (@DegreelevelID != -1 AND @ModuleID = -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID != -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND StudentData.[TutorID] = @TutorID 
					  AND StudentData.[LevelID] = @degreelevelID AND dbo.StudentData.CourseID = @CourseID 
END  

--Level,Degree,Tutor,Course AND Faculty
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID = -1 AND  @FacultyID != -1 AND @YearID != -1)
BEGIN 
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID 
                              AND StudentData.[TutorID] = @TutorID AND StudentData.[FacultyID] = @FacultyID
                              AND StudentData.[LevelID] = @degreelevelID 
                              AND dbo.StudentData.[CourseID] = @CourseID 
END  

--Level,Degree,Tutor,Course, Faculty AND Year
IF (@DegreelevelID != -1 AND @ModuleID != -1 AND @DegreeID != -1 AND @TutorID != -1 AND @CourseID = -1 AND  @FacultyID != -1 AND @YearID != -1)
BEGIN
    SELECT DISTINCT StudentData.*, ModuleLookUp.ModuleCode
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             StudentData.[DegreeID] = @degreeID AND ModuleLookUp.[ModuleID] = @ModuleID  
                              AND StudentData.[TutorID] = @TutorID AND StudentData.[FacultyID] = @FacultyID
                              AND StudentData.[YearID] = @YearID AND StudentData.[LevelID] = @degreelevelID 
                              AND dbo.StudentData.CourseID = @CourseID 
END  




END 



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Aminah>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_BasicQuery] 
	@DegreelevelID int , 
	@ModuleID int, 
	@DegreeID int, 
	@TutorID int, 
	@CourseID int, 
	@FacultyID int, 
	@YearID int 
AS
BEGIN 
	SET NOCOUNT ON; 
-- Using "AND" as logical link 
IF (@DegreelevelID = -1 AND @ModuleID = -1 AND @DegreeID = -1 AND @TutorID = -1 AND @CourseID = -1 AND  @FacultyID = -1 AND @YearID = -1)
BEGIN
    SELECT DISTINCT StudentData.StudentName, StudentData.UniEmail, StudentData.StudentNumber, REPLACE(LevelLookUp.LevelName COLLATE Latin1_General_BIN, ' Year',' ') 'Level',
					ModuleLookUp.ModuleCode as 'Module', FacultyLookUp.FacultyName 'Faculty', DegreeLookUp.DegreeCode 'Degree Name',
					CourseLookUp.CourseName 'Course', TutorLookUp.TutorName 'Tutor', YearLookUp.YearName 'Year' 
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             (@degreeID = NULL) 
                      AND (@ModuleID = NULL)
                      AND (@FacultyID = NULL)
                      AND (@YearID = NULL)
                      AND (@degreelevelID = NULL) 
                      AND (@CourseID = NULL)
                      AND (@TutorID = NULL)
END
IF (@ModuleID != -1) 
BEGIN
    SELECT DISTINCT StudentData.StudentName, StudentData.UniEmail, StudentData.StudentNumber, REPLACE(LevelLookUp.LevelName COLLATE Latin1_General_BIN, ' Year',' ') 'Level',
					ModuleLookUp.ModuleCode as 'Module', FacultyLookUp.FacultyName 'Faculty', DegreeLookUp.DegreeCode 'Degree Name',
					CourseLookUp.CourseName 'Course', TutorLookUp.TutorName 'Tutor', YearLookUp.YearName 'Year' 
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             (@degreeID = -1 OR StudentData.[DegreeID] = @degreeID) 
                      AND (@ModuleID = -1 OR ModuleLookUp.[ModuleID] = @ModuleID)
                      AND (@FacultyID = -1 OR  StudentData.[FacultyID] = @FacultyID)
                      AND (@YearID = -1 OR StudentData.[YearID] = @YearID)
                      AND (@degreelevelID = -1 OR StudentData.[LevelID] = @degreelevelID) 
                      AND (@CourseID = -1 OR dbo.StudentData.CourseID = @CourseID )
                      AND (@TutorID = -1 OR dbo.StudentData.TutorID = @TutorID )
END
ELSE
BEGIN
    SELECT DISTINCT StudentData.StudentName, StudentData.UniEmail, StudentData.StudentNumber, LevelLookUp.LevelName 'Level',
					' ' as 'Module', FacultyLookUp.FacultyName 'Faculty', DegreeLookUp.DegreeCode 'Degree Name',
					CourseLookUp.CourseName 'Course', TutorLookUp.TutorName 'Tutor', YearLookUp.YearName 'Year' 
    FROM              dbo.StudentData INNER JOIN
                      dbo.StudentModule ON dbo.StudentData.StudentID = dbo.StudentModule.StudentID INNER JOIN
                      dbo.ModuleLookUp ON dbo.StudentModule.ModuleID = dbo.ModuleLookUp.ModuleID INNER JOIN
                      dbo.LevelLookUp ON dbo.StudentData.LevelID = dbo.LevelLookUp.LevelID INNER JOIN
                      dbo.FacultyLookUp ON dbo.StudentData.FacultyID = dbo.FacultyLookUp.FacultyID INNER JOIN
                      dbo.DegreeLookUp ON dbo.StudentData.DegreeID = dbo.DegreeLookUp.DegreeID INNER JOIN
                      dbo.CourseLookUp ON dbo.StudentData.CourseID = dbo.CourseLookUp.CourseID INNER JOIN
                      dbo.TutorLookUp ON dbo.StudentData.TutorID = dbo.TutorLookUp.TutorID INNER JOIN
                      dbo.YearLookUp ON dbo.StudentData.YearID = dbo.YearLookUp.YearID 
    WHERE             (@degreeID = -1 OR StudentData.[DegreeID] = @degreeID) 
                      AND (@ModuleID = -1 OR ModuleLookUp.[ModuleID] = @ModuleID)
                      AND (@FacultyID = -1 OR  StudentData.[FacultyID] = @FacultyID)
                      AND (@YearID = -1 OR StudentData.[YearID] = @YearID)
                      AND (@degreelevelID = -1 OR StudentData.[LevelID] = @degreelevelID) 
                      AND (@CourseID = -1 OR dbo.StudentData.CourseID = @CourseID )
                      AND (@TutorID = -1 OR dbo.StudentData.TutorID = @TutorID )



END  

END 



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE LogicalLinkExample
	-- Add the parameters for the stored procedure here 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  *
FROM [Student_Mailer].[dbo].[StudentData] as sd
WHERE (levelID = 3 or  levelID = 4) AND (tutorID = 58 and degreeID = 2 And sd.yearID != 1)
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.Module
AS
SELECT DISTINCT ModuleID, ModuleName, ModuleCode
FROM         dbo.ModuleLookUp

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Proc_UnionStudentData 
	-- Add the parameters for the stored procedure here
	@DegreelevelID int , 
	@ModuleID int, 
	@DegreeID int, 
	@TutorID int, 
	@CourseID int, 
	@FacultyID int, 
	@YearID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--Insert statement for procedure here 
SELECT DISTINCT A.* FROM
(
	SELECT DISTINCT [StudentName],[StudentNumber],[UniEmail]
	FROM StudentData 
	WHERE  [LevelID] = @degreelevelID
	
    UNION 
    
    SELECT DISTINCT SD.[StudentName],SD.[StudentNumber],SD.[UniEmail]
	FROM StudentData AS SD LEFT JOIN StudentModule AS SM ON SD.StudentID = SM.StudentID 
	WHERE SM.ModuleID = @ModuleID
	
	UNION 
	
	SELECT DISTINCT [StudentName],[StudentNumber],[UniEmail]
	FROM StudentData 
	WHERE  [DegreeID] = @degreeID
	
	UNION 
	
	SELECT DISTINCT [StudentName],[StudentNumber],[UniEmail]
	FROM StudentData WHERE  [TutorID] = @TutorID
	
	UNION 
	
	SELECT DISTINCT [StudentName],[StudentNumber],[UniEmail]
	FROM StudentData 
	WHERE  [CourseID] = @CourseID 
	
	UNION 
	
	SELECT DISTINCT [StudentName],[StudentNumber],[UniEmail]
	FROM StudentData 
	WHERE  [FacultyID] = @FacultyID 
	
    UNION 
    
    SELECT DISTINCT [StudentName],[StudentNumber],[UniEmail]
	FROM StudentData 
	WHERE  [YearID] = @YearID 
	
	)A 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Aminah>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_QueryByYear]
	-- Add the parameters for the stored procedure here
	@yearID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT tbl.StudentName, tbl.StudentNumber, tbl.UniEmail
	FROM 
		StudentData AS tbl
	WHERE 
		tbl.yearID = @yearID
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Aminah> 
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_QueryByStudentNumber]
	-- Add the parameters for the stored procedure here
	@StdNum nvarchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT DISTINCT tbl.StudentName, tbl.StudentNumber, tbl.UniEmail
FROM StudentData tbl
WHERE  tbl.StudentNumber = @StdNum
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Aminah Yussuf>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_QueryByModule] 
	-- Add the parameters for the stored procedure here
	@ModuleID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT tbl.StudentName, tbl.StudentNumber, tbl.UniEmail 
	FROM   StudentData tbl LEFT JOIN StudentModule AS tbl1
	ON  tbl.StudentID = tbl1.StudentID AND tbl.YearID = tbl1.YearID
    WHERE tbl1.ModuleID = @ModuleID
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Aminah>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_QueryByLevel]
	-- Add the parameters for the stored procedure her
	@LevelID INT  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT tbl.StudentName, tbl.StudentNumber, tbl.UniEmail
	FROM StudentData tbl
	WHERE tbl.LevelID = @LevelID; 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Aminah> 
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_QueryByFaculty] 
	-- Add the parameters for the stored procedure here
	@FacultyID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT tbl.StudentName, tbl.StudentNumber, tbl.UniEmail
	FROM StudentData tbl 
	where tbl.facultyID = @FacultyID 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.[Level]
AS
SELECT DISTINCT LevelID, LevelName
FROM         dbo.LevelLookUp

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.Faculty
AS
SELECT DISTINCT FacultyID, FacultyName
FROM         dbo.FacultyLookUp

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.Degree
AS
SELECT DISTINCT DegreeID, DegreeName, DegreeCode
FROM         dbo.DegreeLookUp

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.Course
AS
SELECT DISTINCT CourseID, CourseName
FROM         dbo.CourseLookUp

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.AcademicYear
AS
SELECT DISTINCT YearID, YearName
FROM         dbo.YearLookUp

GO
ALTER TABLE [dbo].[DegreeLookUp]  WITH CHECK ADD  CONSTRAINT [FK_DegreeCode] FOREIGN KEY([DegreeID])
REFERENCES [dbo].[DegreeLookUp] ([DegreeID])
GO
ALTER TABLE [dbo].[DegreeLookUp] CHECK CONSTRAINT [FK_DegreeCode]
GO
