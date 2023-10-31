PROGRAM FactorialComp;
USES crt;

PROCEDURE factorialp (dn: LONGINT; VAR dr: EXTENDED; VAR dk: LONGINT);
CONST
	j = 1000000;
	eps = 0.0001;
	phi = 1000000000000000;
	
VAR
	ddr: EXTENDED;
	di: LONGINT;
	
BEGIN
	ddr := 1; dk := 0;
	IF dn > 12 THEN
	BEGIN
		FOR di := 1 TO 12 DO
		BEGIN
			ddr := ddr * di;
		END;
		FOR di := 13 TO dn DO
		BEGIN
			IF ddr > phi THEN
			BEGIN
				ddr := ddr / j;
				dk := dk + 6;
			END;
			IF ddr < eps THEN
			BEGIN
				ddr := ddr * j;
				dk := dk - 6;
			END;
			IF ((ddr * di <= phi) AND (ddr * di >= eps)) THEN
			BEGIN
				ddr := ddr * di;
			END
			ELSE
			BEGIN
				IF (ddr * di) > phi THEN
				BEGIN
					ddr := (ddr * di) / j;
					dk := dk + 6;
				END;
				IF (ddr * di) < eps THEN
				BEGIN
					ddr := ddr * di * j;
					dk := dk - 6;
				END;
			END;
		END;
	END;
	dr := ddr;
END;

VAR
	N, NN, k: LONGINT;
	r: EXTENDED;
	
BEGIN
	N := 1; r := 1; k := 1; NN := 1;
	WHILE N > 0 DO
		BEGIN
		ClrScr;
		WriteLn('Factorial calculation of INTEGER number N.');
		WriteLn('If you input N = 0, this program will stop.');
		WriteLn('Note: 0! = 1. Max N = 200,000,000.');
		WriteLn('');
		Write('Input N = '); ReadLn(N);
		WriteLn('');
		IF N > 0 THEN
		BEGIN
			IF N <= 12 THEN
			BEGIN
				FOR k := 1 TO N DO
				BEGIN
					NN := NN * k;
				END;
				WriteLn('Factorial N! = ', NN);
			END
			ELSE
			BEGIN
				factorialp(N, r, k);
				WriteLn('Factorial N! = ', r,' (*10^(',k,'))');
				WriteLn('');
				TextColor(LightRed);
				WriteLn('Note: You should sum E**** and 10^(****)!');
			END;
			N := 1; r := 1; k := 1; NN := 1;
			WriteLn('');
			TextColor(LightGray);
			WriteLn('Press any button to Continue...');
			ReadKey;
		END;
	END;
	WriteLn('Press any button to Exit...');
	ReadKey;
END.