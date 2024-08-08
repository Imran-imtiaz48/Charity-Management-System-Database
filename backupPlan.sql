-- Full Backup Job Setup

USE msdb;
GO

-- Add the Full Backup Job
EXEC dbo.sp_add_job
    @job_name = N'Weekly_Full_Backup_CharityDB',
    @enabled = 1,
    @description = N'Weekly full backup of CharityDB',
    @category_name = N'Database Maintenance';
GO

-- Add the Job Step for Full Backup
EXEC dbo.sp_add_jobstep
    @job_name = N'Weekly_Full_Backup_CharityDB',
    @step_name = N'Backup Database',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE [CharityDB] TO DISK = ''<YourBackupFolder>\CharityDB_Full.bak'' WITH INIT, COMPRESSION;',
    @retry_attempts = 5,
    @retry_interval = 5;
GO

-- Add a Job Schedule for Weekly Full Backup
EXEC dbo.sp_add_schedule
    @schedule_name = N'Weekly_Full_Backup_Schedule',
    @freq_type = 8,  -- Weekly
    @freq_interval = 1,  -- Every week
    @freq_subday_type = 1,  -- At a specific time
    @freq_subday_interval = 0,
    @active_start_time = 20000;  -- 2:00 AM
GO

-- Associate the Schedule with the Full Backup Job
EXEC dbo.sp_attach_schedule
    @job_name = N'Weekly_Full_Backup_CharityDB',
    @schedule_name = N'Weekly_Full_Backup_Schedule';
GO

-- Enable the Full Backup Job
EXEC dbo.sp_add_jobserver
    @job_name = N'Weekly_Full_Backup_CharityDB';
GO

-- Differential Backup Job Setup

USE msdb;
GO

-- Add the Differential Backup Job
EXEC dbo.sp_add_job
    @job_name = N'Daily_Diff_Backup_CharityDB',
    @enabled = 1,
    @description = N'Daily differential backup of CharityDB',
    @category_name = N'Database Maintenance';
GO

-- Add the Job Step for Differential Backup
EXEC dbo.sp_add_jobstep
    @job_name = N'Daily_Diff_Backup_CharityDB',
    @step_name = N'Backup Database',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE [CharityDB] TO DISK = ''<YourBackupFolder>\CharityDB_Diff.bak'' WITH DIFFERENTIAL, COMPRESSION;',
    @retry_attempts = 5,
    @retry_interval = 5;
GO

-- Add a Job Schedule for Daily Differential Backup
EXEC dbo.sp_add_schedule
    @schedule_name = N'Daily_Diff_Backup_Schedule',
    @freq_type = 4,  -- Daily
    @freq_interval = 1,  -- Every day
    @freq_subday_type = 1,  -- At a specific time
    @freq_subday_interval = 0,
    @active_start_time = 30000;  -- 3:00 AM
GO

-- Associate the Schedule with the Differential Backup Job
EXEC dbo.sp_attach_schedule
    @job_name = N'Daily_Diff_Backup_CharityDB',
    @schedule_name = N'Daily_Diff_Backup_Schedule';
GO

-- Enable the Differential Backup Job
EXEC dbo.sp_add_jobserver
    @job_name = N'Daily_Diff_Backup_CharityDB';
GO

-- Transaction Log Backup Job Setup

USE msdb;
GO

-- Add the Transaction Log Backup Job
EXEC dbo.sp_add_job
    @job_name = N'Hourly_Log_Backup_CharityDB',
    @enabled = 1,
    @description = N'Hourly transaction log backup of CharityDB',
    @category_name = N'Database Maintenance';
GO

-- Add the Job Step for Transaction Log Backup
EXEC dbo.sp_add_jobstep
    @job_name = N'Hourly_Log_Backup_CharityDB',
    @step_name = N'Backup Transaction Log',
    @subsystem = N'TSQL',
    @command = N'BACKUP LOG [CharityDB] TO DISK = ''<YourBackupFolder>\CharityDB_Log.trn'' WITH INIT, COMPRESSION;',
    @retry_attempts = 5,
    @retry_interval = 5;
GO

-- Add a Job Schedule for Hourly Transaction Log Backup
EXEC dbo.sp_add_schedule
    @schedule_name = N'Hourly_Log_Backup_Schedule',
    @freq_type = 4,  -- Daily
    @freq_interval = 1,  -- Every day
    @freq_subday_type = 8,  -- Hourly
    @freq_subday_interval = 1,  -- Every hour
    @active_start_time = 0;  -- Start at midnight
GO

-- Associate the Schedule with the Transaction Log Backup Job
EXEC dbo.sp_attach_schedule
    @job_name = N'Hourly_Log_Backup_CharityDB',
    @schedule_name = N'Hourly_Log_Backup_Schedule';
GO

-- Enable the Transaction Log Backup Job
EXEC dbo.sp_add_jobserver
    @job_name = N'Hourly_Log_Backup_CharityDB';
GO
