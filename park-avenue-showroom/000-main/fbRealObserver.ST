FUNCTION_BLOCK fbRealObserver
  VAR_INPUT
	  value        : real;
  END_VAR
  VAR
      prevValue : real;
  END_VAR
  VAR_OUTPUT
      valueChanged : bool;
      rising       : bool;
      falling      : bool;
  END_VAR
      valueChanged := false;
      rising       := false;
      falling      := false;

      if value <> prevValue then
         valueChanged := true;
         if value > prevValue then
            rising := true;
         else
            falling := true;
         end_if;
         prevValue := value;
      end_if;
END_FUNCTION_BLOCK
