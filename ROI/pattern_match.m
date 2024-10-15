len=length(fmri_brain(:,5));
len1=length(tmp);
for i = 1: len
    num=1;
    str1=fmri_brain(i,5);
    str1=str1{1,1};
    str1=lower(str1);
    str1=erase(str1,'_');
    end1=str1(end);
    if(~isletter(end1))
        end1=str2double(end1);
        num=num+end1;
        str1=str1(1:end-1);
    end
    result_cell={};
    n=1;
    for j = 1:len1 
        str2=tmp(j,2);
        str2=str2{1,1};
        str2=lower(str2);
        str2=erase(str2,'-');
        str2=erase(str2,' ');
        str2=erase(str2,'"');
        str2=erase(str2,'.');
        str2=erase(str2,',');
        rt1=strfind(str2,str1);
        if(rt1==1)
            result_cell{n,1}=str2;
            n=n+1;
        end
    end
    str2=result_cell(num,1);
    fmri_brain{i,6}=str2;
end



