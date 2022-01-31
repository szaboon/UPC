function result =plotbox(Target,Template,M);
%
%By Alaa Eleyan May,2008
%*********************************************************
[r1,c1]=size(Search_img);
[r2,c2]=size(Template);

[~,c]=max(M);
[~,c3]=max(max(M));

i=c(c3);    % Number of row with max. correlation
j=c3;       % Number of column with max. correlation
% result=Target;

x = i;
y = j;
X = i+r2-1;
Y = j+c2-1;

result = [x,y,X,Y];

% for x=i:i+r2-1
%    for y=j
%        result(x,y)=255;
%    end
% end
% for x=i:i+r2-1
%    for y=j+c2-1
%        result(x,y)=255;
%    end
% end
% for x=i
%    for y=j:j+c2-1
%        result(x,y)=255;
%    end
% end
% for x=i+r2-1
%    for y=j:j+c2-1
%        result(x,y)=255;
%    end
% end