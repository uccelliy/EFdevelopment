function [repR,repR2,repR3]=Bcpm5(DataSet1,DataSet2,DataSet3,DataSet4,DataSet5,DataSet6)
prediction_filename = inputname(1);
test_name2=inputname(2);
test_name3=inputname(3);
test_name4=inputname(4);
test_name5=inputname(5);
brain_name=inputname(6);

th = 0.0001;
thresh = th;
[prediction_behav,brain_condition]=coattend5(DataSet1,DataSet6);
behav2 =table2array(coattend5(DataSet2,DataSet6));
behav3 =table2array(coattend5(DataSet3,DataSet6));
behav4 =table2array(coattend5(DataSet4,DataSet6));
behav5 =table2array(coattend5(DataSet5,DataSet6));

all_mats  = table2array(brain_condition);
all_behav = table2array(prediction_behav);
K=10;
time = 20;

no_node = size(all_mats,2);

%% Part1 Repeated prediction
posmaskmat = zeros(no_node,1);
negmaskmat = zeros(no_node,1);
rep_behav_pred = {[]};
rep_behav_pred2 = {[]};
rep_behav_pred3 = {[]};
rep_behav_pred4 = {[]};
rep_behav_pred5 = {[]};

for t = 1:time
    [~,behav_pred2,behav_pred3,behav_pred4,behav_pred5,behav_pred,posmaskall,negmaskall]  = bgpredict_behavior5(behav2,behav3,behav4,behav5,all_mats,all_behav,K,thresh);%%%%%修改
    posmaskmat = posmaskmat+posmaskall;
    negmaskmat = negmaskmat+negmaskall;
    rep_behav_pred{t} = behav_pred;
    rep_behav_pred2{t} = behav_pred2;
    rep_behav_pred3{t} = behav_pred3;
    rep_behav_pred4{t} = behav_pred4;
    rep_behav_pred5{t} = behav_pred5;
end

rep_beh_premat = mean(cell2mat(rep_behav_pred),2);
[repR, ~] = corr(rep_beh_premat,all_behav);
rep_beh_premat2 = mean(cell2mat(rep_behav_pred2),2);
[repR2, ~] = corr(rep_beh_premat2,behav2);
rep_beh_premat3 = mean(cell2mat(rep_behav_pred3),2);
[repR3, ~] = corr(rep_beh_premat3,behav3);
rep_beh_premat4 = mean(cell2mat(rep_behav_pred4),2);
[repR4, ~] = corr(rep_beh_premat4,behav4);
rep_beh_premat5 = mean(cell2mat(rep_behav_pred5),2);
[repR5, ~] = corr(rep_beh_premat5,behav5);

if repR<0
    disp([num2str(thresh) ': negative r value']);
    return
else
    save([prediction_filename '_' brain_name 'posmaskmat','.mat'],'posmaskmat');
    save([prediction_filename '_' brain_name 'negmaskmat','.mat'],'negmaskmat');  
end




%  Permutation
    no_sub = size(all_mats,1);
    % calculate the true prediction correlation
    % number of iterations for permutation testing
    no_iterations   = 1000;

    prediction_r    = zeros(no_iterations,1);
    prediction_r2    = zeros(no_iterations,1);
    prediction_r3    = zeros(no_iterations,1);
    prediction_r4    = zeros(no_iterations,1);
    prediction_r5    = zeros(no_iterations,1);
    
    for it=2:no_iterations
        fprintf('\n Performing iteration %d out of %d', it, no_iterations);
        new_behav        = all_behav(randperm(no_sub));
        new_behav2        = behav2(randperm(no_sub));
        new_behav3        = behav3(randperm(no_sub));
        new_behav4        = behav4(randperm(no_sub));
        new_behav5        = behav5(randperm(no_sub));

        permu_behav_pred = {[]};
        permu_behav_pred2 = {[]};
        permu_behav_pred3 = {[]};
        permu_behav_pred4 = {[]};
        permu_behav_pred5 = {[]};

        for t = 1:time
            [~,behav_pred2,behav_pred3,behav_pred4,behav_pred5,behav_pred,~,~] = bgpredict_behavior5(new_behav2,new_behav3,new_behav4,new_behav5,all_mats,new_behav,K,thresh);%已修改为new_behav
            permu_behav_pred{t} = behav_pred;
            permu_behav_pred2{t} = behav_pred2;
            permu_behav_pred3{t} = behav_pred3;
            permu_behav_pred4{t} = behav_pred4;
            permu_behav_pred5{t} = behav_pred5;

        end
        permu_pred = mean(cell2mat(permu_behav_pred),2);
        [prediction_r(it,1),~] = corr(permu_pred,new_behav);
        permu_pred2 = mean(cell2mat(permu_behav_pred2),2);
        [prediction_r2(it,1),~] = corr(permu_pred2,new_behav2);
        permu_pred3 = mean(cell2mat(permu_behav_pred3),2);
        [prediction_r3(it,1),~] = corr(permu_pred3,new_behav3);
        permu_pred4 = mean(cell2mat(permu_behav_pred4),2);
        [prediction_r4(it,1),~] = corr(permu_pred4,new_behav4);
        permu_pred5 = mean(cell2mat(permu_behav_pred5),2);
        [prediction_r5(it,1),~] = corr(permu_pred5,new_behav5);

    end
    prediction_r(1,1) = repR;
    prediction_r2(1,1) = repR2;
    prediction_r3(1,1) = repR3;
    prediction_r4(1,1) = repR4;
    prediction_r5(1,1) = repR5;

    sorted_prediction_r = sort(prediction_r,'descend');
    sorted_prediction_r2 = sort(prediction_r2,'descend');
    sorted_prediction_r3 = sort(prediction_r3,'descend');
    sorted_prediction_r4 = sort(prediction_r4,'descend');
    sorted_prediction_r5 = sort(prediction_r5,'descend');


    position_pos = find(sorted_prediction_r==repR);
    position_pos2 = find(sorted_prediction_r2==repR2);
    position_pos3 = find(sorted_prediction_r3==repR3);
    position_pos4 = find(sorted_prediction_r4==repR4);
    position_pos5 = find(sorted_prediction_r5==repR5);

    pval_permu              = position_pos(1)/no_iterations;
    pval_permu2              = position_pos2(1)/no_iterations;
    pval_permu3              = position_pos3(1)/no_iterations;
    pval_permu4              = position_pos4(1)/no_iterations;
    pval_permu5              = position_pos5(1)/no_iterations;

    res_rp  = [repR,pval_permu];
    res_rp2  = [repR2,pval_permu2];
    res_rp3  = [repR3,pval_permu3];
    res_rp4  = [repR4,pval_permu4];
    res_rp5  = [repR5,pval_permu5];

    save([prediction_filename '_' brain_name 'r_p.mat'],'res_rp');
    save([prediction_filename '_' test_name2 '_' brain_name 'r_p2.mat'],'res_rp2');
    save([prediction_filename '_' test_name3 '_' brain_name 'r_p3.mat'],'res_rp3');
    save([prediction_filename '_' test_name4 '_' brain_name 'r_p4.mat'],'res_rp4');
    save([prediction_filename '_' test_name5 '_' brain_name 'r_p5.mat'],'res_rp5');
end
    %
