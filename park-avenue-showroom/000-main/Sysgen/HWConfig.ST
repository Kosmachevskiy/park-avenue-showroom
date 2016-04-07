(* Warning *)
(* File is automatically regenerated and all manual changes will be lost. *)
(* ---------------------------------------------------------------------- *)
(* Generated for TC700 *)
(* ********************************************************************** *)
VAR_GLOBAL CONSTANT
  CPU_TYPE   : USINT := 75;
  CPU_CODE   : UINT  := 1000;
END_VAR

TYPE
  TAIStat : STRUCT
    UNF     : BOOL;
    UNR     : BOOL;
    OVR     : BOOL;
    OVF     : BOOL;
    FLS     : BOOL;
    CJC     : BOOL;
    dummy6 {HIDDEN} : BOOL;
    dummy7 {HIDDEN} : BOOL;
    CHC     : BOOL;
    dummy9 {HIDDEN} : BOOL;
    dummy10 {HIDDEN} : BOOL;
    dummy11 {HIDDEN} : BOOL;
    dummy12 {HIDDEN} : BOOL;
    dummy13 {HIDDEN} : BOOL;
    dummy14 {HIDDEN} : BOOL;
    dummy15 {HIDDEN} : BOOL;
  END_STRUCT;

  TAI : STRUCT
    STAT  : TAIStat;
    FS    : INT;
    ENG   : REAL;
    PCT   : REAL;
  END_STRUCT;

  TAIPW : STRUCT
    UCIB1  : REAL;
    UCIB2  : REAL;
    USRC   : REAL;
    UACU   : REAL;
  END_STRUCT;

  TAO_TC6 : STRUCT
    FS  : INT ;
    ENG  : REAL;
    PCT  : REAL;
  END_STRUCT;

  TDI_IR1061 : STRUCT
    DI0   : BOOL;
    DI1   : BOOL;
    DI2   : BOOL;
    DI3   : BOOL;
    IN230  : BOOL;
    HDO    : BOOL;
  END_STRUCT;

  TSTPW : STRUCT
    WCIB1 : BOOL;
    ECIB1 : BOOL;
    WCIB2 : BOOL;
    ECIB2 : BOOL;
    WSRC  : BOOL;
    ESRC  : BOOL;
    WACU  : BOOL;
    EACU  : BOOL;
  END_STRUCT;

  TBIN_4DIP  : STRUCT
    DIP0  : BOOL;
    DIP1  : BOOL;
    DIP2  : BOOL;
    DIP3  : BOOL;
  END_STRUCT;

  TBIN_4DI : STRUCT
    DI0  : BOOL;
    DI1  : BOOL;
    DI2  : BOOL;
    DI3  : BOOL;
  END_STRUCT;

  TCNTF_IN : STRUCT
    SCNT : UINT;
    VALA : UDINT;
    VALB : UDINT;
  END_STRUCT;

  TCNTF_OUT : STRUCT
    CCNT: UINT; 
    SET : UDINT;
  END_STRUCT;

  TBIN_2DO : STRUCT
    DO0  : BOOL;
    DO1  : BOOL;
  END_STRUCT;

  TBIN_8DO : STRUCT
    DO0  : BOOL;
    DO1  : BOOL;
    DO2  : BOOL;
    DO3  : BOOL;
    DO4  : BOOL;
    DO5  : BOOL;
    DO6  : BOOL;
    DO7  : BOOL;
  END_STRUCT;

  TCHStatistic : STRUCT
    STAT       : USINT;
    ERR        : USINT;
    trueMes    : UDINT;
    falseMes   : UDINT;
  END_STRUCT;

  TETHStatistic_BACnet : STRUCT
    STAT       : USINT;
    ERR        : USINT;
    trueMes    : UDINT;
    falseMes   : UDINT;
  END_STRUCT;

  TCHControl : STRUCT
    CONTROL  : UINT;
  END_STRUCT;

