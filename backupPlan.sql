-- Full Backups

USE msdb;
GO

EXEC dbo.sp_add_job
    @job_name = N'Weekly_Full_Backup_CharityDB',
    @enabled = 1,
    @description = N'Weekly full backup of CharityDB',
    @category_name = N'Database Maintenance';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'Weekly_Full_Backup_CharityDB',
    @step_name = N'Backup Database',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE [CharityDB] TO DISK = ''<YourBackupFolder>\CharityDB_Full.bak'' WITH INIT, COMPRESSION;',
    @retry_attempts = 5,
    @retry_interval = 5;
GO

-- Differential Backup 

USE msdb;
GO

EXEC dbo.sp_add_job
    @job_name = N'Daily_Diff_Backup_CharityDB',
    @enabled = 1,
    @description = N'Daily differential backup of CharityDB',
    @category_name = N'Database Maintenance';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'Daily_Diff_Backup_CharityDB',
    @step_name = N'Backup Database',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE [CharityDB] TO DISK = ''<YourBackupFolder>\CharityDB_Diff.bak'' WITH DIFFERENTIAL, COMPRESSION;',
    @retry_attempts = 5,
    @retry_interval = 5;
GO

-- Transaction Log Backup

USE msdb;
GO

EXEC dbo.sp_add_job
    @job_name = N'Hourly_Log_Backup_CharityDB',
    @enabled = 1,
    @description = N'Hourly transaction log backup of CharityDB',
    @category_name = N'Database Maintenance';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'Hourly_Log_Backup_CharityDB',
    @step_name = N'Backup Transaction Log',
    @subsystem = N'TSQL',
    @command = N'BACKUP LOG [CharityDB] TO DISK = ''<YourBackupFolder>\CharityDB_Log.trn'' WITH INIT, COMPRESSION;',
    @retry_attempts = 5,
    @retry_interval = 5;
GO
