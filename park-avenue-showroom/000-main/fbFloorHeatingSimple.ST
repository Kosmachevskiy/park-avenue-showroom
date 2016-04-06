FUNCTION_BLOCK fbFloorHeatingSimple
  VAR_INPUT
       period : time := t#1h;
  END_VAR
  VAR_OUTPUT
      out : bool;
  END_VAR
  VAR_IN_OUT
       state : bool;
       power : real;
  END_VAR
  VAR
       pwmGenerator : PWM;
  END_VAR
  VAR_TEMP
  END_VAR

       pwmGenerator(Enb := state, Per := period, Pls := power, Out =>  out);

END_FUNCTION_BLOCK
