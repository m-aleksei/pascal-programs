PROGRAM Lagrange;
USES Crt;

VAR
  n,i,j: WORD;

  Xi: ARRAY[0..20] OF REAL;
  Fi: ARRAY[0..20] of REAL;
  M, x, a, eps, Lnx: REAL;
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

  Lnx := 0;
  eps := 1;
  FOR i := 0 TO n DO
  BEGIN
    a := 1;
    FOR j := 0 TO n DO
      IF i <> j THEN
        BEGIN
          a := a * (x - Xi[j]) / (Xi[i] - Xi[j]);
          eps := eps * (x - Xi[i]) / (i + 1);
        END;
    Lnx := Lnx + Fi[i] * a;
  END;

  eps := Abs(eps) * M;

  WriteLn('Znachenie funczii v tochke x: ', Lnx);
  WriteLn('Pogreshnost: ', eps);
  ReadKey;
END.
