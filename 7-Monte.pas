PROGRAM montekarlo;
USES crt;
VAR
  a, b: REAL;
  I, S, x, y, f: REAL;
  nn, mm: INTEGER;
  K, N: LONGINT;

FUNCTION func(xx: REAL): REAL;
BEGIN
  func := sqr(xx) + 3;
END;

BEGIN
  ClrScr;
  Write('Vvedite a: '); ReadLn(a);

  b := func(a);
  S := a * b;
  K := 0;
  N := 1;
  Randomize;
  WHILE N <= 100000 DO {v CI++ N must be >= 10^9 !!!}
    BEGIN
      x := Abs(Random * 2 * a - a);
      y := Abs(Random * 2 * b - b);
      f := func(x);
      IF y <= f THEN
        BEGIN
          K := K + 1;
        END;
      N := N + 1;
    END;

  I := K * S / N;

  WriteLn('Integral = ', I:10:10);

  ReadKey;
END.
