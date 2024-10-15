ll=length(db);
for k = 1: ll
    str3=db(k,5);
    str3=str3{1,1};
    index=find(strcmp(atlas_num(:,4),str3)==1);
    index_num=atlas_num(index,1);
    db(k,6)=index_num;
end

