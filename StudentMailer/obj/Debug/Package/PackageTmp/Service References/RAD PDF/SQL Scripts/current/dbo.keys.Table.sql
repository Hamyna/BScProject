/****** Object:  Table [dbo].[keys]    Script Date: 07/11/2010 12:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[keys](
	[keyID] [int] IDENTITY(1,1) NOT NULL,
	[docID] [int] NOT NULL,
	[keyData] [char](25) NOT NULL,
	[keyExpires] [datetime] NOT NULL,
	[keySettings] [int] NOT NULL,
 CONSTRAINT [PK_keys] PRIMARY KEY CLUSTERED 
(
	[keyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
