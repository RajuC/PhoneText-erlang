# PhoneText-erlang
Generate the list of all the different mnenonics associated to a number




When given a phone number, is able to generate the list of all the different mnenonics associated to this number.

Simple program to  get Phone Texts from the  dictionary of words(linuxwords.txt) when a number is entered.

To compile the above program

Eshell V5.10.4  (abort with ^G)

1> c(phone_text).
{ok,phone_text}

2> phone_text:getPhoneText(228).

Text List ::["cat","bat","act","abu"]
ok

3> phone_text:getPhoneText(4663).

Text List ::["hoof","hood","hone","home","goof","good","gone"]
ok
4> 






