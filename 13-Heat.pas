PROGRAM teplo; {teploprovod equation}
USES crt;
TYPE
  Vect = ARRAY [0..20] OF REAL;

VAR
  x, t, h, r, f: REAL;
  x0, xN: REAL;
  tau: REAL;
  i, n: WORD;
  j, M: INTEGER;
  a,b,c,d,u: Vect;

FUNCTION func(xm, tn: REAL): REAL;
BEGIN
  func := xm * sqr(xm) - 6 * tn * xm;
END;

PROCEDURE Progonka(n: INTEGER; aa,bb,cc,dd: Vect; VAR xx: Vect);
VAR
  p,q: Vect;
  i: WORD;
BEGIN
  p[0] := -cc[0] / bb[0];
  q[0] := dd[0] / bb[0];
  FOR i := 1 TO (n - 1) DO
    BEGIN
      p[i] := -cc[i] / (aa[i] * p[i-1] + bb[i]);
      q[i] := (dd[i] - aa[i] * q[i-1]) / (aa[i] * p[i-1] + bb[i]);
    END;
  xx[n] := (dd[n] - aa[n] * q[n-1]) / (aa[n] * p[n-1] + bb[n]);
  FOR i := (n - 1) DOWNTO 0 DO
    BEGIN
      xx[i] := p[i] * xx[i+1] + q[i];
    END;
  END;

{Solution}

BEGIN
  ClrScr;
  Write('Input x0 = '); ReadLn(x0);
  Write('Input xN = '); ReadLn(xN);
  Write('Input partition of segment M = '); ReadLn(M);
  Write('Input tau = '); ReadLn(tau);
  Write('Input layer n = '); ReadLn(n);

{  x0 := 0; xN := 1; M := 10; tau := 1; n := 1;  }

  h := (xN - x0) / M;
  r := tau / (sqr(h));

  FOR j := 1 TO (M-1) DO
    BEGIN
      u[j] := 0;
    END;

  WHILE n <> 0 DO
    BEGIN
      t := n * tau;

      u[0] := 0;  d[0] := 0; a[M] := 0; b[M] := 1; { we add this for good working }
      u[M] := t;  b[0] := 1; c[0] := 0; d[M] := t; { of progonka method           }

      FOR j := 1 TO (M-1) DO
        BEGIN
          x := j * h;
          a[j] := -r;
          b[j] := 1 + 2 * r;
          c[j] := -r;
          f := func(x,t);
          d[j] := tau * f + u[j];
        END;

      Progonka(M,a,b,c,d,u);

      FOR j := 1 TO M DO
        BEGIN
          Write('u = ', u[j]:8:8);
          WriteLn;
        END;

      WriteLn;
      Write('Input layer n = '); ReadLn(n);
    END;

  WriteLn;
  WriteLn('Bye!');
  ReadKey;
END.
