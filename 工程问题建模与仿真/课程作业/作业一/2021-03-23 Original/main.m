clc;
clear;
tic;

Population = 100;      %种群初始规模
Pvariation = 0.001;    %基因变异概率
Iteration  = 80;       %最大迭代次数
currentIteration = 1;  %当前迭代次数

currentPopulation = randi([0,1], Population, 90);  %种群情况初始化
costRecord = zeros(Iteration, 1);                  %记录每次迭代的成本

while(currentIteration <= Iteration)               %当迭代次数小于最大迭代次数
    Adaptation = zeros(Population, 1);             %适应度函数
    
    for i = 1:Population
        Adaptation(i) = costofallsample(currentPopulation(i,:));   %当前迭代次数下种群内每个个体的成本
    end
     
    costRecord(currentIteration) = min(Adaptation);                %记录当前迭代次数下种群内最小个体的成本
    Adaptation = 1./ Adaptation.^3;                                %适应度=成本平方的倒数
   

    elite = find(Adaptation == max(Adaptation));                   %精英保留
    nextPopulation = zeros(Population, 90);                        %nextPopulation为下一代的种群情况
    nextPopulation(1, :) = currentPopulation(elite(1), :);         %前两行因为精英保留
    nextPopulation(2, :) = currentPopulation(elite(1), :);
    
    
    for i = 2:Population
        Adaptation(i) = Adaptation(i) + Adaptation(i - 1);         %轮盘赌法（i）：确定每个个体被选中的对应区间，即累加适应度
    end
    
    select = zeros(Population, 1);                                 %select矩阵表示每个个体被选中的次数
    
    for i = 1:Population - 2
        tmp = find((Adaptation / Adaptation(Population))>=rand()); %轮盘赌法（ii):tmp记录所有适应度大于随机值的个体
        select(tmp(1)) = select(tmp(1)) + 1;                       %轮盘赌法（iii):个体每被选中一次，其select值加一。除了两个精英，都参与此轮
    end
    
                                                                   %交叉
    startrow = 3;                                                  %新种群中前两个个体均为上一代中适应度最高的，所以新子代从第三行开始。
    while (sum(select) ~= 0)                                 
        a = find(select);                                          %找出所有被选中的个体，记为a矩阵
        b = randi(length(a));                                      %b为a中任选一个个体的下标
        dad = a(b);                                                %dad为被选中个体中任选的那个
        b = randi(length(a));
        mom = a(b);
         
        select(dad) = select(dad) - 1;                             %为了保证所有被选中个体都参与交叉，为了公平，参与一次，其select次数减去一
        select(mom) = select(mom) - 1;
        
        location = randi(89);                                      %开始交叉，产生交换点
        nextPopulation(startrow, 1:location) = currentPopulation(dad, 1:location);               %通过单点交叉，每次产生两个新子代
        nextPopulation(startrow, (location + 1):90) = currentPopulation(mom, (location + 1):90); %前半不变，后半交叉
        nextPopulation(startrow + 1, 1:location) = currentPopulation(mom, 1:location);
        nextPopulation(startrow + 1, (location + 1):90) = currentPopulation(dad, (location + 1):90);
        startrow = startrow + 2;                                                                 %通过单点交叉，每次产生两个新子代
    end
    
    mutation = rand(Population, 90) < Pvariation;                  %开始变异，当随机值小于阈值，开始变异，mutation矩阵的对应数值为1
    nextPopulation = abs(mutation - nextPopulation);               %对应基因的基因型翻转，即0、1互换
    currentPopulation = nextPopulation;                            %下一代递进为当代
    currentIteration                                               
    currentIteration = currentIteration + 1;                       %开始下一次迭代工作
end

lastCost = zeros(Population, 1);                                   %记录最终种群中每个个体的成本

for i = 1:Population
    lastCost(i) = costofallsample(currentPopulation(i, :));        %计算最终种群每个个体的成本
end

finalCost = min(lastCost)                                          %找出最终迭代后最小成本的个体，输出最小成本
chosenIndividual = currentPopulation(lastCost == finalCost,:);     %找出最终迭代后最小成本的个体，找出其基因型
chosenPoint = find(chosenIndividual(1, :)) - 20                    %找出最终迭代后最小成本的个体，输出基因为1的编号，考虑到表格里的是从-20开始的，故减去20
toc;

figure;                                                            %绘制出“迭代次数-当此最小成本”的函数图像
plot(1:currentIteration-1, costRecord);
title('Relationship between Times And Cost');
xlabel('Times of Iteration');
ylabel('Cost');