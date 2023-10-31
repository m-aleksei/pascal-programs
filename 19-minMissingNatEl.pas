PROGRAM MissinElemNatArray;
USES crt,math;

VAR
	i, N: LONGINT;
	dk: ARRAY [1..100000] OF WORD;
	mindk: LONGINT;
	flag: BOOLEAN;
		
BEGIN
	N := 1; 
	WHILE N > 0 DO
	BEGIN
		ClrScr;
		flag := FALSE;
		WriteLn('Find MIN missing element in K array of Natural numbers.');
		WriteLn('');
		Write('Input number of elements N = '); ReadLn(N); 
		WriteLn('');
		IF N > 0 THEN
		BEGIN
			FOR i := 1 TO N DO
			BEGIN
				Write('Input K(', i,') = '); ReadLn(dk[i]);
			END;
			{ bubble sort }
			WHILE flag = FALSE DO
			BEGIN
				flag := TRUE;
				FOR i := 2 TO N DO
				BEGIN
					IF dk[i-1] > dk[i] THEN
					BEGIN
						mindk := dk[i-1];
						dk[i-1] := dk[i];
						dk[i] := mindk;
						flag := FALSE;
					END;
				END;
			END;
			WriteLn('');
			Write('Sorted K = [ ');
				FOR i := 1 TO N DO
				BEGIN
					Write('',dk[i],' ');
				END;
				WriteLn(']');
			IF dk[1] > 1 THEN
			BEGIN
				WriteLn('');
				WriteLn('Min Natural number = 1');
				ReadKey;
			END
			ELSE
			BEGIN
				flag := FALSE;
				FOR i := 2 TO N DO 
				BEGIN
					IF (((dk[i] - dk[i-1]) > 1) AND (flag = FALSE)) THEN
					BEGIN
						flag := TRUE;
						WriteLn('');
						WriteLn('Min Natural number = ', (dk[i-1]+1));
					END;
				END;
				IF flag = FALSE THEN
				BEGIN
					WriteLn('');
					WriteLn('Min Natural number = ', (dk[N]+1));
				END;
				ReadKey;
			END;
		END;
	END;
	WriteLn('');
	WriteLn('Press any button to Exit...');
	ReadKey;
END.