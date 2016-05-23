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

  TETHStatistic_UNI : STRUCT
    STAT       : USINT;
    ERR        : USINT;
    trueMes    : UDINT;
    falseMes   : UDINT;
  END_STRUCT;

  TCHControl : STRUCT
    CONTROL  : UINT;
  END_STRUCT;

  TETHControl_UNI : STRUCT
    CONTROL  : UINT;
  END_STRUCT;

  TUniStat : STRUCT
    DSR    : BOOL;
    CTS    : BOOL;
    dummy1 {HIDDEN} : BOOL;
    TRO    : BOOL;
    RCF    : BOOL;
    ROV    : BOOL;
    TRF    : BOOL;
    ARC    : BOOL;
  END_STRUCT;

  TUniCont : STRUCT
    dummy0 {HIDDEN} : BOOL;
    dummy1 {HIDDEN} : BOOL;
    dummy2 {HIDDEN} : BOOL;
    dummy3 {HIDDEN} : BOOL;
    dummy4 {HIDDEN} : BOOL;
    TRG    : BOOL;
    CLR    : BOOL;
    ACN    : BOOL;
  END_STRUCT;

  TUniSign : STRUCT
    DTR : BOOL;
    RTS : BOOL;
  END_STRUCT;

END_TYPE
(* ********************************************************************** *)
(* ---------------------------------------------------------------------- *)
(* CP-1000 *)
TYPE
  TETHStatistic_UNI0 : STRUCT
    STAT : USINT;
    ERR : USINT;
    trueMes : UDINT;
    falseMes : UDINT;
  END_STRUCT;
END_TYPE

TYPE
  TETHControl_UNI0 : STRUCT
    CONTROL : UINT ;
  END_STRUCT;
END_TYPE

TYPE
  TUNI_ETH1_IN0 : STRUCT
    STAT : TUniStat;
    ERR : USINT;
    NUMR : UINT ;
    DATA : ARRAY [0..99] OF USINT;
  END_STRUCT;
END_TYPE

TYPE
  TUNI_ETH1_OUT0 : STRUCT
    CONT : TUniCont;
    SIGN : TUniSign;
    NUMT : UINT ;
    DATA : ARRAY [0..255] OF USINT;
  END_STRUCT;
END_TYPE

VAR_GLOBAL
  r0_p0_Statistic_CH1  AT %X7500 : TCHStatistic;
  r0_p0_Control_CH1    AT %Y7500 : TCHControl;
  r0_p0_Statistic_ETH1_UNI0 AT %X7640 : TETHStatistic_UNI0;
  r0_p0_Control_ETH1_UNI0 AT %Y7624 : TETHControl_UNI0;
  UNI_ETH1_IN0         : TUNI_ETH1_IN0;
  UNI_ETH1_OUT0        : TUNI_ETH1_OUT0;
(* alias *)
  ETH1_UNI0_IN         AT UNI_ETH1_IN0.DATA;
  ETH1_UNI0_OUT        AT UNI_ETH1_OUT0.DATA;
END_VAR
(* ---------------------------------------------------------------------- *)
(* MI2-01M *)
VAR_GLOBAL
  r0_p2_Statistic_MI_CIB1 AT %X0   : TCHStatistic;
  r0_p2_Control_MI_CIB1 AT %Y0   : TCHControl;
  r0_p2_Statistic_MI_CIB2 AT %X10  : TCHStatistic;
  r0_p2_Control_MI_CIB2 AT %Y2   : TCHControl;
