PROGRAM splain;
USES crt;
TYPE
  Vect = ARRAY[0..20] OF REAL;
VAR
  x,a,b,c,d,h,f,m: Vect;
  n, i: WORD;
  g,a0,b0,c0,a1,b1,c1,t: REAL;

PROCEDURE Progonka(n: WORD; a,b,c,d: Vect; VAR x: Vect);
VAR
  p,q: Vect;
  i: WORD;
BEGIN
  p[0] := -c[0]/b[0];
  q[0] := d[0]/b[0];
  FOR i := 1 TO n DO
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
  Write('Kolichestvo otrezkov razbieniya: '); ReadLn(n);
  FOR i := 0 TO n DO
    BEGIN
      Write('x(', i, ') = '); ReadLn(x[i]);
    END;

  FOR i := 0 TO n DO
    BEGIN
      Write('f(x', i, ') = '); ReadLn(f[i]);
    END;


  Write('a0 = '); ReadLn(a0);
  Write('b0 = '); ReadLn(b0);
  Write('c0 = '); ReadLn(c0);
  Write('a1 = '); ReadLn(a1);
  Write('b1 = '); ReadLn(b1);
  Write('c1 = '); ReadLn(c1);


  FOR i := 1 TO n DO
    BEGIN
      h[i] := x[i] - x[i-1];
    END;

  FOR i := 1 TO n - 1 DO
    BEGIN
      a[i] := h[i]/6;
      b[i] := h[i]/3 + h[i+1]/3;
      c[i] := h[i+1]/6;
      d[i] := (f[i+1]-f[i])/h[i+1] - (f[i]-f[i-1])/h[i];
    END;

  b[0] := -a0 * (h[1]/2) + a0 * (h[1]/6) + b0;
  c[0] := -a0 * (h[1]/6);
  d[0] := c0 - a0 * (f[1] - f[0])/h[1];
  a[n] := a1 * h[n]/6;
  b[n] := a1 * (h[n]/2) - a1 * (h[n]/6) + b1;
  d[n] := c1 - a1 * (f[n] - f[n-1])/h[n];

  Progonka(n,a,b,c,d,m);
  g := 0;
  WHILE TRUE DO
  BEGIN
    Write('x = '); ReadLn(t);
    IF (t > x[0]) AND (t < x[n]) THEN
    BEGIN
      FOR i := 1 TO n DO
        BEGIN
          IF (t >= x[i-1]) AND (t < x[i]) THEN
          g := m[i-1] * (sqr(x[i] - t)) * (x[i] - t) / (6 * h[i]) +
          m[i] * (sqr(t - x[i-1])) * (t - x[i-1]) / (6 * h[i]) +
          (f[i-1] - (sqr(h[i])) * m[i-1]/6) * ((x[i] - t) / h[i]) +
          (f[i] - (sqr(h[i])) * m[i]/6) * ((t - x[i-1]) / h[i]);
        END;
      WriteLn('g(x) = ', g:10:5);
    END
    ELSE
      BEGIN
        WriteLn('You out of range!'); ReadKey; Exit;
      END;
  END;
END.
