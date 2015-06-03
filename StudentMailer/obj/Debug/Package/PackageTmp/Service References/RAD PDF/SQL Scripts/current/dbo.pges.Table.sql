/****** Object:  Table [dbo].[pges]    Script Date: 07/11/2010 12:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pges](
	[pgeID] [int] IDENTITY(1,1) NOT NULL,
	[pdfID] [int] NOT NULL,
	[docID] [int] NOT NULL,
	[keyID] [int] NOT NULL,
	[pgeDate] [datetime] NOT NULL,
	[pgeStatus] [int] NOT NULL,
	[pgeNumber] [int] NOT NULL,
	[pgeImageType] [int] NOT NULL,
	[pgeImageData] [image] NULL,
 CONSTRAINT [PK_pges] PRIMARY KEY CLUSTERED 
(
	[pgeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
