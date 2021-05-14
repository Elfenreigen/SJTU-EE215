clc;
clear;
tic;

Population = 100;      %��Ⱥ��ʼ��ģ
Pvariation = 0.001;    %����������
Iteration  = 80;       %����������
currentIteration = 1;  %��ǰ��������

currentPopulation = randi([0,1], Population, 90);  %��Ⱥ�����ʼ��
costRecord = zeros(Iteration, 1);                  %��¼ÿ�ε����ĳɱ�

while(currentIteration <= Iteration)               %����������С������������
    Adaptation = zeros(Population, 1);             %��Ӧ�Ⱥ���
    
    for i = 1:Population
        Adaptation(i) = costofallsample(currentPopulation(i,:));   %��ǰ������������Ⱥ��ÿ������ĳɱ�
    end
     
    costRecord(currentIteration) = min(Adaptation);                %��¼��ǰ������������Ⱥ����С����ĳɱ�
    Adaptation = 1./ Adaptation.^3;                                %��Ӧ��=�ɱ�ƽ���ĵ���
   

    elite = find(Adaptation == max(Adaptation));                   %��Ӣ����
    nextPopulation = zeros(Population, 90);                        %nextPopulationΪ��һ������Ⱥ���
    nextPopulation(1, :) = currentPopulation(elite(1), :);         %ǰ������Ϊ��Ӣ����
    nextPopulation(2, :) = currentPopulation(elite(1), :);
    
    
    for i = 2:Population
        Adaptation(i) = Adaptation(i) + Adaptation(i - 1);         %���̶ķ���i����ȷ��ÿ�����屻ѡ�еĶ�Ӧ���䣬���ۼ���Ӧ��
    end
    
    select = zeros(Population, 1);                                 %select�����ʾÿ�����屻ѡ�еĴ���
    
    for i = 1:Population - 2
        tmp = find((Adaptation / Adaptation(Population))>=rand()); %���̶ķ���ii):tmp��¼������Ӧ�ȴ������ֵ�ĸ���
        select(tmp(1)) = select(tmp(1)) + 1;                       %���̶ķ���iii):����ÿ��ѡ��һ�Σ���selectֵ��һ������������Ӣ�����������
    end
    
                                                                   %����
    startrow = 3;                                                  %����Ⱥ��ǰ���������Ϊ��һ������Ӧ����ߵģ��������Ӵ��ӵ����п�ʼ��
    while (sum(select) ~= 0)                                 
        a = find(select);                                          %�ҳ����б�ѡ�еĸ��壬��Ϊa����
        b = randi(length(a));                                      %bΪa����ѡһ��������±�
        dad = a(b);                                                %dadΪ��ѡ�и�������ѡ���Ǹ�
        b = randi(length(a));
        mom = a(b);
         
        select(dad) = select(dad) - 1;                             %Ϊ�˱�֤���б�ѡ�и��嶼���뽻�棬Ϊ�˹�ƽ������һ�Σ���select������ȥһ
        select(mom) = select(mom) - 1;
        
        location = randi(89);                                      %��ʼ���棬����������
        nextPopulation(startrow, 1:location) = currentPopulation(dad, 1:location);               %ͨ�����㽻�棬ÿ�β����������Ӵ�
        nextPopulation(startrow, (location + 1):90) = currentPopulation(mom, (location + 1):90); %ǰ�벻�䣬��뽻��
        nextPopulation(startrow + 1, 1:location) = currentPopulation(mom, 1:location);
        nextPopulation(startrow + 1, (location + 1):90) = currentPopulation(dad, (location + 1):90);
        startrow = startrow + 2;                                                                 %ͨ�����㽻�棬ÿ�β����������Ӵ�
    end
    
    mutation = rand(Population, 90) < Pvariation;                  %��ʼ���죬�����ֵС����ֵ����ʼ���죬mutation����Ķ�Ӧ��ֵΪ1
    nextPopulation = abs(mutation - nextPopulation);               %��Ӧ����Ļ����ͷ�ת����0��1����
    currentPopulation = nextPopulation;                            %��һ���ݽ�Ϊ����
    currentIteration                                               
    currentIteration = currentIteration + 1;                       %��ʼ��һ�ε�������
end

lastCost = zeros(Population, 1);                                   %��¼������Ⱥ��ÿ������ĳɱ�

for i = 1:Population
    lastCost(i) = costofallsample(currentPopulation(i, :));        %����������Ⱥÿ������ĳɱ�
end

finalCost = min(lastCost)                                          %�ҳ����յ�������С�ɱ��ĸ��壬�����С�ɱ�
chosenIndividual = currentPopulation(lastCost == finalCost,:);     %�ҳ����յ�������С�ɱ��ĸ��壬�ҳ��������
chosenPoint = find(chosenIndividual(1, :)) - 20                    %�ҳ����յ�������С�ɱ��ĸ��壬�������Ϊ1�ı�ţ����ǵ��������Ǵ�-20��ʼ�ģ��ʼ�ȥ20
toc;

figure;                                                            %���Ƴ�����������-������С�ɱ����ĺ���ͼ��
plot(1:currentIteration-1, costRecord);
title('Relationship between Times And Cost');
xlabel('Times of Iteration');
ylabel('Cost');