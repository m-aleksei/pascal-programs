PROGRAM SimplOperComplexNum;
USES crt,math;

VAR
	N, dn, i: INTEGER;
	da,db,dc,dd,dr,drn: EXTENDED;
	dr1,dr2,dp1,dp2: EXTENDED;
	
BEGIN
	N := 1;
	WHILE N > 0 DO
	BEGIN
		ClrScr;
		da := 0; db := 0; dc := 0; dd := 0; dr := 0; drn := 0; dp1 := 0; dp2 := 0; dr1 := 0; dr2 := 0; 
		WriteLn('Simple operations with COMPLEX numbers.');
		WriteLn('');
		WriteLn('Menu (choose one, wisely):');
		WriteLn('1 - A (+,-,*,/) B.');
		WriteLn('2 - Conjugation of A (+, *).');
		WriteLn('3 - Trigonometric form of A, A^(n), A^(1/n).');
		WriteLn('4 - Trigonometric form of A (*, /) B.');
		Write('Input number (1-4): '); ReadLn(N);
		IF N = 1 THEN
		BEGIN
			ClrScr;
			WriteLn('Menu: 1 - A (+,-,*,/) B.');
			WriteLn('');
			WriteLn('Input REAL (a,b,c,d) for A = (a+i*b) and B = (c+i*d).');
			Write('Input a = '); ReadLn(da);
			Write('Input b = '); ReadLn(db);
			Write('Input c = '); ReadLn(dc);
			Write('Input d = '); ReadLn(dd);
			WriteLn('');
			WriteLn('A + B = (a+i*b) + (c+i*d) = (',(da+dc):4:4,') + i*(',(db+dd):4:4,')');
			WriteLn('A - B = (a+i*b) - (c+i*d) = (',(da-dc):4:4,') + i*(',(db-dd):4:4,')');
			WriteLn('A * B = (a+i*b) * (c+i*d) = (',(da*dc-db*dd):4:4,') + i*(',(db*dc+da*dd):4:4,')');
			IF ((dc = 0) AND (dd = 0)) THEN
			BEGIN
				WriteLn('A / B = Not exists, while c=0 AND d=0.');
			END
			ELSE
			BEGIN
				WriteLn('A / B = (a+i*b) / (c+i*d) = (',((da*dc+db*dd)/(dc*dc+dd*dd)):4:4,') + i*(',((db*dc-da*dd)/(dc*dc+dd*dd)):4:4,')');
			END;
			ReadKey;
		END;
		IF N = 2 THEN
		BEGIN
			ClrScr;
			WriteLn('Menu: 2 - Conjugation of A (+, *).');
			WriteLn('');
			WriteLn('Input REAL (a,b) for A = (a+i*b).');
			Write('Input a = '); ReadLn(da);
			Write('Input b = '); ReadLn(db);
			WriteLn('');
			WriteLn('A = (a+i*b) = (',(da):4:4,') + i*(',(db):4:4,')');
			WriteLn('CA = (a-i*b) = (',(da):4:4,') - i*(',(db):4:4,')');
			WriteLn('A + CA = (a+i*b) + (a+i*b) = 2*a = ',(2*da):4:4);
			WriteLn('A * CA = (a+i*b) * (a+i*b) = a^2 + b^2 = ',(da*da+db*db):4:4);
			ReadKey;
		END;
		IF N = 3 THEN
		BEGIN
			ClrScr;
			WriteLn('Menu: 3 - Trigonometric form of A, A^(n), A^(1/n).');
			WriteLn('');
			WriteLn('Input REAL (a,b) for A = (a+i*b), n - INTEGER.');
			WriteLn('Trigonometric form: A = r * (cos(phi) + i*sin(phi)).');
			Write('Input a = '); ReadLn(da);
			Write('Input b = '); ReadLn(db);
			Write('Input n = '); ReadLn(dn);
			ClrScr;
			IF ((da = 0) AND (db = 0)) THEN
			BEGIN
				dr := 0; dp1 := 0;
			END
			ELSE
			BEGIN
				dr := sqrt(da*da+db*db);
				IF (da > 0) AND (db > 0) THEN { 1 четверть }
				BEGIN
					dp1 := Arctan(db/da);
				END;
				IF (da < 0) AND (db > 0) THEN { 2 четверть }
				BEGIN
					dp1 := (Pi) + (Arctan(db/da));
				END;
				IF (da < 0) AND (db < 0) THEN { 3 четверть }
				BEGIN
					dp1 := ((-1)*Pi) + (Arctan(db/da));
				END;
				IF (da > 0) AND (db < 0) THEN { 4 четверть }
				BEGIN
					dp1 := Arctan(db/da);
				END;
				IF (da = 0) AND (db > 0) THEN { вертикальная ось > 0 }
				BEGIN
					dp1 := Pi/2;
				END;
				IF (da = 0) AND (db < 0) THEN { вертикальная ось < 0 }
				BEGIN
					dp1 := ((-1)*Pi)/2;
				END;
				IF (da > 0) AND (db = 0) THEN { горизонтальная ось > 0 }
				BEGIN
					dp1 := 0;
				END;
				IF (da < 0) AND (db = 0) THEN {горизонтальная ось < 0 }
				BEGIN
					dp1 := Pi;
				END;
				WriteLn('A^(1) = A = (',da:1:1,' + i*',db:1:1,') = (',dr:4:4,') * (cos(',dp1:2:2,') + i*sin(',dp1:2:2,'))');
				WriteLn('');
				drn := 1;
				FOR i := 1 TO dn DO
				BEGIN
					drn := drn * dr;
				END;
				WriteLn('A^(',dn,') = (',(drn):2:2,') * (cos(',(dn*dp1):2:2,') + i*sin(',(dn*dp1):2:2,'))');
				WriteLn('A^(',dn,') = (',(drn*cos(dp1)):2:2,') + i*(',(drn*sin(dp1)):2:2,')');
				WriteLn('');
				WriteLn('A^(1/',dn,'): ');
				FOR i := 1 TO dn DO
				BEGIN
					WriteLn('k = ',i-1,': A[',i-1,'] =  (',(dr):2:2,')^(1/',dn,') * (cos(',((dp1+2*Pi*(i-1))/dn):2:2,') + i*sin(',((dp1+2*Pi*(i-1))/dn):2:2,'))');
				END;
			END;
			WriteLn('');
			WriteLn('r = ', dr:2:2,'; phi = ',dp1:2:2,' Rad (',((dp1*180)/Pi):0:0,' grad).');
			ReadKey;
		END;
		IF N = 4 THEN
		BEGIN
			ClrScr;
			WriteLn('Menu: 4 - Trigonometric form of A (*, /) B.');
			WriteLn('');
			WriteLn('Input REAL (a,b,c,d) for A = (a+i*b) and B = (c+i*d).');
			WriteLn('Trigonometric form: A = r1 * (cos(phi1) + i*sin(phi1)).');
			WriteLn('Trigonometric form: B = r2 * (cos(phi2) + i*sin(phi2)).');
			Write('Input a = '); ReadLn(da);
			Write('Input b = '); ReadLn(db);
			Write('Input c = '); ReadLn(dc);
			Write('Input d = '); ReadLn(dd);
			IF ((da = 0) AND (db = 0) AND (dc = 0) AND (dd = 0)) THEN
			BEGIN
				dr1 := 0; dr2 := 0; dp1:= 0; dp2 := 0;
			END
			ELSE
			BEGIN
				dr1 := sqrt(da*da + db*db);
				dr2 := sqrt(dc*dc + dd*dd);
				IF (da > 0) AND (db > 0) THEN { 1 четверть }
				BEGIN
					dp1 := Arctan(db/da);
				END;
				IF (da < 0) AND (db > 0) THEN { 2 четверть }
				BEGIN
					dp1 := (Pi) + (Arctan(db/da));
				END;
				IF (da < 0) AND (db < 0) THEN { 3 четверть }
				BEGIN
					dp1 := ((-1)*Pi) + (Arctan(db/da));
				END;
				IF (da > 0) AND (db < 0) THEN { 4 четверть }
				BEGIN
					dp1 := Arctan(db/da);
				END;
				IF (da = 0) AND (db > 0) THEN { вертикальная ось > 0 }
				BEGIN
					dp1 := Pi/2;
				END;
				IF (da = 0) AND (db < 0) THEN { вертикальная ось < 0 }
				BEGIN
					dp1 := ((-1)*Pi)/2;
				END;
				IF (da > 0) AND (db = 0) THEN { горизонтальная ось > 0 }
				BEGIN
					dp1 := 0;
				END;
				IF (da < 0) AND (db = 0) THEN {горизонтальная ось < 0 }
				BEGIN
					dp1 := Pi;
				END;
				IF (dc > 0) AND (dd > 0) THEN { 1 четверть }
				BEGIN
					dp2 := Arctan(dd/dc);
				END;
				IF (dc < 0) AND (dd > 0) THEN { 2 четверть }
				BEGIN
					dp2 := (Pi) + (Arctan(dd/dc));
				END;
				IF (dc < 0) AND (dd < 0) THEN { 3 четверть }
				BEGIN
					dp2 := ((-1)*Pi) + (Arctan(dd/dc));
				END;
				IF (dc > 0) AND (dd < 0) THEN { 4 четверть }
				BEGIN
					dp2 := Arctan(dd/dc);
				END;
				IF (dc = 0) AND (dd > 0) THEN { вертикальная ось > 0 }
				BEGIN
					dp2 := Pi/2;
				END;
				IF (dc = 0) AND (dd < 0) THEN { вертикальная ось < 0 }
				BEGIN
					dp2 := ((-1)*Pi)/2;
				END;
				IF (dc > 0) AND (dd = 0) THEN { горизонтальная ось > 0 }
				BEGIN
					dp2 := 0;
				END;
				IF (dc < 0) AND (dd = 0) THEN {горизонтальная ось < 0 }
				BEGIN
					dp2 := Pi;
				END;
				WriteLn('');
				WriteLn('A * B = (r1*r2) * (cos(phi1+phi2) + i*sin(phi1+phi2))');
				WriteLn('A * B = (',(dr1*dr2):2:2,') * (cos(',(dp1+dp2):2:2,') + i*sin(',(dp1+dp2):2:2,'))');
				WriteLn('A * B = (',(dr1*dr2*cos(dp1+dp2)):2:2,') + i*(',(dr1*dr2*sin(dp1+dp2)):2:2,')');
				IF dr2 = 0 THEN
				BEGIN
					WriteLn('');
					WriteLn('A / B = (r1/r2) * (cos(phi1-phi2) + i*sin(phi1-phi2))');
					WriteLn('A / B = Not exists, while r2 = 0 (c=0 AND d=0).');
				END
				ELSE
				BEGIN
					WriteLn('');
					WriteLn('A / B = (r1/r2) * (cos(phi1-phi2) + i*sin(phi1-phi2))');
					WriteLn('A / B = (',(dr1/dr2):2:2,') * (cos(',(dp1-dp2):2:2,') + i*sin(',(dp1-dp2):2:2,'))');
					WriteLn('A / B = (',((dr1*cos(dp1-dp2))/dr2):2:2,') + i*(',((dr1*sin(dp1-dp2))/dr2):2:2,')');
				END;
			END;
			WriteLn('');
			WriteLn('r1 = ', dr1:2:2,'; phi1 = ',dp1:2:2,' Rad (',((dp1*180)/Pi):0:0,' grad).');
			WriteLn('r2 = ', dr2:2:2,'; phi2 = ',dp2:2:2,' Rad (',((dp2*180)/Pi):0:0,' grad).');
			ReadKey;
		END;
	END;
	WriteLn('');
	WriteLn('Press any button to Exit...');
	ReadKey;
END.