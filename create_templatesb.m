%CREATE TEMPLATES
%benjonborno
A=imread('charimagesb\k.bmp');B=imread('charimagesb\kh.bmp');
C=imread('charimagesb\g.bmp');D=imread('charimagesb\gh.bmp');
E=imread('charimagesb\Ng.bmp');F=imread('charimagesb\c.bmp');
G=imread('charimagesb\ch.bmp');H=imread('charimagesb\j.bmp');
I=imread('charimagesb\jh.bmp');J=imread('charimagesb\t1.bmp');
K=imread('charimagesb\th1.bmp');L=imread('charimagesb\D.bmp');
M=imread('charimagesb\Dh.bmp');N=imread('charimagesb\T.bmp');
O=imread('charimagesb\Th.bmp');P=imread('charimagesb\d1.bmp');
Q=imread('charimagesb\dh1.bmp');R=imread('charimagesb\n.bmp');
S=imread('charimagesb\p.bmp');T=imread('charimagesb\f.bmp');
U=imread('charimagesb\b.bmp');V=imread('charimagesb\v.bmp');
W=imread('charimagesb\m.bmp');X=imread('charimagesb\z.bmp');
Y=imread('charimagesb\r.bmp');Z=imread('charimagesb\l.bmp');
Z_sh=imread('charimagesb\sh.bmp');Z_s=imread('charimagesb\s.bmp');
Z_h=imread('charimagesb\h.bmp');
dhaka=imread('charimagesb\dhaka.bmp'); cotto=imread('charimagesb\cotto.bmp');
metro=imread('charimagesb\metro.bmp');




%Number
one=imread('charimagesb\1.bmp');  two=imread('charimagesb\2.bmp');
three=imread('charimagesb\3.bmp');four=imread('charimagesb\4.bmp');
five=imread('charimagesb\5.bmp'); six=imread('charimagesb\6.bmp');
seven=imread('charimagesb\7.bmp');eight=imread('charimagesb\8.bmp');
nine=imread('charimagesb\9.bmp'); zero=imread('charimagesb\0.bmp');


%*-*-*-*-*-*-*-*-*-*-*-
benjonborno =[A B C D E F G H I J K L M...
    N O P Q R S T U V W X Y Z Z_sh Z_s Z_h dhaka cotto metro ];



number =[one two three four five...
    six seven eight nine zero];


character=[benjonborno  number];


MyTemplatesb =mat2cell(character,42,[ 24 24 24 24 24 24 24  ...
            24 24 24 24 24 24 24 ...
            24 24 24 24 24 24 24 ...
            24 24 24 24 24 24 24 ...
            24 24 24 24 24 24 24 ...
            24 24 24 24 24 24 24 ...
            ]);



save ('MyTemplatesb','MyTemplatesb')

clear all