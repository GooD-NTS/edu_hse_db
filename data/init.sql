-- create db
create database crash_reports;
\connect crash_reports;

-- create schema
create schema edu

	-- create table for storing application version information
	create table app_version (
		id bigserial primary key,
		created_at timestamp not null default current_timestamp,
		display_name varchar(255) not null
	)

	-- create table for storing hardware information
	create table hardware_info (
		id bigserial primary key,
		created_at timestamp not null default current_timestamp,
		current_hardware_info jsonb
	)

	-- create table for storing user information
	create table app_user (
		id bigserial primary key,
		created_at timestamp not null default current_timestamp,
		current_app_version_id int,
		current_hardware_info_id int,
		foreign key (current_app_version_id) references app_version(id),
		foreign key (current_hardware_info_id) references hardware_info(id)
	)

	-- create table for storing crash report information
	create table crash_report (
		id bigserial primary key,
		created_at timestamp not null default current_timestamp,
		user_id int,
		app_version_id int,
		hardware_info_id int,
		foreign key (user_id) references app_user(id),
		foreign key (app_version_id) references app_version(id),
		foreign key (hardware_info_id) references hardware_info(id)
	)

	-- create table for storing crash report call stack
	create table crash_report_callstack (
		id bigserial primary key,
		report_id int,
		data text not null,
		foreign key (report_id) references crash_report(id)
	)

	-- create table for storing crash report data
	create table crash_report_additionaldata (
		id bigserial primary key,
		report_id int,
		type int,
		data text not null,
		foreign key (report_id) references crash_report(id)
	);