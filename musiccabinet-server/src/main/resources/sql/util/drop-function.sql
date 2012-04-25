create or replace function util.drop_function(schema varchar(100), function_name varchar(100)) returns int as $$
declare
	dropStatement varchar;
begin

	if exists (select 1 from pg_proc proc 
		inner join pg_language lang on proc.prolang = lang.oid 
		where lang.lanname = 'plpgsql' and proname = function_name) then

		select 'drop function ' || schema || '.' || proname || 
		'(' || oidvectortypes(proargtypes) || ');'
		into dropStatement from pg_proc proc
		inner join pg_language lang on proc.prolang = lang.oid 
		where lang.lanname = 'plpgsql' and proname = function_name;
		
		execute dropStatement;
	
	end if;

	return 0;

end;
$$ language plpgsql;
