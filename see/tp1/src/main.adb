pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Text_IO, Ada.Integer_Text_IO;
use Text_IO, Ada.Integer_Text_IO;

procedure Main is
   
   task type Simple_Task (Num : Integer) with CPU => 1
   is
      pragma Priority (Num);
      entry Start;
   end;
   
   task body Simple_Task is
      J : Integer := 0;
   begin
      accept Start;
      Put_Line ("Task " & Integer'Image(Num) & " starting");
      for I in 1..100 loop
         for K in 1..10000000 loop
            J := J + 1 mod 500;
         end loop;
         Put_Line(Integer'Image(Num));
      end loop;
      Put_Line ("Task " & Integer'Image(Num) & " ending");
   end Simple_Task;
   
   T1 : Simple_Task(1);
   T2 : Simple_Task(2);
   T3 : Simple_Task(3);
   T4 : Simple_Task(4);
   T5 : Simple_Task(5);
begin
   T1.Start;
   T2.Start;
   T3.Start;
   T4.Start;
   T5.Start;
end;
