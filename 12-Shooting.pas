PROGRAM shooootin;
USES crt;

VAR
  x0, u0, v0, xN, h0, eps: REAL;
  u1, v1, h, t, ksi, ksi1, ksi2: REAL;
  a0, a1, b0, b1, g0, g1: REAL;
  F1, F2: REAL;

FUNCTION func1 (x,u,v:REAL): REAL;
BEGIN
  func1 := u + v + x * exp(x);
END;

FUNCTION func2 (x,u,v:REAL): REAL;
BEGIN
  func2 := v - u + (1 + x * x) * exp(x);
END;

PROCEDURE Step (x, u, v, h: REAL; VAR u1, v1: REAL);
VAR
  Fi0, Fi1, Fi2, Fi3: REAL;
  Psi0, Psi1, Psi2, Psi3: REAL;
BEGIN
  Fi0 := h * func1(x,u,v);
  Psi0 := h * func2(x,u,v);

  Fi1 := h * func1(x + h/2, u + Fi0/2, v + Psi0/2);
  Psi1 := h * func2(x + h/2, u + Fi0/2, v + Psi0/2);

  Fi2 := h * func1(x + h/2, u + Fi1/2, v + Psi1/2);
  Psi2 := h * func2(x + h/2, u + Fi1/2, v + Psi1/2);

  Fi3 := h * func1(x + h, u + Fi2, v + Psi2);
  Psi3 := h * func2(x + h, u + Fi2, v + Psi2);

  u1 := u + (Fi0 + 2 * Fi1 + 2 * Fi2 + Fi3)/6;
  v1 := v + (Psi0 + 2 * Psi1 + 2 * Psi2 + Psi3)/6;
END;

PROCEDURE Jump (h0, x0, u0, v0: REAL; VAR h, u1, v1: REAL); { changing steps }
VAR
  u05, u11: REAL;
  v05, v11: REAL;
  epst: REAL;
BEGIN
  Step(x0, u0, v0, h0, u1, v1);
  h := h0/2;
  Step(x0, u0, v0, h, u05, v05);
  Step(x0+h, u05, v05, h, u11, v11);
  epst := 10 * eps;
  WHILE (Abs(u1 - u11) >= epst) OR (Abs(v1 - v11) >= epst) DO
    BEGIN
      u1 := u05;
      v1 := v05;
      h := h/2;
      Step(x0, u0, v0, h, u05, v05);
      Step(x0+h, u05, v05, h, u11, v11);
    END;
  h := 2 * h;
END;

PROCEDURE Shot (mksi: REAL; flag: BOOLEAN);
VAR
  xx0, hh0, tt: REAL;
BEGIN
  hh0 := h0;
  xx0 := x0;

  v0 := mksi;
  u0 := (g0 - b0 * mksi) / a0;

  WHILE (xN - xx0) > 0 DO
    BEGIN
      IF (xN - xx0) < hh0 THEN
        hh0 := xN - xx0;

      Jump (hh0, xx0, u0, v0, h, u1, v1);
      xx0 := xx0 + h;
      IF flag = FALSE THEN
        BEGIN
          WriteLn;
          Write('  Step = ', h:8:8);
          Write(' x = ', xx0:8:8); Write('   u = ', u1:8:8); Write('   v = ', v1:8:8);
          WriteLn;
        END;
      u0 := u1;
      v0 := v1;
    END;
  IF flag = TRUE THEN
    BEGIN
      tt := a1 * u1 + b1 * v1 - g1;
      t := tt;
      Write('F(ksi) = ', t);
    END;
END;

{Solution}

BEGIN
  ClrScr;
{  Write('Input x0 = '); ReadLn(x0);
  Write('Input xN = '); ReadLn(xN);
  Write('Input tochnost eps = '); ReadLn(eps);
  Write('Input start step: '); ReadLn(h0);
  Write('Input ksi = '); ReadLn(ksi);      }
  x0 := 0; xN := 1; eps := 0.00001; h0 := 0.3; ksi := 0.2;
  a0 := 1; a1 := 3; b0 := 2; b1 := 4; g0 := 0; g1 := 7 * exp(1); {a0 <> 0}

  Shot (ksi, TRUE);
  F1 := t;
  WriteLn;
  Write('Input new ksi = '); ReadLn(ksi1);
  Shot (ksi1, TRUE);
  F2 := t;
  eps := eps/10;

WHILE (Abs(F1) > eps) OR (Abs(F2) > eps) DO
BEGIN

  WHILE F1 * F2 > 0 DO {in case not a fork}
    BEGIN
      IF Abs(F1) < Abs(F2) THEN
         BEGIN
         WriteLn('   You need ksi: F(ksi) < |', F1:8:8, '|');
         Write('Input new ksi = '); ReadLn(ksi1);
         Shot (ksi1, TRUE);
         F2 := t;
         END
         ELSE
         BEGIN
         WriteLn('   You need ksi: F(ksi) < |', F2:8:8, '|');
         Write('Input new ksi = '); ReadLn(ksi);
         Shot (ksi, TRUE);
         F1 := t;
      END;
    END;
  IF (Abs(F1) <= eps) THEN
        BEGIN
        Shot(ksi, FALSE);
        ReadKey; Exit;
        END
      ELSE IF (Abs(F2) <= eps) THEN
        BEGIN
        Shot(ksi1, FALSE);
        ReadKey; Exit;
        END;

  WHILE F1 * F2 < 0 DO {in case a fork}  {better to compare Abs(ksi - ksi1)}
    BEGIN
      WriteLn;
      Write('It is a fork! ');
      ksi2 := (ksi + ksi1)/2;
      Shot (ksi2, TRUE);
      IF F1 * t < 0 THEN
        BEGIN
          F2 := t;
          ksi1 := ksi2;
        END
      ELSE
        BEGIN
          F1 := t;
          ksi := ksi2;
        END;

      IF (Abs(F1) <= eps) THEN
        BEGIN
        Shot(ksi, FALSE);
        ReadKey; Exit;
        END
      ELSE IF (Abs(F2) <= eps) THEN
        BEGIN
        Shot(ksi1, FALSE);
        ReadKey; Exit;
        END;
    END;

END;



  ReadKey;
END.
