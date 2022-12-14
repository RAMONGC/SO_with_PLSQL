--INICIA PROCEDIMIENTO DEL LOGIN

DECLARE

	BAND_USER NUMBER;
	BAND_CONT NUMBER;

BEGIN
	
	IF :US.USER || :US.CONT IS NULL THEN
		:US.MENSAJE := 'Debe ingresar todos los campos.';
	ELSE
		SELECT 1 
		INTO BAND_USER
		FROM DUMMY_USERS
		WHERE USER_NAME = :US.USER;
		
		SELECT 1
		INTO BAND_CONT
		FROM DUMMY_USERS
		WHERE PASSWORD = :US.CONT;
		
		IF BAND_USER = 1 AND BAND_CONT = 1 THEN
			:US.MENSAJE := 'Bienvenido ' || :US.USER;
			:global.ACTUAL_DIRECTORY := 2;
			:GLOBAL.US_NAME := :US.USER;
			
			SELECT USER_ID 
			INTO :global.US_ID
			FROM DUMMY_USERS
			WHERE USER_NAME = :US.USER;
			
				GO_BLOCK('CONSOL');
		  	--	Execute_query;
		ELSE
			:US.MENSAJE := 'Usuario o contraseña incorrecto';
		END IF;
	END IF;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			:US.MENSAJE := 'Usuario o contraseña incorrecto';

END;


--TERMINA PROCEDIMIENTO DEL LOGIN
