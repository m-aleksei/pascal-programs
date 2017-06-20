PROGRAM kosh2;
USES crt;

VAR
  x0, u0, v0, xN, h0, eps: REAL;
  u1, v1, h: REAL;


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
BEGIN
  Step(x0, u0, v0, h0, u1, v1);
  h := h0/2;
  Step(x0, u0, v0, h, u05, v05);
  Step(x0+h, u05, v05, h, u11, v11);

  WHILE (Abs(u1 - u11) >= eps) OR (Abs(v1 - v11) >= eps) DO
    BEGIN
      u1 := u05;
      v1 := v05;
      h := h/2;
      Step(x0, u0, v0, h, u05, v05);
      Step(x0+h, u05, v05, h, u11, v11);
    END;
  h := 2 * h;
END;

{Solution}

BEGIN
  ClrScr;
  Write('Input x0 = '); ReadLn(x0);
  Write('Input xN = '); ReadLn(xN);
  Write('Input u0 = '); ReadLn(u0);
  Write('Input v0 = '); ReadLn(v0);
  Write('Input tochnost eps = '); ReadLn(eps);
  Write('Input start step: '); ReadLn(h0);

  WHILE (xN - x0) > 0 DO
    BEGIN
      IF (xN - x0) < h0 THEN
        h0 := xN - x0;

      Jump (h0, x0, u0, v0, h, u1, v1);
      x0 := x0 + h;

      WriteLn;
      Write('  Step = ', h:8:8);
      Write(' x = ', x0:8:8); Write('   u = ', u1:8:8); Write('   v = ', v1:8:8);
      WriteLn;
      u0 := u1;
      v0 := v1;
    END;

  ReadKey;
END.
