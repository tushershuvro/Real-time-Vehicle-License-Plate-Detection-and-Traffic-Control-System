function letter=readLetterb(snap)
%READLETTER reads the character fromthe character's binary image.
%   LETTER=READLETTER(SNAP) outputs the character in class 'char' from the
%   input binary image SNAP.

load MyTemplatesb % Loads the templates of characters in the memory.
snap=imresize(snap,[42 24]); % Resize the input image so it can be compared with the template's images.
comp=[ ];
for n=1:length(MyTemplatesb)
    sem=corr2(MyTemplatesb{1,n},snap); % Correlation the input image with every image in the template for best matching.
    comp=[comp sem]; % Record the value of correlation for each template's character.
end
vd=find(comp==max(comp)); % Find the index which correspond to the highest matched character.
%*-*-*-*-*-*-*-*-*-*-*-*-*-
% Accodrding to the index assign to 'letter'.
% benjonborno listings.
if vd==1 
    letter='DHAKA';

elseif vd==2 
    letter='COTTO';
elseif vd==3 
    letter='METRO';
elseif vd==4 
    letter='K';
elseif vd==5 
    letter='KH';
elseif vd==6
    letter='G';
elseif vd==7
    letter='GH';
elseif vd==8
    letter='NG';
elseif vd==9
    letter='C';
elseif vd==10
    letter='CH';
elseif vd==11
    letter='J';
elseif vd==12
    letter='JH';
elseif vd==13
    letter='T';
elseif vd==14
    letter='TH';
elseif vd==15
    letter='D';
elseif vd==16
    letter='DH';
elseif vd==17
    letter='T';
elseif vd==18 
    letter='Th';
elseif vd==19
    letter='d';
elseif vd==20
    letter='dh';
elseif vd==21
    letter='N';
elseif vd==22
    letter='P';
elseif vd==23
    letter='F';
elseif vd==24
    letter='B';
elseif vd==25
    letter='V';
elseif vd==26
    letter='M';
elseif vd==27
    letter='Z';
elseif vd==28
    letter='R';
elseif vd==29
    letter='L';
elseif vd==30
    letter='SH';
elseif vd==31
    letter='S';
elseif vd==32
    letter='H';

    %*-*-*-*-*

% Numerals listings.
elseif vd==33
    letter='1';
elseif vd==34
    letter='2';
elseif vd==35
    letter='3';
elseif vd==36 
    letter='4';
elseif vd==37
    letter='5';
elseif vd==38
    letter='6';
elseif vd==39
    letter='7';
elseif vd==40
    letter='8';
elseif vd==41 
    letter='9';
else
    letter='0';
end
end
