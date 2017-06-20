PROGRAM Newton;
USES Crt;

VAR
  n,i,j: WORD;

  Xi: ARRAY[0..20] OF REAL;
  Fi: ARRAY[0..20] of REAL;
  x, a, Lnx, M, eps: REAL;
BEGIN
  ClrScr;
  Write('Vvedite stepenb mnogochlena n <= 20: ');
  ReadLn(n);

  WriteLn('Vvedite uzlovie tochki: ');
  FOR i := 0 TO n DO
  BEGIN
    Write('x(', i, ') = ');
    ReadLn(Xi[i]);
  END;

  WriteLn('Vvedite znacheniya funczii v tochkax: ');
  FOR i := 0 TO n DO
  BEGIN
    Write('F(X', i,') = ');
    ReadLn(Fi[i]);
  END;

  Write('Vvedite x, gde nuzhno naiti znachenie funczii: ');
  ReadLn(x);

  Write('Vvedite constantu: ');
  ReadLn(M);

  Lnx := Fi[0];
  WriteLn;
  WriteLn('Ln(x0) = ', Lnx);
  a := 1;
  eps := 1;
  FOR i := 1 TO n DO
    BEGIN
    a := a * (x - Xi[i-1]);
      FOR j := n DOWNTO i DO
        BEGIN
          Fi[j] := (Fi[j] - Fi[j-1]) / (Xi[j] - Xi[j-i]);
        END;
    Lnx := Lnx + Fi[i] * a;
    WriteLn('Ln(x', i, ') = ', Lnx);
    eps := eps * a / (i + 1);
    END;
  eps := Abs(eps) * M * Abs(x - Xi[n]);
  WriteLn;
  WriteLn('Znachenie funczii v tochke x: ', Lnx:10:10);
  WriteLn('Pogreshnost: ', eps);
  ReadKey;
END.

