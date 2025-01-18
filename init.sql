-- Create table for storing application version information
CREATE TABLE AppVersion (
    id BIGSERIAL PRIMARY KEY,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    DisplayName VARCHAR(255) NOT NULL
);

-- Create table for storing hardware information
CREATE TABLE HardwareInfo (
    id BIGSERIAL PRIMARY KEY,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CurrentHardwareInfo JSONB,
);

-- Create table for storing user information
CREATE TABLE AppUser (
    id BIGSERIAL PRIMARY KEY,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CurrentAppVersionId INT,
    CurrentHardwareInfoId INT,
    FOREIGN KEY (CurrentAppVersionId) REFERENCES AppVersion(id),
	FOREIGN KEY (CurrentHardwareInfoId) REFERENCES HardwareInfo(id)
);

-- Create table for storing crash report information
CREATE TABLE CrashReport (
    id BIGSERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    userId INT,
    appVersionId INT,
	HardwareInfoId INT,
    FOREIGN KEY (userId) REFERENCES AppUser(id),
    FOREIGN KEY (appVersionId) REFERENCES AppVersion(id)
	FOREIGN KEY (HardwareInfoId) REFERENCES HardwareInfo(id)
);

-- Create table for storing crash report call stack
CREATE TABLE CrashReportCallStack (
    id BIGSERIAL PRIMARY KEY,
    reportId INT,
    data TEXT NOT NULL,
    FOREIGN KEY (reportId) REFERENCES CrashReport(id)
);

-- Create table for storing crash report data
CREATE TABLE CrashReportAdditionalData (
    id BIGSERIAL PRIMARY KEY,
    reportId INT,
    type INT,
    data TEXT NOT NULL,
    FOREIGN KEY (reportId) REFERENCES CrashReport(id)
);