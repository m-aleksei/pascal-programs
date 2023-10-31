PROGRAM PointInOutConvexPolygon;
USES crt,math;

CONST
	eps = 0.0000001;

VAR
	i, j, N: LONGINT;
	dx1: ARRAY [1..1000000] OF LONGINT;
	dy1: ARRAY [1..1000000] OF LONGINT;
	dx2: ARRAY [1..1000000] OF LONGINT;
	dy2: ARRAY [1..1000000] OF LONGINT;
	x, y: EXTENDED;
	flag, glag: BOOLEAN;
	s1, s2: EXTENDED;
		
BEGIN
	N := 3;
	WHILE N > 2 DO
	BEGIN
		ClrScr;
		flag := FALSE; glag := FALSE;
		WriteLn('2D PLANE: Lets see, if N-figure contains Your Point (x,y).');
		WriteLn('ENG: Note: You should input coordinates of CONVEX polygon only.');
		WriteLn('RUS: Pri vvode dannyux ubedites, chto vash mnogougolnik vypuklii.');
		WriteLn('');
		Write('Input N = '); ReadLn(N);
		IF N > 2 THEN
		BEGIN
			FOR i := 1 TO N DO
			BEGIN
				Write('Input dx1(',i,') = '); ReadLn(dx1[i]);
				Write('Input dy1(',i,') = '); ReadLn(dy1[i]);
				Write('Input dx2(',i,') = '); ReadLn(dx2[i]);
				Write('Input dy2(',i,') = '); ReadLn(dy2[i]);
				IF ((i <> 1) AND (i <> N)) THEN
				BEGIN
					IF ((dx2[i-1] <> dx1[i]) OR (dy2[i-1] <> dy1[i])) THEN
					BEGIN
						flag := TRUE;
					END;
				END;
			END;
			IF ((dx2[N] <> dx1[1]) OR (dy2[N] <> dy1[1])) THEN
			BEGIN
				flag := TRUE;
			END;
			IF flag = FALSE THEN
			BEGIN
				WriteLn('N-Figure done. Hope, it is CONVEX? Now Input Your 2D Point:');
				WriteLn('');
				Write('Input x = '); ReadLn(x);
				Write('Input y = '); ReadLn(y);
				FOR i := 1 TO N DO
				BEGIN
					IF ((x = dx1[i]) AND (y = dy1[i]) AND (glag = FALSE)) THEN
					BEGIN
						glag := TRUE;
						ClrScr;
						Write(N, '-fugure: [ ');
						FOR j := 1 TO N DO
						BEGIN
							Write('(',dx1[j],'; ',dy1[j],') ');
						END;
						Write(']');
						WriteLn('');
						WriteLn('Contains the Point (',x:2:2,'; ',y:2:2,') on Top dx1(',i,'),dy1(',i,').');
						ReadKey;
					END;
				END;
				IF glag = FALSE THEN
				BEGIN
					s1 := 0; s2 := 0;
					FOR i := 1 TO N DO
					BEGIN
						IF i < N THEN
						BEGIN
							s1 := s1 + ((dx1[i]*dy1[i+1])-(dx1[i+1]*dy1[i]));
							s2 := s2 + Abs(((dx1[i+1])-(dx1[i]))*((y)-(dy1[i])) - ((dy1[i+1])-(dy1[i]))*((x)-(dx1[i])))/2;
							WriteLn('S tr (',i,') = ', s2:4:4);
						END
						ELSE
						BEGIN
							s1 := s1 + ((dx1[i]*dy1[1])-(dx1[1]*dy1[i]));
							s2 := s2 + Abs(((dx1[1])-(dx1[i]))*((y)-(dy1[i])) - ((dy1[1])-(dy1[i]))*((x)-(dx1[i])))/2;
							WriteLn('S tr (',i,') = ', s2:4:4);
						END;
					END;
					s1 := Abs(s1)/2;
					IF Abs(s1-s2) < eps THEN
					BEGIN
						glag := TRUE;
						ClrScr;
						Write(N, '-fugure: [ ');
						FOR j := 1 TO N DO
						BEGIN
							Write('(',dx1[j],'; ',dy1[j],') ');
						END;
						Write(']');
						WriteLn('');
						WriteLn('Contains the Point (',x:2:2,'; ',y:2:2,') inside ', N, '-figure.');
						WriteLn('S(N) = ', s1:8:8,'; Sum(S tr(i)) = ',s2:8:8);
						ReadKey;
					END
					ELSE
					BEGIN
						glag := TRUE;
						ClrScr;
						Write(N, '-fugure: [ ');
						FOR j := 1 TO N DO
						BEGIN
							Write('(',dx1[j],'; ',dy1[j],') ');
						END;
						Write(']');
						WriteLn('');
						WriteLn('Given Point (',x:2:2,'; ',y:2:2,') is out of ', N, '-figure.');
						WriteLn('S(N) = ', s1:8:8,'; Sum(S tr(i)) = ',s2:8:8);
						ReadKey;
					END;
				END;
			END
			ELSE
			BEGIN
				ClrScr;
				WriteLn('');
				TextColor(LightRed);
				WriteLn('There is no N-figure on 2D plane.');
				TextColor(LightGray);
				WriteLn('End Dots(i-1) and Start Dots(i) should be equal.');
				WriteLn('For Triangle: dx1(1) = dx2(3), dy1(1) = dy2(3).');
				WriteLn('For Triangle: dx2(1) = dx1(2), dy2(1) = dy1(2).');
				WriteLn('For Triangle: dx2(2) = dx1(3), dy2(2) = dy1(3).');
				ReadKey;
			END;
		END
		ELSE
		BEGIN
			WriteLn('');
			TextColor(LightRed);
			WriteLn('Triangle is the very minimum figure on 2D plane.');
			WriteLn('N should be greater than 2!');
		END;
	END;
	WriteLn('');
	TextColor(LightGray);
	WriteLn('Press any button to Exit...');
	ReadKey;
END.