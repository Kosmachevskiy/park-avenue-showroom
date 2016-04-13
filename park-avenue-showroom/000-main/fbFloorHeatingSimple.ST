FUNCTION_BLOCK fbFloorHeatingSimple
  VAR_INPUT
       period : time := t#30m;
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

       pwmGenerator(Enb := true, Per := period, Pls := power, Out =>  out);
       
       if state then
          out := pwmGenerator.Out;
       else
          out := false;
       end_if;

END_FUNCTION_BLOCK
