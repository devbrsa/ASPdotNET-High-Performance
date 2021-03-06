USE [master]
GO

CREATE DATABASE [SelectNPlusOneTestDB-001]
GO

USE [SelectNPlusOneTestDB-001]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogPost](
	[BlogPostId] [int] IDENTITY(1,1) NOT NULL,	
	[Title] [nvarchar](max) NULL,
	[Content] [nvarchar](max) NULL,
 CONSTRAINT [PK_BlogPost] PRIMARY KEY CLUSTERED 
(
	[BlogPostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogPostComment](
	[BlogPostCommentId] [int] IDENTITY(1,1) NOT NULL,
	[BlogPostId] [int] NOT NULL,
	[CommenterName] [nvarchar](max) NULL,
	[Content] [nvarchar](max) NULL,
 CONSTRAINT [PK_BlogPostComment] PRIMARY KEY CLUSTERED 
(
	[BlogPostCommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET NOCOUNT ON
GO

DECLARE @II INT = 0
WHILE @II < 1000
BEGIN
	SET @II = @II + 1
	INSERT INTO BlogPost (Title, Content)
	VALUES('My Awesome Post', 'Write something witty here...'),
		  ('My Second Awesome Post', 'Try harder to write something witty here...'),
		  ('My Third Awesome Post', 'Give up and go full buzzfeed...')
	DECLARE @JJ INT = 0
	WHILE @JJ < @II % 31
	BEGIN
		SET @JJ = @JJ + 1
		INSERT BlogPostComment (BlogPostId, CommenterName, Content) 
		VALUES (@II * ((@II % 3) + 1), N'Dave', N'Nice post! I have a constructive retort...'),
			   (@II + (@II % 2), N'Ms Test', N'I wish to air a grievance unrelated to this post...'),
			   (@II + (@II % 3), N'Lillian Steve III', N'WE CAN HELP SEO YOU WEBSITE, CONTACT ME THE SAME!!!')
	END
END

SET NOCOUNT OFF
GO

ALTER TABLE [dbo].[BlogPostComment]  WITH CHECK ADD  CONSTRAINT [FK_BlogPostComment_BlogPost_BlogPostId] FOREIGN KEY([BlogPostId])
REFERENCES [dbo].[BlogPost] ([BlogPostId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogPostComment] CHECK CONSTRAINT [FK_BlogPostComment_BlogPost_BlogPostId]
GO
