function [ge,be]=dispose(file_name,file_name2)
file_name_="_"+file_name;
be=readtable(file_name2);
ge=readtable(file_name);
ge_sub=ge.IID;
be_sub=be.IID;
results = cellfun(@(x) strsplit(x, '_'), ge_sub,'UniformOutput', false);
ge_sub_ = cellfun(@(x) ['NDAR_' x{end}], results, 'UniformOutput', false);
[~,ia,ib] = intersect(be_sub,ge_sub_);

ge=ge(ib,:);
be=be(ia,:);

writetable(ge,file_name_,"Delimiter","tab");
%writetable(be,file_name2,"Delimiter","tab");
end



