-module(phone_text).
-export([getPhoneText/1]).
-define(NUMBERS,[{"1",""},{"2","abc"},{"3","def"},{"4","ghi"},{"5","jkl"},{"6","mno"},{"7","pqrs"},{"8","tuv"},{"9","wxyz"},{"0",""}]).

getPhoneText(Number) ->
	Num=numStr(Number), % to check the entered number is string or a integer and convert to string
	ValueList=getValueFromNumList(Num,[]), % to get all the combinations of the entered number
	{ok,Bin} = file:read_file("linuxwords.txt"),
	StringListConvLower = [string: to_lower(X) ||X<- string:tokens(erlang:binary_to_list(Bin),"\n")],
	TextList=getText(ValueList,StringListConvLower,[]), % return the mnemonics list which matches the mnemonics given in the file (linuxwords.txt)
	io:format("Text List ::~p~n",[TextList]).	

getText([],_,MnemonicsList) ->
	MnemonicsList;
getText([H|T],StringListConvLower,Value) ->
	case lists:member(H,StringListConvLower) of
		true ->
			getText(T,StringListConvLower,[H|Value]);
		_ ->
			getText(T,StringListConvLower,Value)
	end.

getValueFromNumList([],Value) ->
	Value;
getValueFromNumList([H|Rest],Value) ->
	{_,NumValue} = lists:keyfind([H],1,?NUMBERS),	
	{ok,ValueList}=combineStr(NumValue,Value),
	getValueFromNumList(Rest,ValueList).

combineStr(String1,String2) ->
	if (String1=:="") and (String2 =:="") ->
		{ok,[]};
	true ->	
		if (String1=/="") and (String2 =:="") ->		
			{ok,String1};
		true ->
			if (String1=:="") and (String2 =/="") ->
				{ok,String2};
			true ->
				{ok,[lists:flatten([X,Y])|| X <- String2,Y <- String1]}
			end
		end			
	end.

numStr(Number) ->
	if erlang:is_integer(Number) ->
		erlang:integer_to_list(Number);
	true ->		
		Number
	end.