END_TYPE
(* ********************************************************************** *)
(* ---------------------------------------------------------------------- *)
(* CP-1000 *)
VAR_GLOBAL
  r0_p0_Statistic_CH1  AT %X7500 : TCHStatistic;
  r0_p0_Control_CH1    AT %Y7500 : TCHControl;
END_VAR
(* ---------------------------------------------------------------------- *)
(* MI2-01M *)
VAR_GLOBAL
  r0_p2_Statistic_MI_CIB1 AT %X0   : TCHStatistic;
  r0_p2_Control_MI_CIB1 AT %Y0   : TCHControl;
  r0_p2_Statistic_MI_CIB2 AT %X10  : TCHStatistic;
  r0_p2_Control_MI_CIB2 AT %Y2   : TCHControl;
(* alias *)
  MODULE2_IN           AT MI_CIB1_IN.ID1_IN;
  MODULE2_OUT          AT MI_CIB1_OUT.ID1_OUT;
  MODULE3_IN           AT MI_CIB1_IN.ID2_IN;
  MODULE3_OUT          AT MI_CIB1_OUT.ID2_OUT;
  MODULE6_IN           AT MI_CIB1_IN.ID3_IN;
  MODULE6_OUT          AT MI_CIB1_OUT.ID3_OUT;
END_VAR
(* ---------------------------------------------------------------------- *)
(* IR-1061 *)
VAR_GLOBAL
  r0_p5_DI             AT %X20  : TDI_IR1061;
  r0_p5_STPW           AT %X21  : TSTPW;
  r0_p5_AI0            AT %X22  : TAI;
  r0_p5_AI1            AT %X34  : TAI;
  r0_p5_AI2            AT %X46  : TAI;
  r0_p5_AI3            AT %X58  : TAI;
  r0_p5_AIPW           AT %X70  : TAIPW;
  r0_p5_DO             AT %Y4   : TBIN_2DO;
(* alias *)
  MODULE1_IN           AT r0_p5_DI;
  MODULE1_OUT          AT r0_p5_DO;
END_VAR
(* ********************************************************************** *)
(* ---------------------------------------------------------------------- *)
(* IT-1602 *)
VAR_GLOBAL
  r1_p0_AI0            AT %X108 : TAI;
  r1_p0_AI1            AT %X120 : TAI;
  r1_p0_AI2            AT %X132 : TAI;
  r1_p0_AI3            AT %X144 : TAI;
  r1_p0_AI4            AT %X156 : TAI;
  r1_p0_AI5            AT %X168 : TAI;
  r1_p0_AI6            AT %X180 : TAI;
  r1_p0_AI7            AT %X192 : TAI;
  r1_p0_AO0            AT %Y20  : TAO_TC6;
  r1_p0_AO1            AT %Y30  : TAO_TC6;
END_VAR
(* ---------------------------------------------------------------------- *)
(* IR-1501 *)
VAR_GLOBAL
  r1_p1_DI             AT %X86  : TBIN_4DI;
  r1_p1_DIP            AT %X87  : TBIN_4DIP;
  r1_p1_CNT_IN1        AT %X88  : TCNTF_IN;
  r1_p1_CNT_IN2        AT %X98  : TCNTF_IN;
  r1_p1_DO             AT %Y5   : TBIN_8DO;
  r1_p1_dummy          AT %Y6   : USINT;
  r1_p1_CNT_OUT1       AT %Y7   : TCNTF_OUT;
  r1_p1_CNT_OUT2       AT %Y13  : TCNTF_OUT;
(* alias *)
  MODULE4_IN           AT r1_p1_DI;
  MODULE4_OUT          AT r1_p1_DO;
END_VAR
(* -- *)
(* -- *)
VAR_EXTERNAL
END_VAR
(* -- *)

(* ********************************************************************** *)
(* Generated by MOSAIC *)
(* © 2001-2013 Teco a.s. *)
(* Version : 1.2 *)
(* DLL Version : 14.4.0.262 *)
