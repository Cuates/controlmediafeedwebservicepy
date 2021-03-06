-- Database Connect
use [Media]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- Procedure Drop
drop procedure if exists dbo.insertupdatedeleteControlMediaFeed
go

-- ================================================
--        File: insertupdatedeleteControlMediaFeed
--     Created: 11/16/2020
--     Updated: 11/18/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert update delete control media feed
-- ================================================

-- Procedure Create
create procedure [dbo].[insertupdatedeleteControlMediaFeed]
  -- Add the parameters for the stored procedure here
  @optionMode nvarchar(max),
  @actionnumber nvarchar(max) = null,
  @actiondescription nvarchar(max) = null,
  @audioencode nvarchar(max) = null,
  @dynamicrange nvarchar(max) = null,
  @resolution nvarchar(max) = null,
  @streamsource nvarchar(max) = null,
  @streamdescription nvarchar(max) = null,
  @videoencode nvarchar(max) = null,
  @movieinclude nvarchar(max) = null,
  @tvinclude nvarchar(max) = null
as
begin
  -- Set nocount on added to prevent extra result sets from interfering with select statements
  set nocount on

  -- Declare variables
  declare @omitOptionMode as nvarchar(max)
  declare @omitActionNumber as nvarchar(max)
  declare @omitActionDescription as nvarchar(max)
  declare @omitMediaAudioEncode as nvarchar(max)
  declare @omitMediaDynamicRange as nvarchar(max)
  declare @omitMediaResolution as nvarchar(max)
  declare @omitMediaStreamSource as nvarchar(max)
  declare @omitMediaStreamDescription as nvarchar(max)
  declare @omitMediaVideoEncode as nvarchar(max)
  declare @omitMovieInclude as nvarchar(max)
  declare @omitTVInclude as nvarchar(max)
  declare @maxLengthOptionMode as int
  declare @maxLengthActionNumber as int
  declare @maxLengthActionDescription as int
  declare @maxLengthMediaAudioEncode as int
  declare @maxLengthMediaDynamicRange as int
  declare @maxLengthMediaResolution as int
  declare @maxLengthMediaStreamSource as int
  declare @maxLengthMediaStreamDescription as int
  declare @maxLengthMediaVideoEncode as int
  declare @maxLengthMovieInclude as int
  declare @maxLengthTVInclude as int
  declare @result as nvarchar(max)

  -- Set variables
  set @omitOptionMode = N'0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitActionNumber = N'0,1,2,3,4,5,6,7,8,9'
  set @omitActionDescription = N'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitMediaAudioEncode = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9,.,-'
  set @omitMediaDynamicRange = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z'
  set @omitMediaResolution = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9'
  set @omitMediaStreamSource = N'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitMediaStreamDescription = N'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitMediaVideoEncode = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9'
  set @omitMovieInclude = N'0,1'
  set @omitTVInclude = N'0,1'
  set @maxLengthOptionMode = 255
  set @maxLengthActionNumber = 255
  set @maxLengthActionDescription = 255
  set @maxLengthMediaAudioEncode = 100
  set @maxLengthMediaDynamicRange = 100
  set @maxLengthMediaResolution = 100
  set @maxLengthMediaStreamSource = 100
  set @maxLengthMediaStreamDescription = 100
  set @maxLengthMediaVideoEncode = 100
  set @maxLengthMovieInclude = 1
  set @maxLengthTVInclude = 1
  set @result = ''

  -- Check if parameter is not null
  if @optionMode is not null
    begin
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set @optionMode = dbo.omitcharacters(@optionMode, @omitOptionMode)

      -- Set character limit
      set @optionMode = trim(substring(@optionMode, 1, @maxLengthOptionMode))

      -- Check if empty string
      if @optionMode = ''
        begin
          -- Set parameter to null if empty string
          set @optionMode = nullif(@optionMode, '')
        end
    end

  -- Check if parameter is not null
  if @actionnumber is not null
    begin
      -- Omit characters
      set @actionnumber = dbo.OmitCharacters(@actionnumber, @omitActionNumber)

      -- Set character limit
      set @actionnumber = trim(substring(@actionnumber, 1, @maxLengthActionNumber))

      -- Check if empty string
      if @actionnumber = ''
        begin
          -- Set parameter to null if empty string
          set @actionnumber = nullif(@actionnumber, '')
        end
    end

  -- Check if parameter is not null
  if @actiondescription is not null
    begin
      -- Omit characters
      set @actiondescription = dbo.OmitCharacters(@actiondescription, @omitActionDescription)

      -- Set character limit
      set @actiondescription = trim(substring(@actiondescription, 1, @maxLengthActionDescription))

      -- Check if empty string
      if @actiondescription = ''
        begin
          -- Set parameter to null if empty string
          set @actiondescription = nullif(@actiondescription, '')
        end
    end

  -- Check if parameter is not null
  if @audioencode is not null
    begin
      -- Omit characters
      set @audioencode = dbo.OmitCharacters(@audioencode, @omitMediaAudioEncode)

      -- Set character limit
      set @audioencode = trim(substring(@audioencode, 1, @maxLengthMediaAudioEncode))

      -- Check if empty string
      if @audioencode = ''
        begin
          -- Set parameter to null if empty string
          set @audioencode = nullif(@audioencode, '')
        end
    end

  -- Check if parameter is not null
  if @dynamicrange is not null
    begin
      -- Omit characters
      set @dynamicrange = dbo.OmitCharacters(@dynamicrange, @omitMediaDynamicRange)

      -- Set character limit
      set @dynamicrange = trim(substring(@dynamicrange, 1, @maxLengthMediaDynamicRange))

      -- Check if empty string
      if @dynamicrange = ''
        begin
          -- Set parameter to null if empty string
          set @dynamicrange = nullif(@dynamicrange, '')
        end
    end

  -- Check if parameter is not null
  if @resolution is not null
    begin
      -- Omit characters
      set @resolution = dbo.OmitCharacters(@resolution, @omitMediaResolution)

      -- Set character limit
      set @resolution = trim(substring(@resolution, 1, @maxLengthMediaResolution))

      -- Check if empty string
      if @resolution = ''
        begin
          -- Set parameter to null if empty string
          set @resolution = nullif(@resolution, '')
        end
    end

  -- Check if parameter is not null
  if @streamsource is not null
    begin
      -- Omit characters
      set @streamsource = dbo.OmitCharacters(@streamsource, @omitMediaStreamSource)

      -- Set character limit
      set @streamsource = trim(substring(@streamsource, 1, @maxLengthMediaStreamSource))

      -- Check if empty string
      if @streamsource = ''
        begin
          -- Set parameter to null if empty string
          set @streamsource = nullif(@streamsource, '')
        end
    end

  -- Check if parameter is not null
  if @streamdescription is not null
    begin
      -- Omit characters
      set @streamdescription = dbo.OmitCharacters(@streamdescription, @omitMediaStreamDescription)

      -- Set character limit
      set @streamdescription = trim(substring(@streamdescription, 1, @maxLengthMediaStreamDescription))

      -- Check if empty string
      if @streamdescription = ''
        begin
          -- Set parameter to null if empty string
          set @streamdescription = nullif(@streamdescription, '')
        end
    end

  -- Check if parameter is not null
  if @videoencode is not null
    begin
      -- Omit characters
      set @videoencode = dbo.OmitCharacters(@videoencode, @omitMediaVideoEncode)

      -- Set character limit
      set @videoencode = trim(substring(@videoencode, 1, @maxLengthMediaVideoEncode))

      -- Check if empty string
      if @videoencode = ''
        begin
          -- Set parameter to null if empty string
          set @videoencode = nullif(@videoencode, '')
        end
    end

  -- Check if parameter is not null
  if @movieinclude is not null
    begin
      -- Omit characters
      set @movieinclude = dbo.OmitCharacters(@movieinclude, @omitMovieInclude)

      -- Set character limit
      set @movieinclude = trim(substring(@movieinclude, 1, @maxLengthMovieInclude))

      -- Check if empty string
      if @movieinclude = ''
        begin
          -- Set parameter to null if empty string
          set @movieinclude = nullif(@movieinclude, '')
        end
    end

  -- Check if parameter is not null
  if @tvinclude is not null
    begin
      -- Omit characters
      set @tvinclude = dbo.OmitCharacters(@tvinclude, @omitTVInclude)

      -- Set character limit
      set @tvinclude = trim(substring(@tvinclude, 1, @maxLengthTVInclude))

      -- Check if empty string
      if @tvinclude = ''
        begin
          -- Set parameter to null if empty string
          set @tvinclude = nullif(@tvinclude, '')
        end
    end

  -- Check if option mode is insert action status
  if @optionMode = 'insertActionStatus'
    begin
      -- Check if parameters are null
      if @actionnumber is not null and @actiondescription is not null
        begin
          -- Check if record exist
          if not exists
          (
            -- Select record in question
            select
            ast.actionnumber as [actionnumber]
            from dbo.ActionStatus ast
            where
            ast.actionnumber = @actionnumber
            group by ast.actionnumber
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Insert record
                  insert into dbo.ActionStatus
                  (
                    actionnumber,
                    actiondescription,
                    created_date,
                    modified_date
                  )
                  values
                  (
                    @actionnumber,
                    @actiondescription,
                    cast(getdate() as datetime2(6)),
                    cast(getdate() as datetime2(6))
                  )

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record inserted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record already exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, action number and action description were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is insert media audio encode
  else if @optionMode = 'insertMediaAudioEncode'
    begin
      -- Check if parameters are null
      if @audioencode is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if not exists
          (
            -- Select record in question
            select
            mae.audioencode as [audioencode]
            from dbo.MediaAudioEncode mae
            where
            mae.audioencode = @audioencode
            group by mae.audioencode
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Insert record
                  insert into dbo.MediaAudioEncode
                  (
                    audioencode,
                    movieInclude,
                    tvInclude,
                    created_date,
                    modified_date
                  )
                  values
                  (
                    @audioencode,
                    @movieinclude,
                    @tvinclude,
                    cast(getdate() as datetime2(6)),
                    cast(getdate() as datetime2(6))
                  )

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record inserted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record already exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, audio encode, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is insert media dynamic range
  else if @optionMode = 'insertMediaDynamicRange'
    begin
      -- Check if parameters are null
      if @dynamicrange is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if not exists
          (
            -- Select record in question
            select
            mdr.dynamicrange as [dynamicrange]
            from dbo.MediaDynamicRange mdr
            where
            mdr.dynamicrange = @dynamicrange
            group by mdr.dynamicrange
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Insert record
                  insert into dbo.MediaDynamicRange
                  (
                    dynamicrange,
                    movieInclude,
                    tvInclude,
                    created_date,
                    modified_date
                  )
                  values
                  (
                    @dynamicrange,
                    @movieinclude,
                    @tvinclude,
                    cast(getdate() as datetime2(6)),
                    cast(getdate() as datetime2(6))
                  )

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record inserted"}'

                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record already exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, dynamic range, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is insert media resolution
  else if @optionMode = 'insertMediaResolution'
    begin
      -- Check if parameters are null
      if @resolution is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if not exists
          (
            -- Select record in question
            select
            mr.resolution as [resolution]
            from dbo.MediaResolution mr
            where
            mr.resolution = @resolution
            group by mr.resolution
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Insert record
                  insert into dbo.MediaResolution
                  (
                    resolution,
                    movieInclude,
                    tvInclude,
                    created_date,
                    modified_date
                  )
                  values
                  (
                    @resolution,
                    @movieinclude,
                    @tvinclude,
                    cast(getdate() as datetime2(6)),
                    cast(getdate() as datetime2(6))
                  )

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record inserted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record already exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, resolution, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is insert media stream source
  else if @optionMode = 'insertMediaStreamSource'
    begin
      -- Check if parameters are null
      if @streamsource is not null and @streamdescription is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if not exists
          (
            -- Select record in question
            select
            mss.streamsource as [streamsource]
            from dbo.MediaStreamSource mss
            where
            mss.streamsource = @streamsource
            group by mss.streamsource
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Insert record
                  insert into dbo.MediaStreamSource
                  (
                    streamsource,
                    streamdescription,
                    movieInclude,
                    tvInclude,
                    created_date,
                    modified_date
                  )
                  values
                  (
                    @streamsource,
                    @streamdescription,
                    @movieinclude,
                    @tvinclude,
                    cast(getdate() as datetime2(6)),
                    cast(getdate() as datetime2(6))
                  )

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record inserted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record already exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, stream source, stream description, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is insert media video encode
  else if @optionMode = 'insertMediaVideoEncode'
    begin
      -- Check if parameters are null
      if @videoencode is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if not exists
          (
            -- Select record in question
            select
            mve.videoencode as [videoencode]
            from dbo.MediaVideoEncode mve
            where
            mve.videoencode = @videoencode
            group by mve.videoencode
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Insert record
                  insert into dbo.MediaVideoEncode
                  (
                    videoencode,
                    movieInclude,
                    tvInclude,
                    created_date,
                    modified_date
                  )
                  values
                  (
                    @videoencode,
                    @movieinclude,
                    @tvinclude,
                    cast(getdate() as datetime2(6)),
                    cast(getdate() as datetime2(6))
                  )

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record inserted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record already exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, video encode, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update action status
  else if @optionMode = 'updateActionStatus'
    begin
      -- Check if parameters are null
      if @actionnumber is not null and @actiondescription is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            ast.actionnumber as [actionnumber]
            from dbo.ActionStatus ast
            where
            ast.actionnumber = @actionnumber
            group by ast.actionnumber
          )
            begin
              -- Check if record does not exist
              if not exists
              (
                -- Select record in question
                select
                ast.actionnumber as [actionnumber]
                from dbo.ActionStatus ast
                where
                ast.actionnumber = @actionnumber and
                ast.actiondescription = @actiondescription
                group by ast.actionnumber
              )
                begin
                  -- Begin the tranaction
                  begin tran
                    -- Begin the try block
                    begin try
                      -- Insert record
                      update dbo.ActionStatus
                      set
                      actiondescription = @actiondescription,
                      modified_date = cast(getdate() as datetime2(6))
                      where
                      actionnumber = @actionnumber

                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Commit transactional statement
                          commit tran
                        end

                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record updated"}'
                    end try
                    -- End try block
                    -- Begin catch block
                    begin catch
                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Rollback to the previous state before the transaction was called
                          rollback
                        end

                      -- Set message
                      set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                    end catch
                    -- End catch block
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record already exists"}'
                end
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, action number and action description were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update media audio encode
  else if @optionMode = 'updateMediaAudioEncode'
    begin
      -- Check if parameters are null
      if @audioencode is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mae.audioencode as [audioencode]
            from dbo.MediaAudioEncode mae
            where
            mae.audioencode = @audioencode
            group by mae.audioencode
          )
            begin
              -- Check if record does not exist
              if not exists
              (
                -- Select record in question
                select
                mae.audioencode as [audioencode]
                from dbo.MediaAudioEncode mae
                where
                mae.audioencode = @audioencode and
                mae.movieInclude = @movieinclude and
                mae.tvInclude = @tvinclude
                group by mae.audioencode
              )
                begin
                  -- Begin the tranaction
                  begin tran
                    -- Begin the try block
                    begin try
                      -- Insert record
                      update dbo.MediaAudioEncode
                      set
                      movieInclude = @movieinclude,
                      tvInclude = @tvinclude,
                      modified_date = cast(getdate() as datetime2(6))
                      where
                      audioencode = @audioencode

                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Commit transactional statement
                          commit tran
                        end

                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record updated"}'
                    end try
                    -- End try block
                    -- Begin catch block
                    begin catch
                      -- Set message
                      set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')

                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Rollback to the previous state before the transaction was called
                          rollback
                        end
                    end catch
                    -- End catch block
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record already exists"}'
                end
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, audio encode, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update media dynamic range
  else if @optionMode = 'updateMediaDynamicRange'
    begin
      -- Check if parameters are null
      if @dynamicrange is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mdr.dynamicrange as [dynamicrange]
            from dbo.MediaDynamicRange mdr
            where
            mdr.dynamicrange = @dynamicrange
            group by mdr.dynamicrange
          )
            begin
              -- Check if record does not exist
              if not exists
              (
                -- Select record in question
                select
                mdr.dynamicrange as [dynamicrange]
                from dbo.MediaDynamicRange mdr
                where
                mdr.dynamicrange = @dynamicrange and
                mdr.movieInclude = @movieinclude and
                mdr.tvInclude = @tvinclude
                group by mdr.dynamicrange
              )
                begin
                  -- Begin the tranaction
                  begin tran
                    -- Begin the try block
                    begin try
                      -- Insert record
                      update dbo.MediaDynamicRange
                      set
                      movieInclude = @movieinclude,
                      tvInclude = @tvinclude,
                      modified_date = cast(getdate() as datetime2(6))
                      where
                      dynamicrange = @dynamicrange

                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Commit transactional statement
                          commit tran
                        end

                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record updated"}'
                    end try
                    -- End try block
                    -- Begin catch block
                    begin catch
                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Rollback to the previous state before the transaction was called
                          rollback
                        end

                      -- Set message
                      set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                    end catch
                    -- End catch block
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record already exists"}'
                end
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, dynamic range, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update media resolution
  else if @optionMode = 'updateMediaResolution'
    begin
      -- Check if parameters are null
      if @resolution is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mr.resolution as [resolution]
            from dbo.MediaResolution mr
            where
            mr.resolution = @resolution
            group by mr.resolution
          )
            begin
              -- Check if record does not exist
              if not exists
              (
                -- Select record in question
                select
                mr.resolution as [resolution]
                from dbo.MediaResolution mr
                where
                mr.resolution = @resolution and
                mr.movieInclude = @movieinclude and
                mr.tvInclude = @tvinclude
                group by mr.resolution
              )
                begin
                  -- Begin the tranaction
                  begin tran
                    -- Begin the try block
                    begin try
                      -- Insert record
                      update dbo.MediaResolution
                      set
                      movieInclude = @movieinclude,
                      tvInclude = @tvinclude,
                      modified_date = cast(getdate() as datetime2(6))
                      where
                      resolution = @resolution

                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Commit transactional statement
                          commit tran
                        end

                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record updated"}'
                    end try
                    -- End try block
                    -- Begin catch block
                    begin catch
                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Rollback to the previous state before the transaction was called
                          rollback
                        end

                      -- Set message
                      set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                    end catch
                    -- End catch block
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record already exists"}'
                end
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, resolution, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update media stream source
  else if @optionMode = 'updateMediaStreamSource'
    begin
      -- Check if parameters are null
      if @streamsource is not null and @streamdescription is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mss.streamsource as [streamsource]
            from dbo.MediaStreamSource mss
            where
            mss.streamsource = @streamsource
            group by mss.streamsource
          )
            begin
              -- Check if record does not exist
              if not exists
              (
                -- Select record in question
                select
                mss.streamsource as [streamsource]
                from dbo.MediaStreamSource mss
                where
                mss.streamsource = @streamsource and
                mss.streamdescription = @streamdescription and
                mss.movieInclude = @movieinclude and
                mss.tvInclude = @tvinclude
                group by mss.streamsource
              )
                begin
                  -- Begin the tranaction
                  begin tran
                    -- Begin the try block
                    begin try
                      -- Insert record
                      update dbo.MediaStreamSource
                      set
                      streamdescription = @streamdescription,
                      movieInclude = @movieinclude,
                      tvInclude = @tvinclude,
                      modified_date = cast(getdate() as datetime2(6))
                      where
                      streamsource = @streamsource

                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Commit transactional statement
                          commit tran
                        end

                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record updated"}'
                    end try
                    -- End try block
                    -- Begin catch block
                    begin catch
                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Rollback to the previous state before the transaction was called
                          rollback
                        end

                      -- Set message
                      set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                    end catch
                    -- End catch block
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record already exists"}'
                end
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, stream source, stream description, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update media video encode
  else if @optionMode = 'updateMediaVideoEncode'
    begin
      -- Check if parameters are null
      if @videoencode is not null and @movieinclude is not null and @tvinclude is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mve.videoencode as [videoencode]
            from dbo.MediaVideoEncode mve
            where
            mve.videoencode = @videoencode
            group by mve.videoencode
          )
            begin
              -- Check if record does not exist
              if not exists
              (
                -- Select record in question
                select
                mve.videoencode as [videoencode]
                from dbo.MediaVideoEncode mve
                where
                mve.videoencode = @videoencode and
                mve.movieInclude = @movieinclude and
                mve.tvInclude = @tvinclude
                group by mve.videoencode
              )
                begin
                  -- Begin the tranaction
                  begin tran
                    -- Begin the try block
                    begin try
                      -- Insert record
                      update dbo.MediaVideoEncode
                      set
                      movieInclude = @movieinclude,
                      tvInclude = @tvinclude,
                      modified_date = cast(getdate() as datetime2(6))
                      where
                      videoencode = @videoencode

                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Commit transactional statement
                          commit tran
                        end

                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record updated"}'
                    end try
                    -- End try block
                    -- Begin catch block
                    begin catch
                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Rollback to the previous state before the transaction was called
                          rollback
                        end

                      -- Set message
                      set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                    end catch
                    -- End catch block
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record already exists"}'
                end
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, video encode, movie include, and tv include were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is delete action status
  else if @optionMode = 'deleteActionStatus'
    begin
      -- Check if parameters are not null
      if @actionnumber is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            ast.actionnumber as [actionnumber]
            from dbo.ActionStatus ast
            where
            ast.actionnumber = @actionnumber
            group by ast.actionnumber
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.ActionStatus
                  where
                  actionnumber = @actionnumber

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, action number was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Check if option mode is delete media audio encode
  else if @optionMode = 'deleteMediaAudioEncode'
    begin
      -- Check if parameters are not null
      if @audioencode is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mae.audioencode as [audioencode]
            from dbo.MediaAudioEncode mae
            where
            mae.audioencode = @audioencode
            group by mae.audioencode
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.MediaAudioEncode
                  where
                  audioencode = @audioencode

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, audio encode was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Check if option mode is delete media dynamic range
  else if @optionMode = 'deleteMediaDynamicRange'
    begin
      -- Check if parameters are not null
      if @dynamicrange is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mdr.dynamicrange as [dynamicrange]
            from dbo.MediaDynamicRange mdr
            where
            mdr.dynamicrange = @dynamicrange
            group by mdr.dynamicrange
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.MediaDynamicRange
                  where
                  dynamicrange = @dynamicrange

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, dynamic range was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Check if option mode is delete media resolution
  else if @optionMode = 'deleteMediaResolution'
    begin
      -- Check if parameters are not null
      if @resolution is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mr.resolution as [resolution]
            from dbo.MediaResolution mr
            where
            mr.resolution = @resolution
            group by mr.resolution
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.MediaResolution
                  where
                  resolution = @resolution

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, resolution was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Check if option mode is delete media stream source
  else if @optionMode = 'deleteMediaStreamSource'
    begin
      -- Check if parameters are not null
      if @streamsource is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mss.streamsource as [streamsource]
            from dbo.MediaStreamSource mss
            where
            mss.streamsource = @streamsource
            group by mss.streamsource
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.MediaStreamSource
                  where
                  streamsource = @streamsource

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, stream source was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Check if option mode is delete media video encode
  else if @optionMode = 'deleteMediaVideoEncode'
    begin
      -- Check if parameters are not null
      if @videoencode is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mve.videoencode as [videoencode]
            from dbo.MediaVideoEncode mve
            where
            mve.videoencode = @videoencode
            group by mve.videoencode
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.MediaVideoEncode
                  where
                  videoencode = @videoencode

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, video encode was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end
end
GO