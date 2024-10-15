function [R1,behav_pred2,behav_pred3,behav_pred4,behav_pred5,behav_pred,posmaskall,negmaskall]  = bgpredict_behavior5(behav2,behav3,behav4,behav5,all_mats,all_behav,K,thresh)%%输出修改
%%%%%%%%%%%%%%%%%%%%%% by CCH
% ------------ INPUTS -------------------
[no_sub,no_node]= size(all_mats);
behav_pred = zeros(no_sub,1);
behav_pred2 = zeros(no_sub,1);
behav_pred3 = zeros(no_sub,1);
behav_pred4 = zeros(no_sub,1);
behav_pred5 = zeros(no_sub,1);


posmaskall = zeros(no_node,1);
negmaskall = zeros(no_node,1);

%% K fold CV
indices = crossvalind('Kfold',length(all_behav),K);
for j = 1:K
    disp(['The ' num2str(j) ' fold!']);
    test = find(indices == j);
    train_mats = all_mats;     train_mats(test,:) = [];
    train_behav = all_behav;   train_behav(test) = [];
    all_behav2 = behav2;       all_behav2(test) = [];
    all_behav3 = behav3;       all_behav3(test) = [];
    all_behav4 = behav4;       all_behav4(test) = [];
    all_behav5 = behav5;       all_behav5(test) = [];
    test_mats = all_mats(test,:);

    %标准化
    mean_train_mats = mean(train_mats);
    std_train_mats = std(train_mats);
    train_mats = (train_mats-mean_train_mats)./std_train_mats;
    test_mats = (test_mats-mean_train_mats)./std_train_mats;

    %对于其他行为的预测
    % correlate all edges with behavior
    [r_mat,p_mat] = corr(train_mats,train_behav);
    % set threshold and define masks
    pos_mask  = r_mat > 0 & p_mat < thresh;
    neg_mask = r_mat < 0 & p_mat < thresh;
    % get sum of selected edges in TRAIN subs
    train_sumpos=train_mats*pos_mask;
    train_sumneg=train_mats*neg_mask;
    % build model on TRAIN subs combining both postive and negative features
    b = regress(train_behav, [train_sumpos, train_sumneg, ones(length(train_behav),1)]);
    b2 = regress(all_behav2, [train_sumpos, train_sumneg, ones(length(train_behav),1)]);
    b3 = regress(all_behav3, [train_sumpos, train_sumneg, ones(length(train_behav),1)]);
    b4 = regress(all_behav4, [train_sumpos, train_sumneg, ones(length(train_behav),1)]);
    b5 = regress(all_behav5, [train_sumpos, train_sumneg, ones(length(train_behav),1)]);
%     b6 = regress(all_behav6, [train_sumpos, train_sumneg, ones(length(train_behav),1)]);
    % run model on TEST sub
    behav_pred(test)=[test_mats*pos_mask test_mats*neg_mask ones(length(test),1)]*b;
    behav_pred2(test)=[test_mats*pos_mask test_mats*neg_mask ones(length(test),1)]*b2;
    behav_pred3(test)=[test_mats*pos_mask test_mats*neg_mask ones(length(test),1)]*b3;
    behav_pred4(test)=[test_mats*pos_mask test_mats*neg_mask ones(length(test),1)]*b4;
    behav_pred5(test)=[test_mats*pos_mask test_mats*neg_mask ones(length(test),1)]*b5;
%     behav_pred6(test)=[test_mats*pos_mask test_mats*neg_mask ones(length(test),1)]*b6;
    posmaskall = posmaskall+pos_mask;
    negmaskall = negmaskall+neg_mask;
end
[R1, ~] = corr(behav_pred,all_behav);

% save('behav_pred.mat','behav_pred');
end
% figure(1); plot(behav_pred_pos,all_behav,'r.'); lsline
% figure(2); plot(behav_pred_neg,all_behav,'b.'); lsline