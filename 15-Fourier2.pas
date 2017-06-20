PROGRAM Fourier;
USES crt;
CONST
  N = 11;
  Pi = 3.1415926535897932;

TYPE
  Vect = ARRAY [0..N] OF REAL;

FUNCTION func(x: REAL): REAL;
BEGIN
  func := sqr(x - Pi) / sqr(Pi);
END;

PROCEDURE Twelve_ordinates(y: Vect; VAR a, b: Vect);
VAR
  u,v,s,t,t1,s1:Vect;
  i,j: WORD;
  p,r: REAL;

BEGIN
  p := 0.5;
  r := 26/30;

  FOR j := 1 TO 5 DO
    BEGIN
      i := 12-j;
      u[j] := y[j] + y[i];
      v[j] := y[j] - y[i];
    END;
  u[0] := y[0]; u[6] := y[6];

  FOR j := 0 TO 2 DO
    BEGIN
      i := 6-j;
      s[j] := u[j] + u[i];
      t[j] := u[j] - u[i];
    END;
  s[3] := u[3];

  FOR j := 1 TO 2 DO
    BEGIN
      i := 6-j;
      s1[j] := v[j] + v[i];
      t1[j] := v[j] - v[i];
    END;
  s1[3] := v[3];

  a[0] := (s[0] + s[1] + s[2] + s[3]) / 6; a[3] := (t[0] - t[2]) / 6;
  a[1] := (t[0] + r * t[1] + p * t[2]) / 6;
  a[2] := (s[0] - s[3] + p * (s[1] - s[2])) / 6;
  b[1] := (p * s1[1] + r * s1[2] + s1[3]) / 6;
  b[2] := (r * (t1[1] + t1[2])) / 6;
  b[3] := (s1[1] - s1[3]) / 6;

END;


VAR
  yy, aa, bb: Vect;
  i: WORD;
  f, x: REAL;
BEGIN
  ClrScr;

  FOR i := 0 TO N DO
    BEGIN
      x := (Pi*i)/6;
      yy[i] := func(x);
    END;

  WriteLn;
  Twelve_ordinates(yy, aa, bb);

  FOR i := 0 TO 3 DO
    BEGIN
      WriteLn('a(', i, ') = ', aa[i]:8:8);
    END;

  FOR i := 1 TO 3 DO
    BEGIN
      WriteLn('b(', i, ') = ', bb[i]:8:8);
    END;

  ReadKey;
  WriteLn;
  WriteLn('Fourier polynomial constructed!');
  WHILE TRUE DO
    BEGIN
      Write('Input x: '); ReadLn(x);
      f := aa[0]/2 + (aa[1]*cos(x) + bb[1]*sin(x))
      + (aa[2]*cos(2*x) + bb[2]*sin(2*x)) + (aa[3]*cos(3*x) + bb[3]*sin(3*x));
      WriteLn('f(x) = f(', x:3:3, ') = ', f:8:8);
    END;

  ReadKey;
END.
