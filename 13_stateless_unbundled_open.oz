local Dic in
   local
      fun {NewDicc} nil end

      fun {Put T K V}
         case T
         of nil then tree(K V {NewDicc} {NewDicc})
         [] tree(X Y T1 T2) andthen K == X then
            tree(X Y + V T1 T2)
         [] tree(X Y T1 T2) andthen K < X then
            tree(X Y {Put T1 K V} T2)
         [] tree(X Y T1 T2) andthen K > X then
            tree(X Y T1 {Put T2 K V})
         end
      end

      fun {Get T K}
         case T
         of nil then 0
         [] tree(X Y T1 T2) andthen K == X then Y
         [] tree(X Y T1 T2) andthen K < X then {Get T1 K}
         [] tree(X Y T1 T2) andthen K > X then {Get T2 K}
         end
      end

      fun {Equals X Y}
         {Sort {VirtualString.toString {Value.toVirtualString X 0 0} } Value.'<'} ==
         {Sort {VirtualString.toString {Value.toVirtualString Y 0 0} } Value.'<'}
      end
   in
      Dic = dic(new:NewDicc put:Put get:Get equals:Equals)
   end

   local StringToDic Anagramas Str1 Str2 Str3 Str4 Str5 Str6 Str7 Str8 Str9 in
      fun {StringToDic D S}
         case S of nil then D
         [] H|T then {Dic.put {StringToDic D T} H 1}
         else {Dic.put D S 1} end
      end

      fun {Anagramas S1 S2}
         {Dic.equals {StringToDic {Dic.new} S1} {StringToDic {Dic.new} S2}}
      end

      {Browse 'Anagram tests'}
      Str1 = "RAMON"
      Str2 = "ABILA"
      Str3 = "LIVES"
      Str4 = "ELVIS"
      Str5 = "PODER"
      Str6 = "PEDRO"
      Str7 = "OOP"
      Str8 = "POO"
      Str9 = "OP"
      {Browse {Anagramas Str1 Str2}} % Debe ser false.
      {Browse {Anagramas Str1 Str3}} % Debe ser false.
      {Browse {Anagramas Str3 Str4}} % Debe ser true.
      {Browse {Anagramas Str5 Str6}} % Debe ser true.
      {Browse {Anagramas Str5 Str3}} % Debe ser false.
      {Browse {Anagramas Str7 Str8}} % Debe ser true.
      {Browse {Anagramas Str7 Str9}} % Debe ser false.

      {Browse 'Other tests'}
      {Browse {Dic.get {Dic.put {Dic.new} 5 '5'} 5}} % Debe ser '5'.
      {Browse {Dic.equals {Dic.put {Dic.new} 5 '5'} {Dic.new}}} % Debe ser false.
      {Browse {Dic.equals {Dic.put {Dic.new} 5 '5'} {Dic.put {Dic.new} 5 '5'}}} % Debe ser true.
   end
end