(* alias *)
  button_15_1_16_1     AT MI_CIB1_IN.ID1_IN.DI.DI7;
  button_15_2_16_2     AT MI_CIB1_IN.ID1_IN.DI.DI8;
  button_24_1          AT MI_CIB1_IN.ID1_IN.DI.DI6;
  light_05             AT MI_CIB1_OUT.ID1_OUT.DOs.DO11;
  light_09             AT MI_CIB1_OUT.ID1_OUT.DOs.DO4;
  light_10_13_22       AT MI_CIB1_OUT.ID1_OUT.DOs.DO7;
  light_11_12_21       AT MI_CIB1_OUT.ID1_OUT.DOs.DO8;
  light_15             AT MI_CIB1_OUT.ID1_OUT.DOs.DO3;
  light_17_19_level    AT MI_CIB1_OUT.ID2_OUT.OUT1.LEVEL;
  light_18_mirror      AT MI_CIB1_OUT.ID1_OUT.DOs.DO1;
  MODULE2_IN           AT MI_CIB1_IN.ID1_IN;
  MODULE2_OUT          AT MI_CIB1_OUT.ID1_OUT;
  MODULE3_IN           AT MI_CIB1_IN.ID2_IN;
  MODULE3_OUT          AT MI_CIB1_OUT.ID2_OUT;
  MODULE6_IN           AT MI_CIB1_IN.ID3_IN;
  MODULE6_OUT          AT MI_CIB1_OUT.ID3_OUT;
  msensor05            AT MI_CIB1_IN.ID1_IN.DI.DI1;
  msensor06            AT MI_CIB1_IN.ID1_IN.DI.DI2;
  msensor07            AT MI_CIB1_IN.ID1_IN.DI.DI3;
  msensor08            AT MI_CIB1_IN.ID1_IN.DI.DI4;
  msensor09            AT MI_CIB1_IN.ID1_IN.DI.DI5;
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
  light_01_08_23_24    AT r0_p5_DO.DO0;
  light_03_04          AT r0_p5_DO.DO1;
  MODULE1_IN           AT r0_p5_DI;
  MODULE1_OUT          AT r0_p5_DO;
  msensor01            AT r0_p5_DI.DI0;
  msensor02            AT r0_p5_DI.DI1;
  msensor03            AT r0_p5_DI.DI2;
  msensor04            AT r0_p5_DI.DI3;
END_VAR
(* ********************************************************************** *)
(* ---------------------------------------------------------------------- *)
(* IR-1501 *)
VAR_GLOBAL
  r1_p0_DI             AT %X108 : TBIN_4DI;
  r1_p0_DIP            AT %X109 : TBIN_4DIP;
  r1_p0_CNT_IN1        AT %X110 : TCNTF_IN;
  r1_p0_CNT_IN2        AT %X120 : TCNTF_IN;
  r1_p0_DO             AT %Y20  : TBIN_8DO;
  r1_p0_dummy          AT %Y21  : USINT;
  r1_p0_CNT_OUT1       AT %Y22  : TCNTF_OUT;
  r1_p0_CNT_OUT2       AT %Y28  : TCNTF_OUT;
(* alias *)
  button_09_1_10_2_17_1 AT r1_p0_DI.DI2;
  button_09_2_09_3_11_1_12_1_13_1_14_1_17_2 AT r1_p0_DI.DI0;
  button_20_1_21_1     AT r1_p0_DI.DI1;
  FH_01                AT r1_p0_DO.DO0;		(*floorHeating*)
  FH_02                AT r1_p0_DO.DO1;		(*floorHeating*)
  MODULE7_IN           AT r1_p0_DI;
  MODULE7_OUT          AT r1_p0_DO;
  waterLeakageSensor   AT r1_p0_DI.DI3;
END_VAR
(* floorHeating		r1_p0_DO.DO0 *)
(* floorHeating		r1_p0_DO.DO1 *)
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
  button_04_1          AT r1_p1_DI.DI3;
  button_07_1_08_1     AT r1_p1_DI.DI1;
  button_20_2_22_1     AT r1_p1_DI.DI2;
  electricitySwitch    AT r1_p1_DO.DO5;
  light_02_06_07       AT r1_p1_DO.DO1;
  light_14_16          AT r1_p1_DO.DO0;
  light_balcony        AT r1_p1_DO.DO3;
  MODULE4_IN           AT r1_p1_DI;
  MODULE4_OUT          AT r1_p1_DO;
  waterValve           AT r1_p1_DO.DO7;
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
