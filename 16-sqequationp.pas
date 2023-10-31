PROGRAM FindRootsSqEquation;
USES crt;

PROCEDURE FindRootsSqEqu (n,p,k: REAL; VAR discr,sdiscr,m1,m2: REAL; VAR sccs: BOOLEAN);
BEGIN
	discr := p * p;
	discr := discr - 4*n*k;
	IF discr < 0 THEN
		BEGIN
			sdiscr := 0; m1 := 0; m2 := 0; sccs := FALSE;
		END
	ELSE
		BEGIN
			sdiscr := sqrt(discr); 
			m1 := (((-1)*p+sdiscr)/(2*n));
			m2 := (((-1)*p-sdiscr)/(2*n));
			sccs := TRUE;
		END;
END;

VAR
	a,b,c: REAL;
	x1, x2: REAL;
	d, sd: REAL;
	sucs: BOOLEAN;
	
BEGIN
	a := 1; b := 0; c := 0; d := 0; sd := 0; sucs := FALSE;
	WHILE a <> 0 DO
	BEGIN
		ClrScr;
		WriteLn('(ENG): Solve equation: (a)*x^2 + (b)*x + (c) = 0. Find x1 and x2.');
		WriteLn('(ENG): Coef (a) <> 0 !');
		WriteLn('(ENG): If you input a = 0, this program will stop.');
		WriteLn();
		WriteLn('(RUS): Reshit uravnenie vida: (a)*x^2 + (b)*x + (c) = 0. Naiti korni x1, x2.');
		WriteLn('(RUS): Coef (a) ne dolzhen byt raven 0 !');
		WriteLn('(RUS): Esli vvedete a = 0, programma ostanovitsa.');
		WriteLn();
		Write('Input / Vvedi coef a: '); ReadLn(a);
		Write('Input / Vvedi coef b: '); ReadLn(b);
		Write('Input / Vvedi coef c: '); ReadLn(c);
		ClrScr;
		IF a <> 0 THEN
		BEGIN
			WriteLn('<SOLUTION / RESHENIE>');
			WriteLn();
			WriteLn('Your equation: (',a:1:1,')*x^2+(',b:1:1,')*x+(',c:1:1,') = 0.');
			WriteLn();
			WriteLn('Lets try to find x1 and x2...');
			WriteLn();
			FindRootsSqEqu(a,b,c,d,sd,x1,x2,sucs); {вызов процедуры поиска корней уравнения}
			IF sucs = FALSE THEN
				BEGIN
					WriteLn('Discriminant D = ', d:4:4); 
					WriteLn('/');
					WriteLn('(ENG): If D < 0, then there is no REAL solution for this equation.');
					WriteLn('(ENG): Try to input other values of (a,b,c).');
					WriteLn('/');
					WriteLn('(RUS): Esli D < 0, togda uravnenie ne imeet deistvitelnikh kornei.');
					WriteLn('(RUS): Poprobui vvesti drugie znachenia coef (a,b,c).');
					WriteLn('/');
				END
			ELSE
				BEGIN
					WriteLn('Discriminant D = ', d:4:4); 
					WriteLn('sqrt(D) = ', sd:4:4);
					WriteLn();
					WriteLn('x1 = ', x1:8:8, ' y(x1) = ',(a*x1*x1+b*x1+c):8:8, ' . OK !');
					WriteLn('x2 = ', x2:8:8, ' y(x2) = ',(a*x2*x2+b*x2+c):8:8, ' . OK !');
					WriteLn();
					WriteLn('<SOLUTION CHECK / FORMULI VIETA>');
					WriteLn();
					WriteLn('(x1)*(x2) = ', (x1*x2):4:4, ' =  (c/a) = ', (c/a):4:4, ' . OK !');
					WriteLn();
					WriteLn('(x1)+(x2) = ', (x1+x2):4:4, ' = -(b/a) = ', ((-1)*(b/a)):4:4, ' . OK !');
					WriteLn();
				END;
			WriteLn('Press any button to Continue...');
			ReadKey;
		END;
	END;
	WriteLn('Press any button to Exit...');
	ReadKey;
END.