PROGRAM progonka;
USES crt;
TYPE
  Vect = ARRAY[0..20] OF REAL;
VAR
  x,a,b,c,d: Vect;
  n, i: WORD;

{---IT'S PROGONKA METHOD!!!---}

PROCEDURE Progonka(n: WORD; a,b,c,d: Vect; VAR x: Vect);
VAR
  p,q: Vect;
  i: WORD;
BEGIN
  p[0] := -c[0]/b[0];
  q[0] := d[0]/b[0];
  FOR i := 1 TO (n - 1) DO
    BEGIN
      p[i] := -c[i]/(a[i]*p[i-1] + b[i]);
      q[i] := (d[i] - a[i]*q[i-1])/(a[i]*p[i-1] + b[i]);
    END;
  x[n] := (d[n] - a[n]*q[n-1])/(a[n]*p[n-1] + b[n]);
  FOR i := n - 1 DOWNTO 0 DO
    BEGIN
      x[i] := p[i]*x[i+1] + q[i];
    END;
  END;

BEGIN
  ClrScr;
  Write('Stepenb: '); ReadLn(n);
  FOR i := 1 TO n DO
    BEGIN
      Write('a(', i, ') = '); ReadLn(a[i]);
    END;
  WriteLn('b[0] <> 0 !');
  FOR i := 0 TO n DO
    BEGIN
      Write('b(', i, ') = '); ReadLn(b[i]);
    END;
  FOR i := 0 TO (n - 1) DO
    BEGIN
      Write('c(', i, ') = '); ReadLn(c[i]);
    END;
  FOR i := 0 TO n DO
    BEGIN
      Write('d(', i, ') = '); ReadLn(d[i]);
    END;

  Progonka(n,a,b,c,d,x);

  FOR i := 0 TO n DO
    BEGIN
      WriteLn('x(', i, ') = ', x[i]:10:2);
    END;

  ReadKey;
END.
