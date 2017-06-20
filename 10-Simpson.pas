PROGRAM simpson;
USES crt;

{---Equation of integral by Simpson method---}

FUNCTION func(x: REAL): REAL;
VAR
  t: REAL;
BEGIN
  t := sin(x);
  func := t;
END;

{Solution}

VAR
  x, I1, I2, eps, h, a, b: REAL;
  s0, s1, s2: REAL;
  k: INTEGER;
  i, n: LONGINT;

BEGIN
  ClrScr;
  Write('Vvedite a: '); ReadLn(a);
  Write('Vvedite b: '); ReadLn(b);
  Write('Vvedite n (n - even): '); ReadLn(n);
  Write('Vvedite eps-pogreshnost: '); ReadLn(eps);
  h := (b - a)/n;
  s0 := func(a) + func(b);
  s1 := 0; s2 := 0;
  FOR k := 1 TO (n - 1)  DO
    BEGIN
      If Odd(k) THEN
        BEGIN
          x := a + k * h;
          s1 := s1 + func(x);
        END
      ELSE
        BEGIN
          x := a + k * h;
          s2 := s2 + func(x);
        END;
    END;
  I1 := (h * (s0 + 4 * s1 + 2 * s2)) / 3;
  I2 := I1 + 100 * eps;
  i := 0;
  WHILE Abs(I1 - I2) > eps DO
    BEGIN
      I1 := I2;
      n := 2 * n;
      h := (b - a)/n;
      s2 := s1 + s2;
      s1 := 0;
      FOR k := 1 TO (n - 1) DO
        BEGIN
          IF Odd(k) THEN
            BEGIN
              x := a + k * h;
              s1 := s1 + func(x);
            END;
        END;
    i := i + 1;
    I2 := (h * (s0 + 4 * s1 + 2 * s2)) / 3;
    END;
  WriteLn;
  WriteLn(i);
  WriteLn;
  WriteLn('Integral = ', I2:5:5);

  ReadKey;

END.
