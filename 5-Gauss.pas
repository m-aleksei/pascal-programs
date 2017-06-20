PROGRAM gauss;
USES crt;
TYPE
  Matr = ARRAY [1..20, 1..20] OF REAL;
  Vect = ARRAY [1..20] OF REAL;

PROCEDURE MainEl(VAR a: Matr; VAR f: Vect; t, m: WORD);
VAR
  i,j,k,s: WORD;
  u: Vect;
  p: REAL;

BEGIN
  FOR j := t TO m DO
    BEGIN
      p := a[j,j];
      FOR i := j TO m DO
        BEGIN
          IF Abs(a[i,j]) >= Abs(p) THEN
            BEGIN
              p := a[i,j];
              s := i;
            END;
         END;
      FOR k := 1 TO m DO
        BEGIN
          u[k] := a[s,k];
          a[s,k] := a[j,k];
          a[j,k] := u[k];
        END;
      p := f[s];
      f[s] := f[j];
      f[j] := p;
      IF Abs(a[j,j]) = 0 THEN
        BEGIN
          WriteLn;
          WriteLn('Matrix is degenerate!');
          ReadKey;
          Exit;
        END;
    END;
END;


  {Solution}

VAR
  a: Matr;
  f, x: Vect;
  i,j,n,k: WORD;
  t: REAL;

BEGIN
  ClrScr;
  Write('Input dimension = '); ReadLn(n);
  IF n < 2 THEN
    WriteLn('Need n >= 2!');

  FOR i := 1 TO n DO
    BEGIN
      FOR j := 1 TO n DO
        BEGIN
          Write('a(', i, ', ', j, ') = '); ReadLn(a[i,j]);
        END;
      Write('f(', i, ') = '); ReadLn(f[i]);
    END;


  FOR i := 1 TO n DO
    BEGIN
      MainEl(a,f,i,n);
      t := a[i,i];
      f[i] := f[i] / t;

      FOR j := 1 TO n DO
        BEGIN
          a[i,j] := a[i,j] / t;
        END;

      FOR k := (i+1) TO n DO
        BEGIN
          t := a[k,i];
          f[k] := f[k] - f[i] * t;
          FOR j := i TO n DO
            BEGIN
              a[k,j] := a[k,j] - a[i,j] * t;
            END;
        END;

    END;



  WriteLn;
  FOR i := 1 TO n DO
    BEGIN
      FOR j := 1 TO n DO
        BEGIN
          Write('    ', a[i,j]:3:1);
        END;
      WriteLn('  ||  ', f[i]:3:1);
    END;

  WriteLn;
  FOR i := n DOWNTO 1 DO
    BEGIN
      t := 0;
      FOR j := n DOWNTO 1 DO
        BEGIN
          t := t + a[i,j] * x[j];
        END;
      x[i] := f[i] - t;
    END;
  FOR i := 1 TO n DO
    WriteLn(x[i]:3:2);

  ReadKey;
END.
